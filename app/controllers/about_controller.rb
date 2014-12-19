class AboutController < ApplicationController

  def index
  #  @products = Product.all
  @charity_payments = CharityPayment.where("amount is not null")
  @disable_sidebar = true
  respond_to do |format|
      format.html # index.html.erb
   #   format.json { render json: @products }
 end
end

def get_involved
  @disable_sidebar = true
  respond_to do |format|
      format.html # index.html.erb
   #   format.json { render json: @products }
 end
end

def joy_coin
  #  @products = Product.all

  respond_to do |format|
      format.html # joy_coin.html.erb
   #   format.json { render json: @products }
 end
end

def karma_coin
  #  @products = Product.all

  respond_to do |format|
      format.html # joy_coin.html.erb
   #   format.json { render json: @products }
 end
end

def grove
  #  @products = Product.all
  @disable_sidebar = true
    # respond_to do |format|
    #   format.html # joy_coin.html.erb
   #   format.json { render json: @products }
   @charity_payments = CharityPayment.where("amount is not null").reverse[0...3]
   render :home
    # end
  end

  def temp_donations
    @disable_sidebar = true
    @charity_payments = CharityPayment.where("amount is not null")
    render :temp_donations
  end

end
