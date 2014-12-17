class GiftsController < ApplicationController

# {"utf8"=>"✓",
#  "authenticity_token"=>"8j383kazsiDjJN2pQ0CE6XvmWXKEl3yvOBL6kbOPwKk=",
#  "gift"=>{"purchase_price"=>"100",
#  "cost"=>"30",
#  "product_id"=>["",
#  "3"],
#  "product_description"=>"",
#  "revenue_donation_percent"=>"",
#  "profit_donation_percent"=>"100",
#  "users"=>[""],
#  "product_charities"=>["",
#  "1",
#  "2",
#  "5"]},
#  "commit"=>"Create Gift"}
  def create
    Rails.logger.info "post to gifts controller"
    # rails.logger.info "foo"
    @product_id = nil
    @gift = params[:gift]
    Rails.logger.info @gift.inspect

    if @gift[:product_id].length > 1
        @product_ids = @gift[:product_id]

    elsif @gift[:product_description]
    	@product = Product.create! :description => @gift[:product_description]
    	@product_ids = [@product.id]
    end

    # if @gift[:product_description] and @product_id = nil
    #   @product = Product.create :name => @gift[:product_description], :description => @gift[:product_description]
    #   @product_id = @product.id
    #   @product
    #   Rails.logger.info "AFTEr PRODCuT CREATE prdoct id  #{@product_id}"
    # end

    if @gift[:product_charities].length > 0 
    	@gift[:product_charities].each do |charity_id|
    		unless charity_id == ""
    		  @product_ids.each do | product_id |
    		  	unless product_id == ""
    		      @pc = ProductCharity.create :charity_id => charity_id, :product_id => product_id
  
    		      Rails.logger.info @pc.inspect
    		      @product_id = product_id
    		    end
    	      end
    	    end
    	end	
    end

    @buyer_id = @gift[:users].last

    Rails.logger.info "prpduct id #{@product_id}"


    @purchase = Purchase.create :product_id => @product_id, :buyer_id => @buyer_id
    
        
    if @gift[:cost]
        @purchase.cost = @gift[:cost]    
    end
    

    if @gift[:revenue_donation_percent] 
        @purchase.revenue_donation_percent = @gift[:revenue_donation_percent]
    	message = "Whatever amount of money you choose to give us we will donate #{@gift[:revenue_donation_percent]}% to charity of your choice"

    elsif @gift[:profit_donation_percent] and @gift[:cost]
        @purchase.profit_donation_percent = @gift[:profit_donation_percent]
		message = "Whatever amount of money you choose to give us we will donate #{@gift[:profit_donation_percent]}% of anything over #{@gift[:cost]} to charity of your choice"    	
    end

    @purchase.save
    

    respond_to do |format|
      format.html { redirect_to "/admin/gifts", notice: 'Product was successfully updated.' }
      format.json { head :no_content }    
  
    end
  end

end
