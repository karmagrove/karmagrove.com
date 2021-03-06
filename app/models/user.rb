class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # ,
         # :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username,
                  :provider, :uid, :name, :facebook_id, :email_subscriber

  # attr_accessible :title, :body
  # validates_presence_of :username

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end

  def new_email_subscriber

  end

  def self.find_or_create_by_facebook_id(facebook_id)
    if User.exists?(:facebook_id => facebook_id)
      return User.where(:facebook_id => facebook_id).first
    else
      user = User.create!(:facebook_id => facebook_id,:email=>"fakeemail@awesome.com",:password => "fakepassword")
      return user
    end
  end

  def self.find_or_create_by_email(email)
    email = email.strip
    if User.exists?(:email => email)
      user = User.where(:email => email).first
    else
      user = User.create!(:email => email,:password => "fakepassword")
    end
    return user
  end

  def find_or_create_by_facebook_id(facebook_id)
    if User.exists?(:facebook_id => facebook_id)
      return User.where(:facebook_id => facebook_id)
    else
      user = User.create!(:facebook_id => facebook_id,:email=>"",:password => "")
      return user
    end
  end

  def total_donations
    amount = 0
    Purchase.where(:buyer_id => self.id).each do |purchase|
      if @donation = Donation.where(:purchase_id => purchase.id).first
        amount += @donation.amount.to_f
      end
    end
    a = sprintf "%.2f", amount
    return  a
  end


end
