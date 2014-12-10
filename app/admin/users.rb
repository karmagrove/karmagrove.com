ActiveAdmin.register User do


  form do |f|
  f.inputs "User" do 
    f.input :email
    f.input :name 
    f.input :email_subscriber
  end
  f.buttons
end
  
end
