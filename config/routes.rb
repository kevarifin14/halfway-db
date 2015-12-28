# curl halfway-db.herokuapp.com/v1/login --data "email=foo@bar.com&username=user&password=Password1"
# curl localhost:3000/v1/login --data "email=foo@bar.com&username=user&password=Password1"
# curl localhost:3000/v1/signup --data "email=foo@bars.com&username=users&password=Password1&password_confirmation=Password1"
# curl halfway-db.herokuapp.com/v1/signup --data "email=foo@bars.com&username=users&password=Password1&password_confirmation=Password1"


Rails.application.routes.draw do
  shallow do
    devise_for :user, only: []

    namespace :v1, defaults: { format: :json } do
      resource :login, only: [:create], controller: :sessions
      resource :signup, only: [:create], controller: :registrations
      resources :users, only: [:index, :update] do
        resources :friendships, only: [:index, :create]
        resources :groups, only: [:index, :create]
        resources :events, only: [:index, :create, :destroy, :show]
          resources :invitations, only: [:update]
      end
    end
  end
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
