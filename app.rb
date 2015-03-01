require 'sinatra'
require 'json'
require 'mailjet'

require_relative 'mailjet-config'

class MyWebApp < Sinatra::Base
  get '/' do

    #@month = ( params['month'] && params['month'] != "") ? params['month'] : 1

    erb :render_widget
  end

  post '/addContact' do
    content_type :json
    @count = Mailjet::Contact.count
    { :contact => params['email'], :count => @count}.to_json
  end

  get '/addContact' do
    content_type :json
    #create new contact
    @id = -1
    begin
      @contact = Mailjet::Contact.create(email: params['email'])
      @id = @contact.id
    rescue
      @id = -1
    end

    {:id => @id}.to_json

  end
end
