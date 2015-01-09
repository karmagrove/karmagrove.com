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


  # def create
        
  #     respond_to do |format|
  #         format.html # new.html.erb
  #         format.json { render json: @product }
  #     end

  # end

  def new
      @current_user = current_user
      Rails.logger.info("current_suser #{@current_user.inspect}")
      # if @current_user == nil
      #   redirect_to "/users/login"
      #   return true
      # end
      @event = Event.find(params[:event_id])
      @charities = Charity.all
      @charities = @charities.map {|c| [c.legal_name,c.id] }
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
