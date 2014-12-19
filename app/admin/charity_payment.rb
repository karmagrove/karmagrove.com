ActiveAdmin.register CharityPayment do

  form do |f|
   f.inputs "CharityPayment" do 
      f.input :charity_id, :as => :select, :collection => Charity.all.map {| c| [c.legal_name, c.id] }
      f.input :amount
      f.input :payment_image_url
      # f.input :batch
      f.input :payment_provider, :as => :radio, :collection => ["cash","debit card","balancedAPI"]
      # f.input :state, :as => :radio, :collection => ["open","closed"]
      # f.input :donations
      
   end
   f.buttons
   end
end
