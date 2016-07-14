Rails.application.routes.draw do
  resources :download_tickets
  get "get_files", to: 'download_tickets#get_hosted_files'
  get "expired_download", to: 'download_tickets#expired_download'

  resources :hosted_files

  resources :requests

  resources :environments 
  get '/join/:id', to: 'environments#join', as: 'join'
  get '/new/:id', to: 'environments#new_profile', as: 'generate'
  post '/create/:id', to: 'environments#create_profile'


  devise_for :users, controllers: {registrations: "registrations"}
  resources :emergency_alerts do
    collection do 
      get 'create_alert_modaly'
    end
  end

  resources :personal_health_records do
  end

  resources :welcome do 
    collection do
      get 'ER', :as => "ER"
      get 'docter', :as => "docter"
    end
  end

    get 'user_landing', :as => "welcome/user", :to => "welcome#user_landing"
    get 'get_network', :as => "welcome/get_network", :to => "welcome#get_network"

    get 'more_info', :as => "welcome/info", :to => "welcome#info"
    get 'contact', :as => "welcome/contact", :to => "welcome#contact"

    ## ADMIN LINKS ##
    get 'admin_landing', :as => "admin/landing", :to => "admin#landing"
    get 'admin_users', :as => "admin/users", :to => "admin#users"

    get 'admin/view_registrations', :as => "admin/view_registrations", :to => "admin#view_registrations"
    get 'admin/view_devices', :as => "admin/view_devices", :to => "admin#view_devices"
    get 'admin/view_profile_passes', :as => "admin/view_profile_passes", :to => "admin#view_profile_passes"

  resources :profiles
    get 'profiles/give_profile_info/:id', :as => "profiles/give_profile_info", :to => 'profiles#give_profile_info'
    get 'profiles/generate_qr/:id', :as => "profiles/generate_qr", :to => 'profiles#generate_qr'


## IPASS ANS Endpoints
  post  'v1/devices/:device_id/registrations/:passtype_id/:serial_number', :to => "pass_endpoint#register"
  delete  'v1/devices/:device_id/registrations/:passtype_id/:serial_number', :to => "pass_endpoint#unregister"
  get 'v1/devices/:device_id/registrations/:passtype_id', :to => "pass_endpoint#ask_for_serials"
  get 'v1/passes/:passtype_id/:serial_number', :to => "pass_endpoint#get_new_pass"

  get 'pkpass.pass/:id', :to => "pass_endpoint#pkpass", :as => "get/pass/direct"

## IPAD Endpoints
  get 'api/send_pass_by_email/:id', :to => "api#send_pass_by_email", :as => "get/pass/email"
  get 'api/get_record/:id', :to => "api#get_profile_info"
  get 'api/get_all_records', :to => "api#get_all_records"
  get 'api/send_picture/:id', :to => "api#send_picture"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
