Rails.application.routes.draw do
  resources :coche_datos do
		collection do
			get :search
			get :ajax_search
		end
	end

	# root 'coche_datos#index'
	root 'statics#home'

  resources :statics do
		collection do
			get :test
			get :get_data
		end
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	# root 'statics#index'
end
