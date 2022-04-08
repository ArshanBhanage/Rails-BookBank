class ApplicationController < ActionController::Base

  before_action :initialize_session
  before_action :load_cart

  private

  def initialize_session
    session[:cart] ||= [] # empty cart = empty array
  end

  def load_cart
    @cart = Mybook.find(session[:cart])
  end

end
