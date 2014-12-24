ActiveAdmin.register Gift do |this_gift|


  controller do
    # This code is evaluated within the controller class

    def create
        Rails.logger.info("CREATE")

        @gift = params[:gift]
        @gift[:product_charities] =    @gift[:product_charities].delete_if {|pc| pc == "" }
        Rails.logger.info @gift.inspect

        if @gift[:product_id]
            @product_id = @gift[:product_id]

        elsif @gift[:product_description] != ""
          @product = Product.create! :description => @gift[:product_description], :name => @gift[:product_description]
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
        @gift[:buyer_id] = @buyer_id
        @gift.delete :users
        @purchase = Gift.create! @gift
        #:product_id => @product_id.to_i, :buyer_id => @buyer_id.to_i
        @purchase.product = Product.find @product_id
        @purchase.buyer = Buyer.find @buyer_id
        @purchase.state= "given_online"
        @purchase.profit_donation_percent= @gift[:profit_donation_percent]
        @purchase.save
        Rails.logger.info "prpduct id #{@product_id}, buyer #{@buyer_id} and purchase #{@purchase.inspect}"
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

           ## Send email ... 
                 #@buddha_links = ["https://s3.amazonaws.com/karmagrove/tob-zips-1-17.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-18-34.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-35-49.sitx"]
            
            mailer_params = {recipient: @purchase.buyer, gift: @purchase}
            Rails.logger.info ("mailer_params: #{mailer_params}" )
            email = Notifier.send_gift_email(mailer_params)
            email.deliver
            Rails.logger.info email

           Rails.logger.info "saved @purchase #{@purchase.inspect}     "
           respond_to do |format|
             format.html { redirect_to "/admin/gifts", notice: 'Gift was successfully updated.' }
             format.json { head :no_content }    
         
           end
        else
            respond_to do |format|
             format.html { redirect_to "/admin/gifts", notice: 'Gift was Not updated so good.' }
             format.json { head :no_content }    
         
           end
         end
      
    end

    def update
        Rails.logger.info("update")
    
        Rails.logger.info(params)
        #super
        @purchase = Purchase.find params[:gift][:id]
        @purchase.profit_donation_percent=(params[:gift][:profit_donation_percent])
        @purchase.save

        Rails.logger.info("PURCHASE and gift params #{Gift.filter_attributes(params[:gift]).inspect}")
        Rails.logger.info(@purchase.inspect)
        # Instance method

        if params[:gift][:users]
          Rails.logger.info(":users are real")
          buyer = params[:gift][:users].last
          params[:buyer] = Buyer.find buyer
        end
        params[:gift].delete :users

        if params[:gift][:product_description] != ""
          @product = Product.create! :description => @gift[:product_description], :name => @gift[:product_description]
          @product_id = @product.id
          params[:gift][:product_id] = @product_id
        end
        params[:gift].delete :product_description
        
        params[:gift][:product_charities].delete_if {|pc| pc == "" }

        if params[:gift][:product_charities].length > 0 
          params[:gift][:product_charities].each do |charity_id|
            unless charity_id == ""
                  @pc = ProductCharity.create :charity_id => charity_id, :product_id => @product_id
  
                  Rails.logger.info @pc.inspect
                  # @product_id = product_id
            end                
          end 
        end
        params[:gift].delete :product_charities
        #params[:gift][:product_charities].delete_if {|c| c == ""}

        @purchase.update_attributes(params[:gift])
        @purchase.save
        Rails.logger.info("paraams final #{params.inspect}")
        super
    end
  end
  

  

  # index do
  #   #column :name
  #   default_actions
  #   # column :description
  #   # column "Release Date", :created_at
  #   # column :price do |product|
  #   #   number_to_currency product.price, :unit => "&dollar;"
  #   # end
  # end

  index do

     column :product #do |gift| gift.product.name end
     # column :product_description  do |purchase| 
     #  if purchase.product
     #    purchase.product.description
     #  else
     #    ""
     #  end
     # end

     column :donation
     column :purchase_price
     column :cost
     column :revenue_donation_percent #do |gift| gift.revenue_donation_percent.to_s end
     column :profit_donation_percent #do |gift| gift.profit_donation_percent.to_s end
     column :buyer
     column :seller


     default_actions
  end	


  form do |f|

  	  f.inputs "Gift" do 
        f.input :id, :as => :hidden 
        f.input :purchase_price
        f.input :cost
        
        # f.input :products 
        @resources = Product.all
        #f.input :product, :as => :select_box, :collection => @resources.map {| p| [p.name, p.id] }
        f.input :product, :as => :check_boxes, :selected => @resources, :multiple => false,  :collection => @resources.map {| p| [p.name, p.id] }
        #f.input :product_description do |purchase| purchase.product.description end
        f.input :revenue_donation_percent
        f.input :profit_donation_percent
   		  

        @charities = Charity.all
        if params[:id]
          @gift = Gift.find(params[:id])
          Rails.logger.info("have charities to select")
          @selected = @gift.product.product_charities
        else
          @selected = []
        end

        @receivers = User.all
        @user_selected = "gift_users_#{@gift.buyer_id}"
        Rails.logger.info("user_selected #{@user_selected}")
        if params[:giftid].to_i>0
           f.input :buyer_id, :as => :radio, :selected => @user_selected, :multiple => false,  :collection => @receivers.map {| p| [p.email, p.id] }
        else
        f.input :users, :as => :check_boxes, :selected => @user_selected, :multiple => false,  :collection => @receivers.map {| p| [p.email, p.id] }
        end
        f.input :product_charities, :as => :check_boxes, :checked => @selected, :multiple => true,  :collection => @charities.map {| p| [p.legal_name, p.id] }
        # f.input :user, :as => :text
        
        # f.input :customer_email

  	  end
      f.buttons
  end
 

end
