require 'rubygems'
require 'net/imap'
require 'net/http'

puts "username"
username = gets.chomp
puts "Enter password"
password = gets.chomp

imap = Net::IMAP.new('imap.gmail.com', {:port => '993', :ssl => true})

puts "connecting to imap server"

imap.login(username, password)
imap.select('INBOX')
i = 0
imap.search(["NOT", "DELETED"]).each do |message_id|
    envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
    puts "#{envelope.from[0].name}: \t#{envelope.subject}"
    i += 1
    Process.exit if i>10
end
