Rails.application.routes.draw do

  resources :badges, only: [:create]

end
