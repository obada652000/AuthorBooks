Rails.application.routes.draw do
  devise_for :authors
  resources :books
  devise_scope :author do
    get '/authors/sign_out' => 'devise/sessions#destroy'
  end
  resources :authors, except: [:new, :create, :edit, :update, :destroy]
  root 'books#index'
end
