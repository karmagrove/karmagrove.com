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
   Rails.logger.info("CREATE")

        @gift = params[:gift]
        @gift[:product_charities] =    @gift[:product_charities].delete_if {|pc| pc == "" }
        Rails.logger.info @gift.inspect

        if @gift[:product_id].length == 1
            @product_id = @gift[:product_id]

        elsif @gift[:product_description] != ""
          @product = Product.create! :description => @gift[:product_description]
          @product_id = @product.id
        end



        @gift.delete :product_description


        # if @gift[:product_description] and @product_id = nil
        #   @product = Product.create :name => @gift[:product_description], :description => @gift[:product_description]
        #   @product_id = @product.id
        #   @product
        #   Rails.logger.info "AFTEr PRODCuT CREATE prdoct id  #{@product_id}"
        # end

        if @gift[:product_charities].length > 0 
          @gift[:product_charities].each do |charity_id|
            unless charity_id == ""
                  @pc = ProductCharity.create :charity_id => charity_id, :product_id => @product_id
  
                  Rails.logger.info @pc.inspect
                  # @product_id = product_id
            end
                
          end 
        end
        @gift.delete :product_charities

        @buyer_id = @gift[:users].last

        Rails.logger.info "prpduct id #{@product_id}"

        @gift[:buyer_id] = @buyer_id
        @gift[:cost] = @gift[:cost].to_i
        @purchase = Purchase.create :product_id => @product_id, :buyer_id => @buyer_id

        # "batch_id", "buyer_id", "cost", "created_at", "donation_id", "product_id", "profit_donation_percent", "purchase_price", "retailer_id", "revenue_donation_percent", "seller_id", "state", "stripe_customer_token", "stripe_transaction_id"
        @gift
        #
        
            
        if @gift[:cost]
            Rails.logger.info "@gift[:cost] #{@gift[:cost]}   "
            @purchase.cost = @gift[:cost]    
        end
        

        if @gift[:revenue_donation_percent] 
            @purchase.revenue_donation_percent = @gift[:revenue_donation_percent]
          message = "Whatever amount of money you choose to give us we will donate #{@gift[:revenue_donation_percent]}% to charity of your choice"

        elsif @gift[:profit_donation_percent] and @gift[:cost]
            @purchase.profit_donation_percent = @gift[:profit_donation_percent]
        message = "Whatever amount of money you choose to give us we will donate #{@gift[:profit_donation_percent]}% of anything over #{@gift[:cost]} to charity of your choice"      
        end

        if @purchase.save
           Rails.logger.info "saved @purchase #{@purchase.inspect}     "
           respond_to do |format|
             format.html { redirect_to "/admin/gifts", notice: 'Product was successfully updated.' }
             format.json { head :no_content }    
         
           end
        else
            respond_to do |format|
             format.html { redirect_to "/admin/gifts", notice: 'Product was Not updated so good.' }
             format.json { head :no_content }    
         
           end
         end
  end


end
