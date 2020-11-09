Rails.application.routes.draw do
  root 'home#index'
  post "match/schedule_results/:id" => "match/schedule_results#update"
  resource :match do
    resources :schedule_results, controller: 'match/schedule_results', only: [:index, :new, :create , :edit, :destroy]
  end
end
