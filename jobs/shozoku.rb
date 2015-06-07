require 'open-uri'

# proxy設定
proxy = ENV["PROXY_PATH"]
proxy_user = ENV["PROXY_ID"]
proxy_pass = ENV["PROXY_PW"]


options = {}
options[:proxy_http_basic_authentication] = [proxy, proxy_user, proxy_pass]  unless proxy.nil?

# URL
base_url = ENV["TORA_SHOZOKU_URL"]

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  ym = "201506"
  url = base_url + ym

  buffer = open(url,options).read
  json_data =  JSON.parse(buffer)
  json_data.delete_at(0)
  
  shozoku_dat = json_data.transpose
  
send_event('shozoku', {header: shozoku_dat[0], ok: shozoku_dat[1],
  ng: shozoku_dat[2], complete: shozoku_dat[3], waiting: shozoku_dat[4]})
end