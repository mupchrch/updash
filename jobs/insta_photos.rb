require 'net/http'
require 'net/https'
require 'uri'
require 'json'

token = ENV['INSTAGRAM_TOKEN']
uri = URI.parse("https://api.instagram.com/v1/users/self/media/recent/?access_token=#{token}")

SCHEDULER.every '10m', :first_in => '15s' do |job|
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

  media_data = JSON.parse(response.body)["data"]
  photos = []

  media_data.each do |media|
    photos << { url: media["images"]["standard_resolution"]["url"] }
  end

  send_event('insta_photos', photos: photos )
end
