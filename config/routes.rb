Rails.application.routes.draw do
  resources :coche_datos do
		collection do
			get :search
			get :ajax_search
			get :retrieve_searches
			get :buscar_autocomplete
			get :index_latest_autocomplete
			get :buscar_latest_autocomplete # fetches JSON data via GET request

			get :search_all_cars
			post :noCar_noOrigin_noYear_noMpg_noHorsepower 
			post :yesCar_noOrigin_noYear_noMpg_noHorsepower 
			post :noCar_noOrigin_noYear_noMpg_yesHorsepower
			post :noCar_noOrigin_noYear_yesMpg_noHorsepower
			post :noCar_noOrigin_noYear_yesMpg_yesHorsepower
			post :noCar_noOrigin_yesYear_noMpg_noHorsepower
			post :noCar_noOrigin_yesYear_noMpg_yesHorsepower
			post :noCar_noOrigin_yesYear_yesMpg_noHorsepower

			post :noCar_noOrigin_yesYear_yesMpg_yesHorsepower
			post :noCar_yesOrigin_noYear_noMpg_noHorsepower
			post :noCar_yesOrigin_noYear_noMpg_yesHorsepower
			post :noCar_yesOrigin_noYear_yesMpg_noHorsepower
			post :noCar_yesOrigin_noYear_yesMpg_yesHorsepower
			post :noCar_yesOrigin_yesYear_noMpg_noHorsepower
			post :noCar_yesOrigin_yesYear_noMpg_yesHorsepower
			post :noCar_yesOrigin_yesYear_yesMpg_noHorsepower
			post :noCar_yesOrigin_yesYear_yesMpg_yesHorsepower
			# post :yesCar_noOrigin_noYear_noMpg_noHorsepower
			post :yesCar_noOrigin_noYear_noMpg_yesHorsepower
			post :yesCar_noOrigin_noYear_yesMpg_noHorsepower
			post :yesCar_noOrigin_noYear_yesMpg_yesHorsepower
			post :yesCar_noOrigin_yesYear_noMpg_noHorsepower
			post :yesCar_noOrigin_yesYear_noMpg_yesHorsepower
			post :yesCar_noOrigin_yesYear_yesMpg_noHorsepower
			post :yesCar_noOrigin_yesYear_yesMpg_yesHorsepower
			post :yesCar_yesOrigin_noYear_noMpg_noHorsepower
			post :yesCar_yesOrigin_noYear_noMpg_yesHorsepower
			post :yesCar_yesOrigin_noYear_yesMpg_noHorsepower
			post :yesCar_yesOrigin_noYear_yesMpg_yesHorsepower
			post :yesCar_yesOrigin_yesYear_noMpg_noHorsepower
			post :yesCar_yesOrigin_yesYear_noMpg_yesHorsepower
			post :yesCar_yesOrigin_yesYear_yesMpg_noHorsepower
			post :yesCar_yesOrigin_yesYear_yesMpg_yesHorsepower
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
			post :post_car_name
		end
	end

	post 'statics/execute_search', to: 'statics#execute_search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	# root 'statics#index'
end
