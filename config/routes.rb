Rails.application.routes.draw do
  resources :coche_datos do
		collection do
			get :search
			get :ajax_search
			get :retrieve_searches
			get :buscar_autocomplete
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
		end
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	# root 'statics#index'
end
