Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:id', to: 'trees#show'
  get '/:tree_id/parent/:id', to: 'trees#parents'
  get '/:tree_id/child/:id', to: 'trees#childrens'
end
