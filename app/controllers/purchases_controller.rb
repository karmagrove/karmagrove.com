class PurchasesController < ApplicationController

def index
   if user_signed_in?

   else
     @purchases = Purchase.all

     respond_to do |format|
       #format.html  # index.html.erb
       format.json { render json: @purchases }
     end
   end
  #format.html "hello"
end

def user
  if params[:user_id] then
    @purchases = Purchase.find_all_by_buyer_id params[:user_id]
    @user = User.find params[:user_id]
  end

   respond_to do |format|
     format.html
     format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
     format.json { render json: @purchase }
   end
end

def show
  if params[:user] then
    @purchases = Purchase.find_by_buyer_id params[:user]
  else
    @purchase = Purchase.find(params[:id])
  end

   respond_to do |format|
     format.html
     format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
     format.json { render json: @purchase }
   end
end


# GET /products/:id/purchases new
# GET /products/new.json
  def new
    if params[:product_id].to_i.is_a? Integer
      Rails.logger.info("in purchases#new")
      @product = Product.find(params[:product_id])
    else
      # remove %20 and - and replace with space
      name = params[:product_id].split('-').map! { |word| word.capitalize }.join(' ')
      #.split('%20').map! { |word| word.capitalize! }.join(' ')
      @product = Product.find_by_name name
    end

    @purchase = Purchase.create!(:product_id => @product.id)
    #  @donation =  ActiveRecord::RecordNotFound in PurchasesController#update
    #  app/controllers/purchases_controller.rb:54:in `update'
    #
    # @donation = Purchase.create!(:product_id => @product.id)
    @donation_id = @purchase.new_donation(params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  def update
    @need_payment = true
    if params[:purchase_id]
      @purchase_id = params[:purchase_id]
    end
    if params[:purchase]
       @purchase_id = params[:purchase][:id]
    end
    @purchase = Purchase.find(@purchase_id)

    if params[:balancedCreditCardURI]
      cardURLtoCharge = params[:balancedCreditCardURI] 
      
      @price = params[:price]

      if @purchase.save_with_balanced_payment({:purchase_id => @purchase.id, card_url: params[:balancedCreditCardURI], :price => params[:price]})
        @need_payment = false
        @purchase.paid = true
        @purchase.save
        Rails.logger.info("succcesfful purchase - need_payment is false")
        #@purchase
      end  
    end


    @disable_nav = true
    @disable_sidebar = true
    
    @product = Product.find(@purchase.product_id)
    @donation_id =
    if params[:donation] and params[:donation][:id].to_i.class == Fixnum
      @donation_id = params[:donation][:id]
      @charity_id = Donation.find(@donation_id).charity_id
    end
    
    if params[:donation_id]
       Rails.logger.info "found donation id #{params[:donation_id]}"
       @charity_id = params[:donation_id]
    end

    if @charity_id
      @charity = Charity.find(@charity_id)

      Donation.where(:purchase_id => @purchase.id).each do |donation|
        @donation = donation
        # if a batch charity payment exists, there shall be no more voting on past events. 
        unless @donation.donation_date and @donation.amount
          @donation.charity_id = @charity.id
        end
      end
      @donation_amount = 0
      if @purchase.purchase_price and @purchase.revenue_donation_percent
        @donation_amount = (@purchase.purchase_price/100)*(@purchase.revenue_donation_percent/100.to_f)
        @donation_amount = sprintf "%.2f", @donation_amount
      end  
      @donation ||= Donation.create(:charity_id => @charity.id,:purchase_id => @purchase.id )
      @donation.amount = @donation_amount
      @donation.save
      @purchase.donation_id = @donation.id
      @purchase.save
    end
    if @purchase.purchase_price == nil
       if @purchase.cost != nil 
          @purchase.purchase_price = @purchase.cost * 1.8
       else
         @purchase.cost = 61.30
       end
    end
    # session['callback_code'] = @code
    if @purchase.purchase_price
      @purchase_price = (@purchase.purchase_price/100).to_s
      
    else
      @purchase_price = 10.00
    end
    if @purchase.payment_href
      @need_payment = false
    end
    
    if @purchase.donation_id
      respond_to do |format|
        format.html
      end
    else
      # no donation id then the purchase fails.  There is a donation at time of purchase...
      render "404"
    end
  end

#POST /products/:id/purchases/new
  def create
    rails.logger.info "IN POST PRUCASE"
    @purchase = Purchase.new(params[:purchase])
    @purchase.product_id = params[:product_id]
    # @purchase.buyer_id =
  
    @product = Product.find params[:product_id]
    @purchase.save
  
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://manage.stripe.com/account
    # Stripe.api_key = "sk_test_B5RUJ3ZgW7BnB5VKp1vNbE7e"
  
    # Get the credit card details submitted by the form
    # token = params[:stripeToken]
    # Create the charge on Stripe's servers - this will charge the user's card
    
    begin
     if @purchase.save_with_balanced_payment({:purchase_id => @purchase.id, card_url: params[:balancedCreditCardURI], :price => params[:price]})
       redirect_to "/purchases/#{@purchase.id}/donations/new"
     else
      render :new
     end

    rescue Exception => e
      # The card has been declined
      Rails.logger.info "error: #{e.message}"
    end

  end

end
