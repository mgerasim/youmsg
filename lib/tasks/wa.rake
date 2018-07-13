require 'net/http'
require 'addressable/uri'

namespace :wa do
  desc "TODO"
  task active: :environment do
     api_key='518d9fb4bA46103A79825b0Ace2ed2e2'
     service='wa'
     url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=getNumber&service=#{service}&forward=0&operator=any&country=0}"
     uri = URI.parse(url)   
     https = Net::HTTP.new(uri.host, uri.port)
     answer = https.get(uri.request_uri).body
     puts answer
     status = answer.split(':')[0]
     puts status
     if (status=="ACCESS_NUMBER")
         id = answer.split(':')[1]
         phone = answer.split(':')[2]
         puts phone
         activate = Activate.new
         activate.code = id
         activate.phone = phone
         activate.save 
         
         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=getStatus&id=#{id}"
         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer
         activate.status = answer
         activate.save
# send sms        
         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=setStatus&status=1&id=#{id}"
         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer
         
         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=getStatus&id=#{id}"
         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer
         activate.status = answer
         activate.save

    end
  end

  desc "TODO"
  task onlinesim: :environment do
  end

  desc "TODO"
  task simsms: :environment do
  end

end
