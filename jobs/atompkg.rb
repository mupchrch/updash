require 'json'

uri = URI.parse(ENV['ATOMPKG_URL'])

SCHEDULER.every '1m' do
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

  response_json = JSON.parse(response.body)

  send_event('atompkg', { title: "#{response_json['name']} downloads", current: response_json['downloads'], moreinfo: "v#{response_json['releases']['latest']}" })
end
