module ActiveRecord
  class Base
    def self.filter_attributes(hash)
      hash.stringify_keys.slice(*self.accessible_attributes.to_a)
    end
  end
end


class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :buyer
  belongs_to :seller
  belongs_to :donation
  belongs_to :batch




  attr_accessible :stripe_customer_token, :buyer_id, :product_id,
                  :seller_id, :state, :donation_id, :id, :stripe_transaction_id, :retailer_id,
                  :batch_id, :cost, :purchase_price, :users, :revenue_donation_percent, 
                  :profit_donation_percent, :paid_description, :paid
  
  #accessible_attributes :attr_accessor                  
  ## final purchase price is for auction only....

  ## Validate here that the batch is not closed before allowing a purchase of a batch that is done....

  include Workflow
  workflow do
    state :physical_sale
    state :sold_online
    state :completed
  end

  # def self.filter_attributes(hash)
  #     hash.stringify_keys.slice(*self.accessible_attributes.to_a)
  # end

 # TODO - does this make sense?  to ahndle here in intialize?  RYAN?
 # def initialize(arg1=nil,arg2=nil)
 #   super(arg1,arg2)
 #   @purchase = self
 #   @purchase.state = "open"
 #   @purchase.save
 #   # @purch
 #   if @purchase.batch_id and @batch = Batch.find(@purchase.batch_id) and @batch.state == "closed"
 #     puts @batch.state
 #     @purchase.state = "invalid-batch-cancelled"
 #     @purchase.save
 #     @response = false
 #     return false
 #   else
 #     @response =self
 #     return self
 #   end
 #   @response
 # end

  # validates_presence_of  :product_id
  def save_with_balanced_payment(params={})
    begin
      @purchase_id = params[:purchase_id]      
      card_url = params[:card_url]
      card = Balanced::Card.fetch(card_url)

      price = params[:price].to_i * 100
      response = card.debit(:amount => price)
      Rails.logger.info("payment_response: #{response} : for price #{price}")
      self.purchase_price = price
      # this is actually a balanced id.. whatever.. 
      self.stripe_transaction_id = response.attributes['id']
      self.payment_href=response.attributes['href']
      self.save
    
      Rails.logger.info("save with balaned: #{card.inspect}")
    rescue Exception => e
      Rails.logger.info("save with balaned Exception #{e.inspect}")
    end
  end

  def create_donation(donation)
    @donation = donation
      # Donation.where(:purchase_id => @purchase.id).each do |donation|
      #   @donation = donation
      #   # if a batch charity payment exists, there shall be no more voting on past events. 
      #   unless @donation.donation_date and @donation.amount
      #     @donation.charity_id = charity_id
      #   end
      # end
      
      # if @donation
      #   unless @donation.donation_date and @donation.amount
      #     @donation.charity_id = charity_id
      #   end
      # end

      if self.profit_donation_percent and self.cost and self.purchase_price and @donation
        Rails.logger.info( "saving a payment for something that was unpaid with a cost and price and profit_donation_percent")
        Rails.logger.info( "self.profit_donation_percent and self.cost and self.purchase_price and @donation  : #{self.profit_donation_percent} and #{self.cost} and #{self.purchase_price} and #{@donation} ")
        amount = ((self.purchase_price/100 - self.cost) * self.profit_donation_percent / 100)
        Rails.logger.info( "amount : #{amount}")
        @donation.amount = sprintf "%.2f", amount
        @donation.save
      end
      if self.purchase_price and self.revenue_donation_percent and  self.revenue_donation_percent > 0 
        Rails.logger.info( "saving a payment for revenue to purchase price and revenue donation percent")
        amount = (self.purchase_price/100)*(self.revenue_donation_percent/100.to_f)
        Rails.logger.info( "amount : #{amount}")
        @donation.amount = sprintf "%.2f", amount
        @donation.save
      end  
  end


  def save_with_payment(params={})
    begin
      if valid?
        # email = params[user]['email']
          # customer = Stripe::Customer.create(description: email ,purchase_id: purchase_id,  card: stripe_card_token)
        customer = Stripe::Customer.create(description: self.product_id)
        self.stripe_customer_token = customer.id
        if params[:purchase_id]
          self.stripe_transaction_id = params[:purchase_id]
        else
          self.stripe_transaction_id = customer.id  
        end
        
        # self.stripe_customer_token = customer.id
        save!
      end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
    end
  end

  def new_donation(params)
    if params[:charity_id]
      @charity_id = params[:charity_id]
    else
      # bad workaround - just makeup a charity..
      @charity_id = Charity.first.id
    end
    @donation = Donation.create!(:charity_id => @charity_id, :purchase_id => self.id)
    self.donation_id = @donation.id
    # @donation.save
    return @donation
  end

end
