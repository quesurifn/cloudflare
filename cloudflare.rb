require 'sinatra'
require 'httparty'
require 'erb'


get '/' do
  headers = {
    "X-Auth-Email" => 'mcwiokowski@elexausa.com',
    "X-Auth-Key" =>   '16e16495042d3ca59411e96d685bac69068ca',
    "Content-Type" => 'application/json'
  }

  isDevModeOn = HTTParty.get(
    'https://api.cloudflare.com/client/v4/zones/e7aababbccc6adde2d5928575ccad59f/settings/development_mode',
    :headers => headers
  )

  erb :index, :locals => isDevModeOn
end #end for get
