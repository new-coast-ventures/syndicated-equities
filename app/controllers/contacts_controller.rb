class ContactsController < ApplicationController

  before_action :authenticate_user! unless Rails.env.development?

  def index
  end
  
end
