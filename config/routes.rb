Cm::Application.routes.draw do

  match 'login' => "application#login"
  get 'logout'  => "application#logout"

  resources :clients, :except => [:new, :create] do
    get :refresh, :on => :collection
  end
  resources :days, :only => [:index, :update, :destroy]
  resources :exchange_rates do
    get :refresh, :on => :collection
  end
  resources :delegations
  resources :account_balances, :except => [:index]
  resources :banks do
    resources :accounts
  end
  resources :invoices do
    get :refresh, :on => :collection
    get :pdf, :on => :member
    get :rate, :on => :member
  end

  root :to => 'invoices#index'
end
