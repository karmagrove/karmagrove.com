class EventsController < InheritedResources::Base


	def luminosa
    # authenticate_or_request_with_http_basic('Administration') do |username, password|
    #   username == 'luminosa' && password == 'light'
    
		if Product.find_by_name "Luminosa" == nil 
       @product = Product.create!(:name => "Luminosa", :image_url => "/assets/monica.jpg", :price => 22200 ) 
    else
       @product = Product.find_by_name "Luminosa"
   end
    @purchase = Purchase.create!(:product_id => @product.id)
    @event_charities = @product.product_charities
		@disable_sidebar = true
    @disable_nav = true
    @disable_footer = true
		respond_to do |format|
          format.html # luminosa.html.erb
          format.json { render json: @product }
         end
     # end
	end


	def purchase
		   Rails.logger.info("params:  #{params.inspect}")
       # redirect_to "/purchases/#{@purchase.id}/donations/new"
       @buyer = User.find_or_create_by_email(params['email'])
       @buyer.name = params[:name]
       @buyer.save
       Rails.logger.info("buyer: purchase:  #{@buyer}")
       if params["product"] and params["product"]["id"]
         @event = KarmicEvent.find(params["product"]["id"])
         Rails.logger.info("@event: #{@event.inspect}")
       end
       ## Somehow handle a purchase with more than one product?  Or three products?  
       @purchase = Purchase.new(:buyer_id => @buyer.id, :product_id => params[:product][:id])
       @purchase.save
       Rails.logger.info("purchase #{@purchase}")

       ## price 
       @price = params[:purchase][:price].to_f
       if @purchase.save_with_balanced_payment({:purchase_id => @purchase.id, card_url: params[:balancedCreditCardURI], :price => @price }) == true
         # @windows_buddha_links = ["https://s3.amazonaws.com/karmagrove/tob-zips-1-17.sitx",
         # {}"https://s3.amazonaws.com/karmagrove/tob-zips-18-34.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-35-49.sitx"]
         # @buddha_links = ["https://s3.amazonaws.com/karmagrove/tob-zips-1-17.sitx","https://s3.amazonaws.com/karmagrove/tob-zips-18-34.sitx",
         # "https://s3.amazonaws.com/karmagrove/tob-zips-35-49.sitx"]
         #@purchase= Purchase.last
         ticketCount = params["number of tickets"]
         mailer_params = {recipient: @buyer, gift: @purchase, event: @event, ticketCount: ticketCount }
         Rails.logger.info "purchase with payment... params: #{mailer_params}"
         #email = Notifier.send_purchase_email(mailer_params)
         # email.deliver
         Rails.logger.info "event name @event.name #{@event.name}"
         @purchase.paid = true
         
         @purchase.paid_description = "balanced: number of tickets: #{ticketCount}"
         @purchase.save
         if @event.name == "Luminosa"
          Rails.logger.info "event name @event.name #{@event.name} IS LUMINOSA"
           email = LuminosaMailer.send_event_ticket(mailer_params)
           email.deliver
           Rails.logger.info email
         else
          email = Notifier.send_event_ticket(mailer_params)
          email.deliver
          Rails.logger.info email
         end
         
         redirect_to "/purchases/#{@purchase.id}/donations/new"
	    
		    else
          Rails.logger.info("purchase failed :( ")
         if @event.name == "Luminosa"
           #flash_notice('payment failed')
           redirect_to "/luminosa"
           #flash_notice('payment failed')
         else
          ## redirect to the event.... 

         end
         ## no ticket emailed 
         # email = Notifier.send_event_ticket(mailer_params) 
	     end

	end

  def show
      @disable_sidebar = true
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
      @purchase_price = @event.price
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
      @event.save
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
      @product = Product.create(:reference_id => @event.id, :name => @event.name, :price => @event.price,
        :revenue_donation_percent => @event.revenue_donation_percent)
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

  def report
     authenticate_or_request_with_http_basic('Administration') do |username, password|
       username == 'luminosa' && password == 'light'
      @product = if Event.exists?(params[:id]) then Event.find(params[:id]) end
      @product ||= Product.find_by_name "Luminosa"
      @tickets = Purchase.where(:product_id => @product.id)
      @ticket_users = []
      @ticket_total = 0

      @tickets.each {|ticket|
        if User.exists?(ticket.buyer_id) 
          user = User.find(ticket.buyer_id)
          @ticket_total += ticket.purchase_price.to_f/100 
          @ticket_users << {:paid_description => ticket.paid_description,:name => user.name, :email => user.email, :purchase_id => ticket.id, :amount => ticket.purchase_price, :updated_at => ticket.updated_at}
        end
      }

      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @product }
      end
    end
  end



end
