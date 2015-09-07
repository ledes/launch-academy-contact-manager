require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'
also_reload 'models/contact'


get '/' do
  @page = params[:page].to_i
  @contacts = Contact.all.limit(3).offset(@page * 3)
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find_by id: params['id']
  erb :show
end

get '/submit' do
  erb :submit
end

post '/submit' do
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    phone_number: params[:phone_number]
    )
  redirect '/'
end
