RaisonMentors20::Application.routes.draw do
  devise_for :admins

  devise_for :clients

  devise_for :members

  get "about_us/index"
  get "about_us/what_we_do"
  
  get "about_us/how_it_works"

  get "about_us/our_philosophy"

  get "about_us/meet_the_team"

  get "pages/our_policy"

  get "pages/terms_of_use"

  get "pages/terms_and_conditions"

  get "pages/contact_us"

  get "pages/confirmation"

  get "pages/register"

  get "pages/home"
  
  get "members/sign_out"
  match "members/profile", :to => "members#profile", :as => :member
  get "members/settings"
  get "members/applications"
  get "members/" => "members#dashboard"
  get "members/dashboard"
  post "members/update" => "members#update"
  
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

  resources :employer_profiles


  resources :teams


  resources :adverts

  get "projects/search" => "projects#search"
  resources :projects
  post "projects/apply" => "projects#apply"
  post "projects/search" => "projects#search"
  
  get "mentors/search" => "mentors#search"  
  resources :mentors
  post "mentors/apply" => "mentors#apply"
  post "mentors/search" => "mentors#search"

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
  
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
