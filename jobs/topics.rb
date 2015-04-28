require 'open-uri'

# proxy設定
proxy = ENV["PROXY_PATH"]
proxy_user = ENV["PROXY_ID"]
proxy_pass = ENV["PROXY_PW"]

#options = { proxy_http_basic_authentication: [proxy, proxy_user, proxy_pass] }

options = {}
options[:proxy_http_basic_authentication] = [proxy, proxy_user, proxy_pass]  unless proxy.nil?

# URL
url = ENV["TORA_TOPIC_URL"]

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '180s', :first_in => 0 do |job|


buffer = open(url,options).read
json_data =  JSON.parse(buffer)


  send_event('topics', { items: json_data})


end
