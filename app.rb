require 'twilio-ruby'
require 'json'
require 'sinatra'
require 'rufus-scheduler'
require 'redis'
require 'i_heart_quotes'

require 'pp'

require './lib/message'
require './lib/meds'

APP_CONFIG = JSON.parse(File.read('./config/config.json'))
@twilioclient = Twilio::REST::Client.new APP_CONFIG['twilio']['account_sid'], APP_CONFIG['twilio']['auth_token']
@scheduler = Rufus::Scheduler.new
$redis = Redis.new

$redis.set('meds_morning', "false")
$redis.set('meds_evening', "false")



@scheduler.every '12h', :first_at => Time.at(1396269000) do

  if Time.now.hour <= 10
    meds_morning
  else
    meds_evening
  end

end


post '/response' do

  if params[:Body].to_s.downcase.include? "yes" && Time.now.hour <= 10

    $redis.set('meds_evening', "false")
    $redis.set('meds_morning', "true")

  elsif params[:Body].to_s.downcase.include? "yes" && Time.now.hour > 12

    $redis.set('meds_evening', "true")
    $redis.set('meds_morning', "false")

  end

end


