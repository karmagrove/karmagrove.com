class LuminosaMailer < ActionMailer::Base
  # default :from => 'seeds@karmagrove.com'
  default :from => 'luminosafestival@karmagrove.com'

  def send_event_ticket(params={})
     Rails.logger.info("send_event_ticket: params: #{params}")  
    begin
      @user = params[:recipient]
      @event = params[:event]
      @gift = params[:gift]
      @ticket_url = "http://www.karmagrove.com/purchases/#{@gift.id}.svg"
      @charity_ids = @event.product_charities.limit 3
      Rails.logger.info("@charity_ids.inspect: #{@charity_ids.inspect}: @ticket_url #{@ticket_url}")      
      @charity_ids.map! {|pc| pc.charity_id }
      @charities = Charity.where(:id => @charity_ids.to_a)
      Rails.logger.info(@charities.inspect)
      Rails.logger.info(@user.inspect)
      Rails.logger.info(@charities.inspect)
      # @user.inspect
      # mail(
      #   to: @user.email,
      #   subject: 'Thank you for your purchase at the grove',
      #   template_path: 'notifier',
      #   template_name: 'purchase_email'
      # ) do |format|
      #   format.text
      #   format.html 
      # end
      Rails.logger.info(@user.email)

      mail(
        to: @user.email,
        from: "luminosafestival@gmail.com",
        subject: 'Thank you for your receiving a event',
        template_path: 'events',
        template_name: 'events_email'
      )

    rescue Exception => e
      Rails.logger.info e
      return true
    end  

  end


  def send_seller_event_ticket(params={})
     @user = params[:recipient]
     @event = params[:event]
     @gift = params[:gift]
     @ticket_url = "http://www.karmagrove.com/purchases/#{@gift.id}.svg"
     @charity_ids = @event.event_charities.limit 3
     Rails.logger.info("@charity_ids.inspect: #{@charity_ids.inspect}: @ticket_url #{@ticket_url}")      
     @charity_ids.map! {|pc| pc.charity_id }
     @charities = Charity.where(:id => @charity_ids.to_a)
     Rails.logger.info(@charities.inspect)
     Rails.logger.info(@user.inspect)
     Rails.logger.info(@charities.inspect)
     mail(
        to: "joshua@karmagrove.com",
        from: "seeds@karmagrove.com",
        subject: 'email: #{@user.email}, name: #{@user.name}, bought an event',
        template_path: 'events',
        template_name: 'user_events_email'
      )
  end

  def send_user_event_ticket(params={})
     Rails.logger.info("send_event_ticket: params: #{params}")  
    begin
      @user = params[:recipient]
      @event = params[:event]
      @gift = params[:gift]
      @ticket_url = "http://www.karmagrove.com/purchases/#{@gift.id}.svg"
      @charity_ids = @event.event_charities.limit 3
      Rails.logger.info("@charity_ids.inspect: #{@charity_ids.inspect}: @ticket_url #{@ticket_url}")      
      @charity_ids.map! {|pc| pc.charity_id }
      @charities = Charity.where(:id => @charity_ids.to_a)
      Rails.logger.info(@charities.inspect)
      Rails.logger.info(@user.inspect)
      Rails.logger.info(@charities.inspect)
      # @user.inspect
      # mail(
      #   to: @user.email,
      #   subject: 'Thank you for your purchase at the grove',
      #   template_path: 'notifier',
      #   template_name: 'purchase_email'
      # ) do |format|
      #   format.text
      #   format.html 
      # end
      Rails.logger.info(@user.email)

      mail(
        to: @user.email,
        from: "seeds@karmagrove.com",
        subject: 'Thank you for your receiving a event',
        template_path: 'events',
        template_name: 'user_events_email'
      )



    rescue Exception => e
      Rails.logger.info e
      return true
    end  

  end

end
