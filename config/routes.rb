Karmagrove::Application.routes.draw do

  resources :event_charities


  resources :members


  resources :events


  resources :buddhas

  resources :auctions
  resources :auction_items


  match '/purchases/user/:user_id', to: 'purchases#user'

  get '/luminosa', to: 'events#luminosa'
  post '/luminosa', to: 'events#purchase'
  put '/luminosa', to: 'events#purchase'

  match '/buddha', to: 'buddhas#dharmaya'
  match '/Buddha', to: 'buddhas#dharmaya'
  get '/buddhas', to:  'buddhas#dharmaya'
  put '/buddhas', to: 'buddhas#create'


  get '/circle', to:  'circles#index'

  # get '/events/:name', to: 'events#show'
  # match '/buddhas', to: 'buddhas#dharmaya'

  resources :markets


  match 'auth/facebook/callback', to: 'sessions#create'
  match 'auth/facebook/login', to: 'sessions#login'

  # resources :user :email_subscriber
  match '/users/email-subscribe', to: 'users#email_subscribe'
  match '/users/email-subscribe/update', to: 'users#email_subscribe_update'

  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'sessions#destroy', as: 'signout'

  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
  #   get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
  #   get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end

  # devise_scope :user do
  #   get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  # end

  get "/suggest_charity", to: "charities#suggest"
  resources :charities


  resources :markets

  resources :batch_charities

  match '/admin/batches/:batch_id', to: "batches#update"

  # post '/admin/gifts/', to: "gifts#create"

  ActiveAdmin.routes(self)
  post '/admin/batches/:id', to: "batches#update"
  put '/admin/batches/:id', to: "batches#update"

  # post '/admin/gifts', to: "gifts#create"
  put '/admin/gifts/:id', to: "gifts#update"


  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  resources :products do
    resources :purchases
  end

  # resources :batches

  # resources :batches

  resources :batches do
    resources :donations do
      resources :purchases
    end
  end

  get "/about/donations/", to: 'about#temp_donations'

  match 'Karma-Coin-Recipe' => "about#_karma_coin_recipe"



  match "/batches/:batch_id/donations/:donation_id/purchases/:purchase_id/update" => "purchases#update"
  match "/donations/:donation_id/purchases/:purchase_id/update" => "purchases#update"
  #"/batches/1/donations/1/purchases/4/update"
  match 'batch/#{id}/donation/new' => "batch#donate"

  resources :purchases do
    resources :donations
  end

  resources :events do
    resources :event_tickets
    resources :event_charities
  end

  root :to => "about#grove"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  match 'about' => 'about#index'
  match 'karma_coin_facts' => 'about#karma_coin'
  match 'Karma-Coin-Facts' => 'about#karma_coin'
  match 'Karma-Coin' => 'about#karma_coin'
  match 'KarmaCoin' => 'about#karma_coin'
  match 'grove' => 'about#grove'
  match 'Get-Involved' => 'about#get_involved'

  get ':id' => 'events#show_karmic_event'
  match '/:id' => 'events#show_karmic_event'
  match '/e/:id' => 'events#show_karmic_event'
  get '/e/:id' => 'events#show_karmic_event'
  post '/karmic_events/:id/purchases/new' => 'purchases#create_karmic_event_sale'

  post 'events/:id/purchases/new' => 'purchases#create_event_purchase'

  get '/events/:id/report/:secret' => 'events#report'

  ## ## ## ## ## ##

  ## FRONT DESK INTEGRATION ## 
  
  # get '/frontdesk/callback', to: 'sessions#create'
  
  # get '/auth/:provider', to: 'sessions#authenticate'
  get '/auth/frontdesk', to: 'sessions#authenticate_pike13'
  get '/callback/frontdesk', to: 'sessions#create_pike13'
  # get '/', to: 'sessions#authenticate'

  # coinbase stuff
  # get '/auth/coinbase', to: 'sessions#authenticate'
  # post '/callback/coinbase', to: 'sessions#authenticate'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
