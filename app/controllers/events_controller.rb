class EventsController < InheritedResources::Base


	def luminosa
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'luminosa' && password == 'light'
    
		if Product.find_by_name "Luminosa" == nil 
       @product = Product.create!(:name => "Luminosa", :image_url => "/assets/monica.jpg", :price => 22200 ) 
    else
       @product = Product.find_by_name "Luminosa"
   end
    @purchase = Purchase.create!(:product_id => @product.id)

		@disable_sidebar = true
    @disable_nav = true
		respond_to do |format|
          format.html # luminosa.html.erb
          format.json { render json: @product }
         end

     end
	end


	def purchase
		Rails.logger.info("params:  #{params.inspect}")
    # redirect_to "/purchases/#{@purchase.id}/donations/new"
       @buyer = User.find_or_create_by_email(params['email'])
   
       Rails.logger.info("buyer: purchase:  #{@buyer}")
       if params["product"] and params["product"]["id"]
         @event = KarmicEvent.find(params["product"]["id"])
         Rails.logger.info("@event: #{@event.inspect}")
       end
       @purchase = Purchase.new(:buyer_id => @buyer.id, :product_id => params[:product][:id])
       @purchase.save
       Rails.logger.info("purchase #{@purchase}")
       if @purchase.save_with_balanced_payment({:purchase_id => @purchase.id, card_url: params[:balancedCreditCardURI], :price => params[:price]})
         # @windows_buddha_links = ["https://s3.amazonaws.com/karmagrove/tob-zips-1-17.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-18-34.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-35-49.sitx"]
         #@buddha_links = ["https://s3.amazonaws.com/karmagrove/tob-zips-1-17.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-18-34.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-35-49.sitx"]
         #@purchase= Purchase.last
         mailer_params = {recipient: @buyer, gift: @purchase, event: @event}
         Rails.logger.info "purchase with payment... params: #{mailer_params}"
         #email = Notifier.send_purchase_email(mailer_params)
         # email.deliver
         email = Notifier.send_event_ticket(mailer_params)
         email.deliver
         Rails.logger.info email
         redirect_to "/purchases/#{@purchase.id}/donations/new"
	    
		 else
      Rails.logger.info("purchase failed :( ")
         send_event_ticket
	   end

	end

  def show
      Rails.logger.info("params #{params.inspect}")
      if params[:show_unpublished] == "true"
        @show_unpublished_event = true
      end
      if params[:id]
        @event = Event.find_by_name(params[:id])
        if @event.nil?
          @event = Event.find_by_name(params[:id].split('-').join(' '))
        end
        if @event.nil?
          @event = Event.find(params[:id])
        end
        if @event.nil?
          @event = Event.find_by_url(params[:id])
        end
      end

      @event_charities = @event.event_charities
      @product = Product.find_by_reference_id(@event.id)
      @purchase = Purchase.new
      respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @product }
      end
  end

  def show_karmic_event
      @event = KarmicEvent.find_by_name(params[:id])
      if @event.nil?
        @event = KarmicEvent.find_by_name(params[:id].split('-').join(' '))

      end
      @event.revenue_donation_percent = 10
      @event_charities = @event.product_charities
      @product = @event
      @purchase = Purchase.new(:product_id => @event.id)
      @purchase_price = @event.price
      respond_to do |format|
          format.html {render "events/karmic_event.html.erb" } # show.html.erb
          format.json { render json: @product }
      end

  end
  
  # POST events/new 
  def create
      @event = Event.create(params[:event])
      @event.save
      @product = Product.create(:reference_id => @event.id, :name => @event.name, :price => @event.price)
      @product.save
      if @product and @event 
        redirect_to "/events/#{@event.id}?show_unpublished=true"
      else
      respond_to do |format|
          # format.html { redirect_to "/events/#{@event.id}"}
          format.html # new.html.erb
          format.json { render json: @product }
      end
      end

  end

  ## for the event ticket nonsense....
  def new
      @current_user = current_user
      Rails.logger.info("current_suser #{@current_user.inspect}")
      # if @current_user == nil
      #   redirect_to "/users/login"
      #   return true
      # end
      @event = Event.new
      @eventticket = EventTicket.new
      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @product }
      end

  end
  
  def edit
      @event = Event.find(params[:id])
      @event_ticket = EventTicket.new
      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @product }
      end

  end



end
