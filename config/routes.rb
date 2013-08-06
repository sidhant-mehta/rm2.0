RaisonMentors20::Application.routes.draw do
  devise_for :admins

  devise_for :clients

  devise_for :members

post "application/apply_mentor" => "application#mentor"
post "application/apply_project" => "application#project"
resources :application, :collection => { :apply_mentor => :post, :apply_project => :post }
  

  get "about_us/index"
  get "about_us/what_we_do"

  get "about_us/how_it_works"

  get "about_us/our_philosophy"

  get "about_us/meet_the_team"

  get "pages/our_policy"

  get "pages/terms_of_use"

  get "pages/terms_and_conditions"

  get "pages/contact_us"
  post "pages/send_email" => "pages#send_email"
  get "pages/confirmation"

  get "pages/register"

  get "pages/home"
  
  get "members/sign_out"
  match "members/profile", :to => "members#profile", :as => :member
  get "members/settings"
  get "members/applications" 
  get "members/" => "members#dashboard"
  get "members/dashboard"
  put "members/update" => "members#update"
  get "members/new_mentor" 
  post "members/create_mentor" =>"members#create_mentor"
  get "members/edit_mentor"
  get "members/destroy_mentor"
  put "members/create_mentor" => "members#update_mentor"
  get "members/list_internal_mentors"
  match "members/mentors/search" => "members#search_mentor"
  get "members/list_projects"
  get "members/list_internal_projects"
  match "members/projects/search" => "members#search_project"
  get "members/edit_project"
  match "members/edit_project/:id/:name" => "members#edit_project"
  put "members/edit_project" => "members#update_project"
  get "members/new_project"
  post "members/create_project" => "members#create_project"
  
  get "clients/settings"
  put "clients/settings" => "clients#update_client"
  get "clients/list_projects"
  get "clients/new_project"
  post "clients/create_project" => "clients#create_project"
  get "clients/edit_project"
  match "clients/edit_project/:id/:name" => "clients#edit_project"  
  put "clients/edit_project" => "clients#update_project"
  get "clients/list_mentors"

  get "clients/new_mentor"
  post "clients/create_mentor" => "clients#create_mentor"
  get "clients/edit_mentor"
  match "clients/edit_mentor/:id/:fname" => "clients#edit_mentor"
  put "clients/edit_mentor" => "clients#update_mentor"
  get "clients/list_jobs"

  get "clients/add_job"

  get "clients/edit_job"

  get "clients/dashboard" 

  get "clients/profile"
  post "clients/profile_update" => "clients#profile_update"
  put "clients/profile_update" => "clients#profile_update"

  get "admin/login" => "admin#dashboard"
  get "admin/dashboard"
  get "admin/settings"
  put "admin/settings" => "admin#update_admin"
  get "admin/profile"
  post "admin/profile_update" => "admin#profile_update"
  put "admin/profile_update" => "admin#profile_update"
#projects  
  get "admin/list_projects"
  get "admin/new_project"
  post "admin/create_project" => "admin#create_project"
  get "admin/edit_project"
  match "admin/edit_project/:id/:name" => "admin#edit_project"  
  put "admin/edit_project" => "admin#update_project"
 #mentors 
  get "admin/list_mentors"
  get "admin/new_mentor"
  post "admin/create_mentor" => "admin#create_mentor"
  get "admin/edit_mentor"
  match "admin/edit_mentor/:id/:fname" => "admin#edit_mentor"
  put "admin/edit_mentor" => "admin#update_mentor"
 #employer profile 
  get "admin/list_employer_profiles"
  get "admin/new_employer_profile"
  post "admin/create_employer_profile" => "admin#create_employer_profile"
  get "admin/edit_employer_profile"
  match "admin/employer_profile/:id/:fname" => "admin#employer_profile"
  put "admin/employer_profile" => "admin#employer_profile" 

  get "admin/adverts"
  get "admin/team"
  get "admin/members"


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
