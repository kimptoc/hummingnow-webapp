Walloftweets::Application.routes.draw do

  constraints :subdomain => "www" do
    get "*path" => redirect {|params, req| "http://hummingnow.com" }
  end


#  if Rails.env.development?
#    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
#
#    mount TestTrack::Engine => "test"
#  end

  devise_for :users

  root :to => 'home#index'

  get '/auth/:provider/callback' => 'authentications#create'
  resources :authentications
  get '/auth/failure' => 'authentications#index'

  search_chars = {:query => /[^\/]+/ }

  get '/home(/:nickname)' => 'home#index'
  get '/mentions/:nickname' => 'home#mentions'
  get '/dm/:nickname' => 'home#dm'
  get '/mine/:nickname' => 'home#mine'
  get '/list/:nickname/:list_id' => 'home#list'
  get '/public(/:nickname)' => 'home#public'
  get '/user/:screen_name(/:nickname)' => 'home#user'
  get '/search(/:query(/:nickname))' => 'home#search', :constraints => search_chars
  get '/about(/:nickname)' => 'home#about'

  get '/tweets/:nickname' => 'tweets#index'
  get '/tweet_mentions/:nickname' => 'tweets#mentions'
  get '/tweet_dms/:nickname' => 'tweets#dm'
  get '/tweet_mine/:nickname' => 'tweets#mine'
  get '/tweet_public(/:nickname)' => 'tweets#public'
  get '/tweet_user/:screen_name(/:nickname)' => 'tweets#user'
  get '/tweet_search(/:query(/:nickname))' => 'tweets#phoenix_search', :constraints => search_chars
  get '/tweet_list/:nickname/:list_id' => 'tweets#list'
  post '/tweet/:nickname' => 'tweets#tweet'
  post '/retweet/:nickname' => 'tweets#retweet'
  #match '/wall' => 'tweets#wall'

  get '/thumb/:query' => 'thumb#for_url', :constraints => search_chars

  resources :user_settings

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
