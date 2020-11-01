Rails.application.routes.draw do
  root 'home#index'
  resource :match do
    resources :schedule_results, controller: 'match/schedule_results'
  end
end
