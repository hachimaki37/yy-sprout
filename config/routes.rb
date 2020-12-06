Rails.application.routes.draw do
  root 'homes#index'

  # schedule_results page
  #TODO: as使いたい
  post "match/schedule_results/:id", to: "match/schedule_results#update"
  resource :match do
    resources :schedule_results, controller: 'match/schedule_results', only: [:index, :new, :create , :edit, :destroy]
  end

  # contact page
  resources :contacts, only: [:index] do
    collection do
      post :confirm
      post :thanks
    end
  end

  devise_for :users

  # admin page
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # 準備中 page
  get 'preparation', to: 'preparation#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
