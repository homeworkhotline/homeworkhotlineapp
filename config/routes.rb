Rails.application.routes.draw do

  resources :call_logs
  resources :schools
  resources :students
  resources :searches
devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

# or
resources :user, only: [:show]

  resources :principals
  resources :time_clocks
  resources :mnps_reports
  resources :image_shares, only: [:new, :create, :show]
  get '/devstats', to: 'home#devstats', as: 'devstats'
  get '/employees', to: 'home#employees', as: 'employees'
  get '/statistics', to: 'home#statistics', as: 'statistics'
  get '/sessioninfo/:id', to: 'home#sessioninfo', as: 'sessioninfo'
  get '/all_mnps_reports/:id', to: 'mnps_reports#all_reports', as: 'all_mnps_reports'
  get '/principals/dlnab/:id', to: 'principals#dlnab', as: 'dlnab'
  get '/principals/dlsnl/:id', to: 'principals#dlsnl', as: 'dlsnl'
  get '/principals/dlnice/:id', to: 'principals#dlnice', as: 'dlnice'
  post '/principals/email/:id', to: 'principals#sendmail', as: 'sendmail'
  post '/genschools', to: 'home#genschools', as: 'genschools'



  root 'time_clocks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
