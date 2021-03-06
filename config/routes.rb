Portal::Application.routes.draw do

  resources :responses, :only => [:new, :create]
  resources :attempts, :only => [:show, :update, :destroy, :edit]
  resources :answers, :only => [:show, :index, :edit]
  resources :questions, :except => [:show]
  resources :quizzes
  resources :units
  resources :posts, :only => [:new, :create, :index]
  resources :lectures do 
    resources :lecture_questions, :except => [:index]
  end
  resources :comments, :only => [:new, :create]
  resources :components, :only => [:destroy, :update]
  
  devise_for :users, :skip => [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users' => 'registrations#update', :as => 'user_registration'            
    end

  devise_scope :user do
    root :to => "devise/sessions#new"
  end

  get "discussions" => "discussions#index", :as => "manage_discussions"
  post "attempts/new/:quiz_id/:user_id" => "attempts#create", :as => "new_attempt"
  get "attempts/new/:quiz_id/:user_id" => "attempts#new", :as => "new_attempt"
  get "/users/:id" => "users#show", :as => "user_root"
  get "/questions/:quiz_id/new" => "questions#new", :as => "question_new"
  get "/users/:user_id/gradebook" => "gradebooks#show", :as => "user_gradebook"

  resources :discussions


  resources :users, :only => [:index]
  post "/users/update" => "users#update", :as => "user_role_update"
  
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
