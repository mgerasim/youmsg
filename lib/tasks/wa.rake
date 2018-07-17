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
         
         protocol = Protocol.new
         protocol.msg = url
         protocol.activate = activate
         protocol.save

         protocol = Protocol.new
         protocol.msg = answer
         protocol.activate = activate
         protocol.save    
   
         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=getStatus&id=#{id}"
         
         protocol = Protocol.new
         protocol.msg = url
         protocol.activate = activate
         protocol.save

         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer

         protocol = Protocol.new
         protocol.msg = answer
         protocol.activate = activate
         protocol.save

         activate.status = answer
         activate.save
# send sms   
         cmd = "python3.6 /home/rails/projects/yowsup/yowsup-cli registration --requestcode sms --phone #{phone} --cc 7 -E android"
         
         protocol = Protocol.new
         protocol.msg = cmd
         protocol.activate = activate
         protocol.save

         msg = %x[ #{cmd} ]

         protocol = Protocol.new
         protocol.msg = msg
         protocol.activate = activate
         protocol.save

# Сообщить о готовности

         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=setStatus&status=1&id=#{id}"
         
         protocol = Protocol.new
         protocol.msg = url
         protocol.activate = activate
         protocol.save

         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer

         protocol = Protocol.new
         protocol.msg = answer
         protocol.activate = activate
         protocol.save

         protocol = Protocol.new
         protocol.msg = "sleep 10"
         protocol.activate = activate
         protocol.save

         sleep 10

# get msg code
         
         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=getStatus&id=#{id}"
         
         protocol = Protocol.new
         protocol.msg = url
         protocol.activate = activate
         protocol.save

         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer

         protocol = Protocol.new
         protocol.msg = answer
         protocol.activate = activate
         protocol.save        

         if (answer.split(':')[0] == 'STATUS_OK')
             code = answer.split(':')[1]
             
             cmd = "python3.6 /home/rails/projects/yowsup/yowsup-cli registration --register #{code} --phone #{phone} --cc 7 -E android"

             protocol = Protocol.new
             protocol.msg = cmd
             protocol.activate = activate
             protocol.save

             msg = %x[ #{cmd} ]

             protocol = Protocol.new
             protocol.msg = msg
             protocol.activate = activate
             protocol.save
         end

         url = "http://sms-activate.ru/stubs/handler_api.php?api_key=#{api_key}&action=setStatus&status=6&id=#{id}"

         protocol = Protocol.new
         protocol.msg = url
         protocol.activate = activate
         protocol.save

         uri = URI.parse(url)
         https = Net::HTTP.new(uri.host, uri.port)
         answer = https.get(uri.request_uri).body
         puts answer
         activate.status = answer
         activate.save

         protocol = Protocol.new
         protocol.msg = answer
         protocol.activate = activate
         protocol.save

    end
  end

  desc "TODO"
  task onlinesim: :environment do
  end

  desc "TODO"
  task simsms: :environment do
  end

end
