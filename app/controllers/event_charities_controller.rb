class EventCharitiesController < InheritedResources::Base


  # def show
  #     Rails.logger.info("params #{params.inspect}")
  #     if params[:show_unpublished] == "true"
  #       @show_unpublished_event = true
  #     end
  #     if params[:id]
  #       @event = Event.find_by_name(params[:id])
  #       if @event.nil?
  #         @event = Event.find_by_name(params[:id].split('-').join(' '))
  #       end
  #       if @event.nil?
  #         @event = Event.find(params[:id])
  #       end
  #       if @event.nil?
  #         @event = Event.find_by_url(params[:id])
  #       end
  #     end

  #     respond_to do |format|
  #         format.html # show.html.erb
  #         format.json { render json: @product }
  #     end
  # end


  def create
      # unless @event
      if @event_charity = EventCharity.create(params[:event_charity])
        if @product = Product.find_by_reference_id(@event_charity.event_id)
          ProductCharity.create(:product_id => @product.id, :charity_id => @event_charity.charity_id)
          # @event_charity.charity_id
          #@event_charity.event_id
          # @product.product_charity_ids = 
        end
        redirect_to "/events/#{@event_charity.event_id}"
      else
        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @product }
        end
      end
  end

  def new
      @current_user = current_user
      Rails.logger.info("current_suser #{@current_user.inspect}")
      # if @current_user == nil
      #   redirect_to "/users/login"
      #   return true
      # end
      @event = Event.find(params[:event_id])
      @charities = Charity.all
      charities_already_selected = @event.event_charities.map {|e_charity| e_charity.charity_id }
      @charities = @charities.map {|c| 
        unless charities_already_selected.include?(c.id) 
          [c.legal_name,c.id] 
        end 
      }
      @charities.delete_if {|i| i == nil }
      # @eventticket = EventTicket.new
      @event_charity = EventCharity.new
      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @product }
      end

  end
  
  def edit
      @event = Event.find(params[:event_id])
      @event_ticket = EventTicket.find(params[:id])
      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @product }
      end

  end
end
