require 'open-uri'

# proxy設定
proxy = ENV["PROXY_PATH"]
proxy_user = ENV["PROXY_ID"]
proxy_pass = ENV["PROXY_PW"]


options = {}
options[:proxy_http_basic_authentication] = [proxy, proxy_user, proxy_pass]  unless proxy.nil?

# URL
base_url = ENV["TORA_JISSEKI_URL"]

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  ym = "201505"
  url = base_url + ym

  buffer = open(url,options).read
  sleep(5)
  json_data =  JSON.parse(buffer)

  sleep(1)
#  dat = json_data[1]
  dat = [100,30,150,130]
  progress_calc = (dat[2].to_f/dat[3] * 100).round
 
  puts "******json_data************#########################***************************"
  puts json_data
  puts "****dat******************#########################***************************"
  puts dat
  puts "****progress_calc********#########################***************************"

  puts progress_calc
puts "**********************#########################***************************"

  send_event('conchk', { ok: dat[0], ng: dat[1], 
                         complete: dat[2], yotei: dat[3],
                          progress: progress_calc})

end