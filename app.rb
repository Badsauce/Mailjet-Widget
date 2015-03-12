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
    headers "Access-Control-Allow-Origin" => "*"
    #create new contact
    @id = nil
    begin
      @contact = Mailjet::Contact.create(email: params['email'])
      @id = @contact.id
    rescue
      return {:status => 'error', :message => 'An error occured when creating the contact.', :code => 20 }.to_json
    end

    #add contact to mailing list

    begin
      Mailjet::Listrecipient.create(contact_id: @id, list_id: ENV['MJ_LIST_ID'].to_i, is_active: true)
    rescue
      return {:status => 'error', :message => 'An error occured when adding the contact to the list.', :code => 21}.to_json
    end

    {:status => 'ok', :message => 'Success, you have been added to our mailing list.', :code => 10}.to_json
  end

  get '/addContact' do
    content_type :json
    headers "Access-Control-Allow-Origin" => "*"
    #create new contact
    @id = nil

      @contact = Mailjet::Contact.create(email: params['email'])
      @id = @contact.id

      #return {:status => 'error', :message => 'An error occured when creating the contact.', :code => 20 }.to_json


    #add contact to mailing list

    begin
      Mailjet::Listrecipient.create(contact_id: @id, list_id: ENV['MJ_LIST_ID'].to_i, is_active: true)
    rescue
      return {:status => 'error', :message => 'An error occured when adding the contact to the list.', :code => 21}.to_json
    end

    {:status => 'ok', :message => 'Success, you have been added to our mailing list.', :code => 10}.to_json
  end
end
