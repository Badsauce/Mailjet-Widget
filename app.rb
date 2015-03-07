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
    #create new contact
    @id = -1
    begin
      @contact = Mailjet::Contact.create(email: params['email'])
      @id = @contact.id
    rescue
      return {:status => 'error', :message => 'An error occured when creating the contact'}.to_json
    end

    #add contact to mailing list

    begin
      Mailjet::Listrecipient.create(contact_id: @id, list_id: 2, is_active: true)
    rescue
      return {:status => 'error', :message => 'An error occured when adding the contact to the list'}.to_json
    end

    {:status => 'ok', :message => 'Success, you have been added to our mailing list'}.to_json
  end

  get '/addContact' do
    content_type :json
    #create new contact
    @contact = Mailjet::Contact.create(email: params['email'])
    @id = @contact.id

    #add contact to mailing list

    begin
      Mailjet::Listrecipient.create(contact_id: @id, list_id: 2, is_active: true)
    rescue
      return {:status => 'error', :message => 'An error occured when adding the contact to the list'}.to_json
    end

    {:status => 'ok', :message => 'Success, you have been added to our mailing list'}.to_json
  end
end
