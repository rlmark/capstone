Rails.application.routes.draw do

  get 'results/show', to: 'results#show', as: :results

  # Questions routes
  resources :questions
  # get 'questions',    to: 'questions#index',    as: :questions
  # get 'questions/new',      to: 'questions#new',      as: :new_question
  # post 'questions',  to: 'questions#create'
  # get 'question/:id',       to: 'questions#show',     as: :question
  # patch 'question/:id',     to: 'questions#update'
  # delete 'question/:id',    to: 'questions#destroy'
  # get 'question/:id/edit', to: 'questions#edit',     as: :edit_question

  # Interview response routes
  get 'responses',          to: 'responses#index',   as: :responses
  get 'responses/new',      to: 'responses#new',     as: :new_response
  post 'responses',         to: 'responses#create'
  get 'response/:id',       to: 'responses#show',    as: :response
  patch 'response/:id',     to: 'responses#update'
  delete 'response/:id',    to: 'responses#destroy'
  get 'response/:id/edit',  to: 'responses#edit',    as: :edit_response

  # Home
  get '/', to: 'welcome#index', as: :root

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
