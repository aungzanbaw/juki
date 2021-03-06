Rails.application.routes.draw do
  
  # purchase carts
  get 'machines_purchase', to: 'purchases#machine'
  get 'parts_purchase', to: 'purchases#part'
  get 'needles_purchase', to: 'purchases#needle'
  get 'motors_purchase', to: 'purchases#motor'
  get 'tables_purchase', to: 'purchases#table'
  get 'stands_purchase', to: 'purchases#stand'
  # Purchase cart
  get 'purchase_cart', to: 'purchases#cart'
  get 'add_to_cart', to: 'purchases#add_cart' 
  get 'remove_from_cart', to: 'purchases#remove_cart' 
  post 'update_purchase_cart', to: 'purchases#update_cart' 
  get 'update_purchase_cart', to: 'purchases#update_cart' 
  
  # Msalecart
  get 'machines_sale', to: 'msales#machine'
  get 'tables_sale', to: 'msales#table'
  get 'motors_sale', to: 'msales#motor'
  get 'stands_sale', to: 'msales#stand'
  # Sale cart
  get 'parts_sale', to: 'sales#part'
  get 'needles_sale', to: 'sales#needle'

  # Msale Cart
  get 'msale_cart', to: "msales#cart"
  get 'add_to_msale_cart', to: "msales#add_cart"
  get 'remove_from_msale_cart', to: 'msales#remove_cart' 
  post 'update_msale_cart', to: 'msales#update_cart' 
  get 'update_msale_cart', to: 'msales#update_cart' 
  # Sale Cart
  get 'sale_cart', to: "sales#cart"
  get 'add_to_sale_cart', to: "sales#add_cart"
  get 'remove_from_sale_cart', to: 'sales#remove_cart' 
  post 'update_sale_cart', to: 'sales#update_cart' 
  get 'update_sale_cart', to: 'sales#update_cart' 
  
  # Debt and Delivery and Chassis
  get 'msale_chassis', to: 'msales#chassis'
  post 'update_msale_chassis_cart', to: 'msales#update_msale_chassis' 
  # get 'update_msale_chassis_cart', to: 'msales#update_msale_chassis' 
  get 'print_chassis', to: 'msales#print_chassis'
  

  # Login
  post 'admin_login', to: "home#admin_login"
  get "admin_logout", to: "home#destroy"
  get "post_pone_sale", to: "home#post_pone_sale"
  get "all_sale", to: "home#all_sale"

  get "staff_login", to: "staffs#login"
  get "staff_home", to: "sessions#home"
  get "print_in_ks", to: "sales#print"
  post "validate", to: "sessions#new"
  get "logout", to: "sessions#destroy"

  resources :admins
  resources :sales
  resources :deliveries
  resources :withdraws
  resources :chasses
  resources :debts 
  resources :msales
  resources :purchases
  resources :staffs
  resources :parts
  resources :needles
  resources :currencies
  resources :machines
  resources :stands
  resources :tables
  resources :motors
  root 'home#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
