require 'sinatra'
require 'json'

class MyWebApp < Sinatra::Base
  get '/' do

    #@month = ( params['month'] && params['month'] != "") ? params['month'] : 1

    erb :render_widget
  end

  post '/addContact' do
    content_type :json
    { :contact => params['email']}.to_json
  end
end
