ActiveAdmin.register User do

 controller do
      # This code is evaluated within the controller class

       def create
       	  params[:user][:password] = "temporary#{rand(6)}"
       	  @user = User.create params[:user]
       	  #super
       	    respond_to do |format|
             format.html { redirect_to "/admin/users", notice: 'User created.' }
             format.json { head :no_content }    
         
           end
       end

   end

  form do |f|
  f.inputs "User" do 
    f.input :email
    f.input :name 
    f.input :email_subscriber
  end
  f.buttons
end
  
end
