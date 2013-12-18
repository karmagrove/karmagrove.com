class UsersController < InheritedResources::Base


  def email_subscribe
    return "fail" unless params[:email]
    @email = params[:email]
    if User.exists?(:email => params[:email])
      @user = User.find_by_email params[:email]
    else
      @user, @status = EmailSubscriber.subscribe params[:email]
      return @status
    end

  end

  def email_subscribe_update
    return "fail" unless params[:email]
    @email = params[:email]
    if User.exists?(:id => params[:id])
      @user = User.find params[:id]
    end
    if @user
      @user, @status = EmailSubscriber.update @user.id, @email
      @status
    end
    render "users/email_subscribe"

  end

end
