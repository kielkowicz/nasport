Nasport::Application.routes.draw do
  resources :cities do
    member do
      get 'places'
    end
  end

  resources :disciplines
  
  resources :events do
    member do
      get 'join'
      get 'resign'
      get 'mine'
    end

    collection do
      get 'search'
    end

    resources :reports
  end
  
  get 'reports' => 'reports#all'
  
  get 'update_archive' => 'notifiers#mark_archive_events', :defaults => { :format=>:json }
  get 'notifie' => 'notifiers#find_in_one_day'
  get 'send_reminder' => 'notifiers#send_reminder', :defaults => {:format=>:json}

  resources :places do
    member do
      get 'events/:day', :action => 'events', :as => 'events_at'
    end
    
    collection do 
      get 'geocode'
    end
  end
  
  devise_for :users
  
  match '/users/:user_id/profile' => 'Profiles#show', :as => 'user_profile' # not really a RESTFul way...

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
  root :to => 'welcome#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
