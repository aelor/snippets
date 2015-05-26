require 'nokogiri'
require 'open-uri'

cities = ["Ahmedabad", "Bangalore", "Chandigarh", "Chennai", "Coimbatore", "Delhi-NCR", "Ernakulam", "Goa", "Hyderabad", "Indore", "Jaipur", "Kolkata", "Mumbai", "Mysore", "Nagpur", "Nashik", "Pune", "Surat", "Vadodara", "Vizag"]

banks = []

cities.each do |city|
  page_num = 1

  while(1) do
    url = "http://www.justdial.com/#{city}/Blood-Banks/ct-4258/page-#{page_num}"
    doc = Nokogiri::HTML(open(url))

    if (!doc.css(".jgbg, .jbbg").first.nil?)
      puts "***************** city: #{city} ************* page: #{page_num} *****************"
      doc.css(".jgbg, .jbbg").each do |s|
        bb = {}
        bb['name'] = s.css(".jcn a").map{|l| l['title']}.join()
        bb['phone'] = s.css(".jrcw a").map{|l| l['href']}
        bb['address'] = s.css(".mrehover").text.strip
        bb['latlong'] = s.css(".rsmap").map{|l| l['onclick']}.join().scan(/(?<=')\d{2}\.\d{12}/)
        banks << bb
      end
      page_num += 1
    else
      break
    end
  end
end

puts banks.inspect
