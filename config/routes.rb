Rails.application.routes.draw do
  resources :purchases
  get 'machines_purchase', to: 'purchases#machine'
  get 'parts_purchase', to: 'purchases#part'
  get 'needles_purchase', to: 'purchases#needle'
  get 'motors_purchase', to: 'purchases#motor'
  get 'tables_purchase', to: 'purchases#table'
  get 'stands_purchase', to: 'purchases#stand'
  
  get 'machines_sale', to: 'sales#machine'

  get 'purchase_cart', to: 'purchases#cart'
  get 'add_to_cart', to: 'purchases#add_cart' 
  get 'remove_from_cart', to: 'purchases#remove_cart' 
  post 'update_purchase_cart', to: 'purchases#update_cart' 
  get 'update_purchase_cart', to: 'purchases#update_cart' 
  

  devise_for :staffs
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
