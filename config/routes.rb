Rails.application.routes.draw do
  get 'friendship/index'

  get 'friendship/show'

  get 'friendship/create'

  #resources :messages, except: [:new, :edit]
  # resources :registers, except: [:new, :edit]
  # post 'register/add_user' => 'registers#add_user'
  # get 'register/add_user'

  post '/user' => 'users#create'
  post '/users/from_company' => 'users#show_from_company'
  post '/user/update' => 'users#update'
  post '/user/destroy' => 'users#destroy'
  post '/user/search' => 'users#search'
  post '/user/member' => 'users#create_member'
  post '/user/change_password' => 'users#change_password'
  post '/user/show' => 'users#show'
  post '/user/show/additional_details' => 'users#additional_details'
  post '/user/show/additional_details/update' => 'users#additional_details_update'
  post '/user/show/planner_info' => 'users#planner_info'
  post '/user/show/planner_info/location' => 'users#planner_info_location'
  post '/users/investors' => 'users#investors'
  post '/user/create_admin' => 'users#create_admin'
  post '/user/update_admin' => 'users#update_admin'
  post '/users/meeting_location' => 'users#meeting_location'

  #meetings
  post '/meetings/show' => 'meetings#show'
  post '/meeting/new' => 'meetings#new'
  

  post '/logins/authenticate_user' => 'logins#authenticate_user' 
  get '/logins/authenticate_user'

  post '/messages/show' => 'messages#show' 
  post '/messages/index' => 'messages#index'
  post '/messages/send' => 'messages#create'

  post '/companies' => 'companies#index'
  post '/companies/small/not_investors' => 'companies#index_small_not_investors'
  post '/companies/small' => 'companies#index_small'
  post '/companies/small/investors' => 'companies#index_small_investors'
  post '/company/show' => 'companies#show'
  post '/company/update' => 'companies#update'

  get '/companies' => 'companies#index'
  post '/company/show' => 'companies#show'
  post '/company/update_admin' => 'companies#update_admin'
  post '/company/create' => 'companies#create'
  post '/company/search' => 'companies#search'
  post '/company/destroy' => 'companies#destroy'

  post '/users/friends' => 'users#friends'

  post '/favourites' => 'interests#show'
  post '/favourites/update' => 'interests#update'
  post '/favourites/me' => 'interests#show_interested_in_me'
  post '/invites/companies' => 'interests#show_interested_companies'
  post '/invites/investors' => 'interests#show_interested_investors'
  post '/declineInvite' => 'interests#delete_interest'
  post '/matches' => 'matches#show'
  post '/matches_interested' => 'matches#show_interested_investors'
  post '/matches/update' => 'matches#update'

  post '/invite' => 'invite#send_emails'

  post '/events' => 'events#index'

  post '/appointment' => 'appointments#new'
  post '/company_appointments' => 'appointments#company'
  post '/investor_appointments' => 'appointments#investor'
  post '/accept_appointment' => 'appointments#accept_appointment'

  post '/tags' => 'tags#index'
  post '/tags/relations/' => 'tags#index_relations'
  post '/tags/from_user' => 'tags#index_from_user'
  post '/tags/relations/from_user' => 'tags#index_relations_from_user'
  post '/tags/save' => 'tags#add_tag'

  post '/forgot_pass/0' => 'users#forgot_password_step_0'
  post '/forgot_pass/1' => 'users#forgot_password_step_1'
  post '/forgot_pass/2' => 'users#forgot_password_step_2'

  match '*any' => 'application#options', :via => [:options]

end