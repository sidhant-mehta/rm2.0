RaisonMentors20::Application.routes.draw do
  
  get "members/dashboard"
  
  get "clients/list_projects"

  get "clients/add_project"

  get "clients/edit_project"

  get "clients/list_mentors"

  get "clients/add_mentor"

  get "clients/edit_mentor"

  get "clients/list_jobs"

  get "clients/add_job"

  get "clients/edit_job"

  get "clients/dashboard"

  get "clients/profle"

  get "admin/login"

  get "admin/dashboard"

  get "admin/adverts"

  get "admin/team"

  get "admin/members"

  get "admin/mentors"

  get "admin/projects"

  get "admin/clients"

  get "admin/jobs"

  get "admin/employer_profiles"

  devise_for :admins

  devise_for :clients

  devise_for :members

  resources :employer_profiles


  resources :teams


  resources :adverts


  resources :projects


  resources :mentors


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
  
  # TODO need to change the root to point to a home page
  root :to => 'mentors#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
