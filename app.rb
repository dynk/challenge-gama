# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
  erb :index, :locals => {result: nil}
end


post '/' do

  endereco = params["url"].gsub(' ', '+')
  escaped  = URI.escape(endereco)
  url      = "http://maps.google.com/maps/api/geocode/json?address=#{escaped}"
  response = HTTParty.get(url)
  parsed   = JSON.parse(response.body)['results']
  count = parsed[0]["address_components"].count
  erb :index, :locals => {result: parsed[0]["address_components"][count-1]["long_name"]}
end
