-- https://developer.aliyun.com/article/8532
-- https://github.com/xiexianbin/openresty-demo/blob/master/lua/aliyun/oss_auth.lua
-- has been sorted in alphabetical order
local signed_subresources = {
  'acl',
  'append',
  'bucketInfo',
  'cname',
  'commitTransition',
  'comp',
  'cors',
  'delete',
  'lifecycle',
  'location',
  'logging',
  'mime',
  'notification',
  'objectInfo',
  'objectMeta',
  'partData',
  'partInfo',
  'partNumber',
  'policy',
  'position',
  'referer',
  'replication',
  'replicationLocation',
  'replicationProgress',
  'requestPayment',
  'response-cache-control',
  'response-content-disposition',
  'response-content-encoding',
  'response-content-language',
  'response-content-type',
  'response-expires',
  'restore',
  'security-token',
  'tagging',
  'torrent',
  'uploadId',
  'uploads',
  'versionId',
  'versioning',
  'versions',
  'website'
}
  
function string.startswith(s, start)
  return string.sub(s, 1, string.len(start)) == start
end

local function get_canon_sub_resource()
  local args = ngx.req.get_uri_args()
  -- lower keys
  local keys = {}
  for k, v in pairs(args) do
    keys[k:lower()] = v
  end
  -- make resource string
  local s = ''
  local sep = '?'
  for i, k in ipairs(signed_subresources) do
    local v = keys[k]
    if v then
      -- sub table
      v = type(v) == 'table' and v[1] or v
      s = s .. string.format("%s%s=%s", sep, k, v)
      sep = '&'
    end
  end
  return s
end

local function get_canon_resource()
  local object = ngx.unescape_uri(ngx.var.uri)
  local sub = get_canon_sub_resource()
  return string.format("/%s%s%s", ngx.var.oss_bucket, object, sub)
end

local function get_canon_headers()
  -- default: <lowerkey, value>
  local headers = ngx.req.get_headers()
  local keys = {}
  for k, v in pairs(headers) do
    if string.startswith(k, 'x-oss-') then
      -- client must assemble the same header keys
      if type(v) ~= 'string' then return nil end
      table.insert(keys, k)
    end
  end
  -- sorted in alphabetical order
  table.sort(keys)
  for i, key in ipairs(keys) do
    keys[i] = key .. ':' .. headers[key] .. '\n'
  end
  return table.concat(keys)
end

local function calc_sign(key, method, md5, type_, date, oss_headers, resource)
  -- string_to_sign:
  -- method + '\n' + content_md5 + '\n' + content_type + '\n'
  -- + date + '\n' + canonicalized_oss_headers + canonicalized_resource
  local sign_str = string.format('%s\n%s\n%s\n%s\n%s%s',
    method, md5, type_,
    date, oss_headers, resource)
  -- ngx.log(ngx.ERR, "SignStr: ", sign_str, "\n")
  local sign_result = ngx.encode_base64(ngx.hmac_sha1(key, sign_str))
  return sign_result, sign_str
end   

local function oss_auth()
  -- ngx.log(ngx.INFO, 'auth')
  --local method = ngx.var.request_method
  local method = ngx.req.get_method()
  local content_md5 = ngx.var.http_content_md5 or ''
  local content_type = ngx.var.http_content_type or ''
  -- get date
  local date = ngx.var.http_x_oss_date or ngx.var.http_date or ''
  if date == '' then
    date = ngx.http_time(ngx.time())
    -- ngx.log(ngx.INFO, 'Date:', date)
    ngx.req.set_header('Date', date)
  end
  local resource = get_canon_resource()
  local canon_headers = get_canon_headers()
  -- ngx.log(ngx.ERR, "ngx.var.accesskey_secret ", ngx.var.accesskey_secret, " method ", method, " content_md5: ", content_md5, 
  -- " content_type ", content_type, " date ", date, " canon_headers ", canon_headers, " resource ", resource)
  local sign_result, sign_str = calc_sign(ngx.var.accesskey_secret, method, content_md5, 
    content_type, date, canon_headers, resource)
  ngx.log(ngx.INFO, ' sign_result: ', sign_result, ' sign string len:', string.len(sign_str))
  local auth = string.format("OSS %s:%s", ngx.var.accesskey_id, sign_result)
  ngx.req.set_header('Authorization', auth)
  ngx.exec("@oss")
end

-- main
local res = oss_auth()

if res then
  ngx.exit(res)
end
