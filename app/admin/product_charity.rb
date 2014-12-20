ActiveAdmin.register ProductCharity do

  form do |f|
    f.inputs "ProductCharity" do 
       f.input :product
       
       f.input :charity_id, :as => :select, :collection => Charity.all.map {| c| [c.legal_name, c.id] }
       # f.inputs do
       #    f.has_many :batch_charities do |bc|
       #      bc.input :charity_id
       #    end
       # end
     end
     f.buttons
  end


  index do

     # column :product #{|product| product.name}
     # column :product_description  do |purchase| 
     #  if purchase.product
     #    purchase.product.description
     #  else
     #    ""
     #  end
     # end

     # column :donation
     # column :purchase_price
     # column :cost
     column :product do |pc| pc.product.name end
     column :charity do |pc| pc.charity.legal_name end
     # column :buyer
     # column :seller


     default_actions
  end	


end
