Rails.application.routes.draw do
  resources :groups
  resources :venues
  resources :interests
  # get 'notifications/link_through'

  get '/calendar' => 'calendar#index'
  get 'notifications/:id/link_through', to: 'notifications#link_through',
      as: :link_through
  get '/notifications'=>"notifications#index"
  resources :events
  # resources :events
  # devise_for :users
  get 'static_pages/index'
  get 'static_pages/dashboard'




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#dashboard'

  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/terms_of_service' => 'static_pages#terms_of_service',via: [:get], :as => :terms_of_service
  match '/privacy' => 'static_pages#privacy',via: [:get], :as => :privacy
  match '/safety_guidelines' => 'static_pages#safety_guidelines',via: [:get], :as => :safety_guidelines
  match '/contact' => 'static_pages#contact', via: [:get],:as => :contact


  # match '/calendar/events' => 'calendar#events', via: [:get], :as => :calendar_events
  devise_for :users, :controllers => {:registrations => "users/registrations",omniauth_callbacks: 'omniauth_callbacks'}
  resources :calendar do
    get :get_events, on: :collection
  end

  resources :users do
    get :get_interests, :on => :collection
  end
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
