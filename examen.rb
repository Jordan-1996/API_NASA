require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    url = URI("#{url}&api_key=#{token}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    return JSON.parse(response.read_body)
end 

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1","vAEIvKKujiidkeOvak11ZdqgLAbqalXokM8VXQyS")
photos = nasa_hash["photos"].map {|x| x["img_src"]}
photos_name = nasa_hash["photos"].map {|x| x["camera"]["full_name"]}

def build_web_page(info_hash) 
 count_img = info_hash.length
 
 File.open('index8.html', 'w') do |file|
        file.puts "<html>\n<head>\n<title>Hello, Nasa!</title>\n</head>"
        file.puts "<body>\n<section class='container'>"
        file.puts "<ul>"
            count_img.times do |i|
             file.puts "\t<li><img src='#{info_hash[i]}'width='250'></li>"
            end    
        file.puts "</ul>\n</section>\n</body>\n<html>"      
     end 
end
#count

def photos_count(info_count)
    x=info_count[0..3].count 
    y=info_count[4..11].count 
    z=info_count[11..-1].count

    new_hash = { info_count[0] => x, info_count[4] => y , info_count[12] => z }
end  


puts photos_count(photos_name)
puts build_web_page(photos)
