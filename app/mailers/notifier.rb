class Notifier < ActionMailer::Base
  # default :from => 'seeds@karmagrove.com'
  default :from => 'seeds@karmagrove.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
  	begin
      @user  = user
      mail(
        to: @user.email,
        subject: 'Thanks for signing up Karma Grove.  We will email you monthly with updates as to where donations have gone as well as keep you up to date on any new features.',
        template_path: 'notifier',
        template_name: 'welcome_email'
      )
    rescue Exception => e
    	Rails.logger.info e
      return true
    end  
  end

  def send_purchase_email(params={})
      
    begin
      @user = params[:user]
      @purchase = params[:purchase]

      # mail(
      #   to: @user.email,
      #   subject: 'Thank you for your purchase at the grove',
      #   template_path: 'notifier',
      #   template_name: 'purchase_email'
      # ) do |format|
      #   format.text
      #   format.html 
      # end

      mail(
        to: @user.email,
        subject: 'Thank you for your purchase at the grove',
        template_path: 'buddhas',
        template_name: 'purchase_email'
      )

    rescue Exception => e
      Rails.logger.info e
      return true
    end  
  end

  def send_gift_email(params={})
    Rails.logger.info("params: #{params}")  
    begin
      @user = params[:recipient]
      @gift = params[:gift]
      @charity_ids = @gift.product.product_charities.limit 3
      Rails.logger.info("@charity_ids.inspect: #{@charity_ids.inspect}")      
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
        subject: 'Thank you for your receiving a gift',
        template_path: 'gifts',
        template_name: 'gifts_email'
      )

    rescue Exception => e
      Rails.logger.info e
      return true
    end  
  end

  def send_event_ticket(params={})
     Rails.logger.info("params: #{params}")  
    begin
      @user = params[:recipient]
      @event = params[:event]
      @charity_ids = @event.product.product_charities.limit 3
      Rails.logger.info("@charity_ids.inspect: #{@charity_ids.inspect}")      
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
        template_name: 'events_email'
      )

    rescue Exception => e
      Rails.logger.info e
      return true
    end  

  end

end
