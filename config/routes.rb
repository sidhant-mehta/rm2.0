RaisonMentors20::Application.routes.draw do
  
  devise_for :admins, :skip => [:registrations]   
    as :admin do
      get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'    
      put 'admins' => 'devise/registrations#update', :as => 'admin_registration'            
    end
    
#match "clients/sign_up", :to => "pages#home" #to stop people signing up as clients, while still allowing the admin to use the devise registrations
  devise_for :clients, :skip => [:registrations]     #stops clients/organisations registering on their own. We register them.                                     
    as :client do
      get 'clients/edit' => 'devise/registrations#edit', :as => 'edit_client_registration'    
      put 'clients' => 'devise/registrations#update', :as => 'client_registration'            
    end

  devise_for :members, controllers: { confirmations: 'confirmations' }

  
  
post "application/apply_mentor" => "application#mentor"
post "application/apply_project" => "application#project"
resources :application, :collection => { :apply_mentor => :post, :apply_project => :post }
  

  match "about_us/" => "about_us#index"

  get "about_us/how_it_works"

  get "about_us/our_philosophy"

  get "about_us/meet_the_team"
  get "pages/add_a_project"
  get "pages/become_a_mentor"
  get "pages/privacy_policy"

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
  #get "members/list_internal_projects"
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
  get "admin/dashboard/download/:id" => "admin#download"
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
  match "admin/edit_employer_profile/:id" => "admin#edit_employer_profile"
  put "admin/update_employer_profile/:id" => "admin#update_employer_profile" 
#members
  get "admin/new_member"
  post "admin/create_member" => "admin#create_member"
  get "admin/edit_member/"
  match "admin/edit_member/:id" => "admin#edit_member"
  put "admin/update_member/:id" => "admin#update_member" 
  get "admin/list_members"
  get "admin/list_members/reset_password/:id" => "admin#member_password_reset"
#clients
  get "admin/new_client" => "admin#new_client"
  post "admin/create_client" => "admin#create_client"
  get "admin/edit_client/"
  match "admin/edit_client/:id" => "admin#edit_client"
  put "admin/update_client/:id" => "admin#update_client" 
  get "admin/list_clients"
  delete 'admin/destroy_client/:id' => 'admin#destroy_client'  
  get "admin/adverts"
  get "admin/team"
#org email
  get "admin/new_organisation_email" => "admin#new_organisation_email"
  post "admin/create_organisation_email" => "admin#create_organisation_email"
  get "admin/edit_organisation_email"
  match "admin/edit_organisation_email/:id" => "admin#edit_organisation_email"
  put "admin/update_organisation_email/:id" => "admin#update_organisation_email" 
  get "admin/list_organisation_emails"
  get "admin/destroy_organisation_email/:id" => "admin#destroy_organisation_email"
  delete "admin/destroy_organisation_email/:id" => "admin#destroy_organisation_email"
 #sector 
  get "admin/new_sector" => "admin#new_sector"
  post "admin/create_sector" => "admin#create_sector"
  get "admin/edit_sector"
  match "admin/edit_sector/:id" => "admin#edit_sector"
  put "admin/update_sector/:id" => "admin#update_sector" 
  get "admin/list_sectors"
  get "admin/destroy_sector/:id" => "admin#destroy_sector"
  delete "admin/destroy_sector/:id" => "admin#destroy_sector"
   #location
  get "admin/new_location" => "admin#new_location"
  post "admin/create_location" => "admin#create_location"
  get "admin/edit_location"
  match "admin/edit_location/:id" => "admin#edit_location"
  put "admin/update_location/:id" => "admin#update_location" 
  get "admin/list_locations"
  get "admin/destroy_location/:id" => "admin#destroy_location"
  delete "admin/destroy_location/:id" => "admin#destroy_location"
  
  
  get "employers/search" => "employer_profiles#search"
  post "employers/search" => "employer_profiles#search"
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