require 'twilio-ruby'
require 'json'
require 'sinatra'
require 'rufus-scheduler'

require 'pp'

require './lib/message'

APP_CONFIG = JSON.parse(File.read('./config/config.json'))

@twilioclient = Twilio::REST::Client.new APP_CONFIG['twilio']['account_sid'], APP_CONFIG['twilio']['auth_token']

@scheduler = Rufus::Scheduler.new


=begin
scheduler.every '12h', :first_at => Time.at(1396269000) do

  @client.account.messages.create(
      :from => '+12107142689',
      :to => "#{APP_CONFIG['phone_numbers']['primary']}",
      :body => "Hey there Elise! Did you feed Cami her #{APP_CONFIG['medications']['med_1']} and #{APP_CONFIG['medications']['med_2']} today?"
  )

end
=end

m = Message.new(@twilioclient)

m.send("+12103934442", "Hey there!")


post '/repsonse' do

  pp params.inspect

end


