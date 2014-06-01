Rails.application.routes.draw do

  resources :badges, only: [:create]

  resources :leader_boards, only: [:index]

end
