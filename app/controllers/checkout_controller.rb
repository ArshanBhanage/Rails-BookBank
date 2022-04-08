class CheckoutController < ApplicationController

  def create
    #<%= @cart.collect { |item| item.to_builder.attributes! } %>
    #mybook = Mybook.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: @cart.collect { |item| item.to_builder.attributes! },
        #name: mybook.title,
        #amount: mybook.price.to_i * 100,
        #price: mybook.stripe_price_id,
        #currency: "inr",
        #quantity: 1,
      mode: 'payment',
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
    
    redirect_to @session.url, allow_other_host: true

  end

  def success
    if params[:session_id].present? 
      # session.delete(:cart)
      session[:cart] = [] # empty cart = empty array
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
      @session_with_expand.line_items.data.each do |line_item|
        product= Mybook.find_by(stripe_mybook_id: line_item.price.product)
      end
    else
      redirect_to cancel_url, alert: "No info to display"
    end
  end

  def cancel
  end


end