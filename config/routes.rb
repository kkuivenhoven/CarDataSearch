Rails.application.routes.draw do
  resources :coche_datos do
		collection do
			get :search
			get :ajax_search
			get :retrieve_searches
			get :buscar_autocomplete
			get :index_latest_autocomplete
			get :buscar_latest_autocomplete # fetches JSON data via GET request
		end
	end

	# root 'coche_datos#index'
	# root 'statics#home'
	root 'coche_datos#index_autocomplete'
	# get 'coche_datos/buscar_autocomplete', to: 'coche_datos#buscar_autocomplete'

  resources :statics do
		collection do
			get :test
			get :get_data
			get :hide_data
			get :renovated_search
			post :retrieve_searches
		end
	end

	post 'statics/execute_search', to: 'statics#execute_search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	# root 'statics#index'
end
