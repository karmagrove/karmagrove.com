class DonationsController < ApplicationController


  def new
    @product_charities = Charity.limit 3
     Rails.logger.info("Params #{params}")
    if params[:batch_id]  
      @batch_id = params[:batch_id]
      if @batch = Batch.find(@batch_id)
        @charity_ids = BatchCharity.where(:batch_id => @batch_id.to_i).map {|batch_charity| batch_charity.charity_id }
        @charities = Charity.find(@charity_ids)
        if @charities.nil?
          @charities = Charity.find [99837, 99838, 99839]
         # @product_charities = Charity.limit 3
        end
    
        @batch_charities = BatchCharity.all
        @batch.batch_products
        @product_id = Product.where(:name => "Karma Coin").first.id
        @purchase = Purchase.create(:product_id => @product_id)
        @disable_nav = true
        @disable_sidebar = true
        if @batch.batch_charity_payments and @batch.batch_charity_payments.first and @batch.batch_charity_payments.first.charity_payment_id
            @charity_payment = CharityPayment.find(@batch.batch_charity_payments.first.charity_payment_id)
        end
      end
    elsif params[:purchase_id]  # this is maybe a lil smelly - allow batches to override product preferences for charitys?
      @gift = Gift.find params[:purchase_id]
      # @product = @purchase.product
      
      @product_charities = @gift.product.product_charities.limit 3
      @charity_ids = @product_charities.map {|product_charity| product_charity.charity_id }      
      @charities = Charity.where(:id => @charity_ids)
      #ProductCharity.where(:product_id => @product.id).map {|product_charity| product_charity.charity_id }      
      if @charity_ids.empty?
        @product_charities = Charity.limit 3
      end

    # elsif params[:id]
    #   Rails.logger.info("aqui")
    #   @purchase = Purchase.find params[:id]
    #   @product = @purchase.product
    #   @charity_ids = ProductCharity.where(:product_id => @product.id).map {|product_charity| product_charity.charity_id }      
    #   if @charity_ids.empty?
    #     @product_charities = Charity.limit 3
    #   end      

    end

    respond_to do |format|
      format.html
      format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
      # format.jpg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
    end

  end

  def index
    @donations = Donation.all
     respond_to do |format|
      format.html
      format.svg  { render :qrcode => request.url.gsub('.svg','.html'), :unit => 10 }
    end

  end
end
