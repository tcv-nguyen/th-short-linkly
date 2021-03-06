Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:id' => 'short_links#show', as: :short_link
  get '/:id/analytics' => 'short_links#analytic'
  resources :short_links, only: [:show, :create]
end
