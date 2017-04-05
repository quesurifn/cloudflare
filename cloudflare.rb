require 'sinatra'
require 'httparty'
require 'erb'
require 'json'


get '/' do
  headers = {
    "X-Auth-Email" => ENV['API_EMAIL'],
    "X-Auth-Key" =>   ENV['API_KEY'],
    "Content-Type" => 'application/json'
  }

  @isDevModeOn = HTTParty.get(
    'https://api.cloudflare.com/client/v4/zones/e7aababbccc6adde2d5928575ccad59f/settings/development_mode',
    :headers => headers
  )
  @t = @isDevModeOn['result']['time_remaining']
  @secondsToMinutes = Time.at(@t).utc.strftime("%H:%M:%S")

  puts @isDevModeOn
  puts @secondsToMinutes

  erb :index
end #end for get


get '/devModeOff' do
  headers = {
    "X-Auth-Email" => ENV['API_EMAIL'],
    "X-Auth-Key" =>   ENV['API_KEY'],
    "Content-Type" => 'application/json'
  }

  options = {:value => 'off'}
  newOptions = JSON.generate(options)

 @result = HTTParty.patch(
  'https://api.cloudflare.com/client/v4/zones/e7aababbccc6adde2d5928575ccad59f/settings/development_mode',
  headers: headers,
  body: newOptions,
  debug_output: $stdout
  )
  puts @result

  redirect to ('/')
end

get '/devModeOn' do
  headers = {
    "X-Auth-Email" => ENV['API_EMAIL'],
    "X-Auth-Key" =>   ENV['API_KEY'],
    "Content-Type" => 'application/json'
  }

  options = {:value => 'on'}
  newOptions = JSON.generate(options)

 @result = HTTParty.patch(
  'https://api.cloudflare.com/client/v4/zones/e7aababbccc6adde2d5928575ccad59f/settings/development_mode',
  headers: headers,
  body: newOptions,
  debug_output: $stdout
  )
  puts @result

  redirect to ('/')
end

get '/purgeCache' do
  headers = {
    "X-Auth-Email" => ENV['API_EMAIL'],
    "X-Auth-Key" =>   ENV['API_KEY'],
    "Content-Type" => 'application/json'
  }

  options = {:purge_everything => 'true'}
  newOptions = JSON.generate(options)

 @result = HTTParty.delete(
  'https://api.cloudflare.com/client/v4/zones/e7aababbccc6adde2d5928575ccad59f/purge_cache',
  headers: headers,
  body: newOptions,
  debug_output: $stdout
  )
  puts @result

  redirect to ('/')
end
