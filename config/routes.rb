XitracsRoster::Application.routes.draw do



  
  resources :newhirecredentials

  resources :donesemesters
  resources :reviewreasons
  resources :semesters
  resources :users
  #resources :precredentialing
  resources :newhires do
     collection do
        get  'review_course'
        post 'review_course'
    end
  end

  resources :newhirecourses
  resources :newhirecredits
  resources :newhirecomment
  resources :newhiredocuments do
     collection do
        get  'uploadform'
        post 'uploadform'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "/quick/criteria"
  get "/quick/dean_signoff"
  get "/quick/mark_signed_off"
  get "/quick/show_reason_details"

  get "/report/users"
  get "/report/summary"
  get "/report/search_by_credit_course"
  get "/report/report_not_passed"
  get "/report/report_not_passed_detailed"
  get "/report/report_criteria"
  get "/report/report_credentialing_not_completed"
  get "/report/report_credentialing"
  get "/report/report_not_passed_and_not_deansignoff"
  get "/report/report_reviewstate"
  get "/report/course_and_faculty_summary"
  get "/report/report_faculty_course"

  get "wizard/course"
  get "wizard/faculty"
  get "wizard/department"
  get "wizard/show_courses_for"
  get "wizard/show_course_summary"

  get "wizard/justify_course_for"
  get "wizard/approve_course_for"
  put "wizard/approve_course_for"
  get "wizard/approve_course_done"

  get "wizard/process_justification"
  put "wizard/process_justification"
  post "wizard/process_justification"
  get "wizard/process_justification_done"
  post "wizard/process_justification_done"

  get "wizard/process_justification_signoff_or_done"

  get "wizard/process_justification_deansignoff"
  put "wizard/process_justification_deansignoff"
  
  get "/wizard/process_justification_comments"
  post "/wizard/process_justification_comments"
  put "/wizard/process_justification_comments"
  get "/wizard/process_justification_exception"
  post "/wizard/process_justification_exception"
  put "/wizard/process_justification_exception"
  put "/wizard/process_reason_facultycredential"

 
  get "/wizard/find"
  get "/wizard/process_justification_coursework"
  put "/wizard/process_justification_coursework"
  post "/wizard/process_justification_coursework"
  post "/sessions/create"

  get "users/new"

  get "/precredentialing/credentialsform"
  get "/precredentialing/name"
   get "/precredentialing/courses"

  post "/precredentialing/savecomments"
  put "/precredentialing/savecomments"
  post "/precredentialing/file_upload"
  put "/precredentialing/file_upload"
  
  post "newhires/courses"
  post "newhires/create"
  
  get  "newhires/review_course"
  post "newhires/review_course"

  get "newhires/show"
  #get "newhires/displaydetails"

  get  "/newhiredocuments/uploadform"
  post "/newhiredocuments/uploadform"

  post "/newhiredocuments/file_upload"
  put  "/newhiredocuments/file_upload"

  get  "/newhiredocuments/uploadstatus"
  post  "/newhiredocuments/uploadstatus"

  get  "newhirecomment/index"
  get  "newhirecomment/create"
  post "newhirecomment/create"

  root to: 'sessions#new'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/start', to: 'static_pages#start'
  match '/reports', to: 'report#index'
  match '/quick', to: 'quick#index'
  match '/precredentialing', to: 'static_pages#precredentialing'

  match '/register', to: 'static_pages#register'

  match '/reports', to: 'report#index'
  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'

  match "/newhires/:id/displaydetails" => 'newhires#displaydetails', :as => :newhiredetails

  match "/newhires/review_course" => 'newhires#review_course', :as => :newhire_review_course

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
  # match ':controller(/:action(/:id(.:format)))'
end
