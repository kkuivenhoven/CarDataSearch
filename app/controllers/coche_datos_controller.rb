class CocheDatosController < ApplicationController
  # before_action :set_coche_dato, only: %i[ show edit update destroy ]
	# before_action :force_json, only: [:buscar_autocomplete, :buscar_latest_autocomplete]
	before_action :force_json, only: [:buscar_autocomplete, :buscar_latest_autocomplete]

	def search_all_cars
	end

	# DONE •••
	def noCar_noOrigin_noYear_noMpg_noHorsepower ###
    @matches = CocheDato.all
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def yesCar_noOrigin_noYear_noMpg_noHorsepower ###
    @matches = CocheDato.yesCar_noOrigin_noYear_noMpg_noHorsepower(params["carName"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_noYear_noMpg_yesHorsepower ###
    @matches = CocheDato.noCar_noOrigin_noYear_noMpg_yesHorsepower(params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_noYear_yesMpg_noHorsepower ###
		@matches = CocheDato.noCar_noOrigin_noYear_yesMpg_noHorsepower(params["mpgLower"], params["mpgHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_noYear_yesMpg_yesHorsepower ###
		@matches = CocheDato.noCar_noOrigin_noYear_yesMpg_yesHorsepower(params["mpgLower"], params["mpgHigher"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_yesYear_noMpg_noHorsepower ###
		@matches = CocheDato.noCar_noOrigin_yesYear_noMpg_noHorsepower(params["yearVal"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_yesYear_noMpg_yesHorsepower ###
		@matches = CocheDato.noCar_noOrigin_yesYear_noMpg_yesHorsepower(params["yearVal"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_yesYear_yesMpg_noHorsepower ###
		@matches = CocheDato.noCar_noOrigin_yesYear_yesMpg_noHorsepower(params["yearVal"], params["mpgLower"], params["mpgHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_noOrigin_yesYear_yesMpg_yesHorsepower
		@matches = CocheDato.noCar_noOrigin_yesYear_yesMpg_yesHorsepower(params["yearVal"], params["mpgLower"], params["mpgHigher"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false }
		end
	end

	# DONE •••
	def noCar_yesOrigin_noYear_noMpg_noHorsepower ###
		@matches = CocheDato.noCar_yesOrigin_noYear_noMpg_noHorsepower(params["originName"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# DONE •••
	def noCar_yesOrigin_noYear_noMpg_yesHorsepower ###
		@matches = CocheDato.noCar_yesOrigin_noYear_noMpg_yesHorsepower(params["originName"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false }
		end
	end

	# DONE •••
	def noCar_yesOrigin_noYear_yesMpg_noHorsepower
		@matches = CocheDato.noCar_yesOrigin_noYear_yesMpg_noHorsepower(params["originName"], params["mpgLower"], params["mpgHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false }
		end
	end

	# DONE •••
	def noCar_yesOrigin_noYear_yesMpg_yesHorsepower
		@matches = CocheDato.noCar_yesOrigin_noYear_yesMpg_yesHorsepower(params["originName"], params["mpgLower"], params["mpgHigher"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false }
		end
	end

	# DONE •••
	def noCar_yesOrigin_yesYear_noMpg_noHorsepower ###
		@matches = CocheDato.noCar_yesOrigin_yesYear_noMpg_noHorsepower(params["originName"], params["yearVal"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# -> in progress <-
	def noCar_yesOrigin_yesYear_noMpg_yesHorsepower
		@matches = CocheDato.noCar_yesOrigin_yesYear_noMpg_yesHorsepower(params["originName"], params["yearVal"], params["horsepowerLower"], params["horsepowerHigher"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# -- skip for now --
	def noCar_yesOrigin_yesYear_yesMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def noCar_yesOrigin_yesYear_yesMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_noYear_noMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_noYear_yesMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_noYear_yesMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# DONE •••
	def yesCar_noOrigin_yesYear_noMpg_noHorsepower ### 
		@matches = CocheDato.yesCar_noOrigin_yesYear_noMpg_noHorsepower(params["carName"], params["yearVal"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_yesYear_noMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_yesYear_yesMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_noOrigin_yesYear_yesMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# DONE •••
	def yesCar_yesOrigin_noYear_noMpg_noHorsepower ###
		@matches = CocheDato.yesCar_yesOrigin_noYear_noMpg_noHorsepower(params["carName"], params["originName"])
		respond_to do |format|
			format.js { render template: "coche_datos/display_car_data", layout: false}
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_noYear_yesMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_noYear_yesMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_yesYear_noMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_yesYear_noMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_yesYear_yesMpg_noHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	# -- skip for now --
	def yesCar_yesOrigin_yesYear_yesMpg_yesHorsepower
		respond_to do |format|
			format.js { render layout: false }
		end
	end


	def search
    @rhs_coches = CocheDato.all
		if (params[:search_coche_datos].nil? == false)
			query = params[:search_coche_datos].presence && params[:search_coche_datos][:query]
			country_origin = params[:search_coche_datos].presence && params[:search_coche_datos][:country_origin]
			mpg = params[:search_coche_datos].presence && params[:search_coche_datos][:MPG]
			mpg_two = params[:search_coche_datos].presence && params[:search_coche_datos][:MPG_two]
			mpg_checkbox = params[:search_coche_datos].presence && params[:search_coche_datos][:MPG_checkbox]
			model = params[:search_coche_datos].presence && params[:search_coche_datos][:model]
			horsepower = params[:search_coche_datos].presence && params[:search_coche_datos][:horsepower]
			horsepower_two = params[:search_coche_datos].presence && params[:search_coche_datos][:horsepower_two]

			if(!query.empty? && !mpg.empty? && !mpg_two.empty? && !country_origin.empty? && (mpg_checkbox == "1") && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCarNameMpgRangeCountry(query, mpg, mpg_two, country_origin)
			elsif(!query.empty? && !mpg.empty? && !mpg_two.empty? && (mpg_checkbox == "1") && country_origin.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCarNameMpgRange(query, mpg, mpg_two)
			elsif(!query.empty? && !mpg.empty? && !country_origin.empty? && (mpg_checkbox == "1") && mpg_two.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCarNameMpgCountry(query, mpg, country_origin)
			elsif(!query.empty? && !mpg.empty? && (mpg_checkbox == "1") && country_origin.empty? && mpg_two.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCarNameMpg(query, mpg)
			elsif(!country_origin.empty? && !mpg.empty? && !mpg_two.empty? && (mpg_checkbox == "1") && query.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByMpgRangeCountry(country_origin, mpg, mpg_two)
			elsif(!mpg.empty? && !mpg_two.empty? && (mpg_checkbox == "1") && country_origin.empty? && query.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByMpgRange(mpg, mpg_two)
			elsif(!mpg.empty? && !country_origin.empty? && (mpg_checkbox == "1") && mpg_two.empty? && query.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByMpgCountry(mpg, country_origin)
			elsif(!mpg.empty? && country_origin.empty? && (mpg_checkbox == "1") && mpg_two.empty? && query.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByMpg(mpg)
			elsif(!country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && query.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCountry(country_origin)
			elsif(!query.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && country_origin.empty? && model.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByCarName(query)
			elsif(!model.empty? && query.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && country_origin.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByModel(model)
			elsif(!model.empty? && !query.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && country_origin.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByQueryModel(query, model)
			elsif(!model.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByQueryModelCountry(query, model, country_origin)
			elsif(!model.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "1") && !mpg.empty? && mpg_two.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByQueryModelCountryMpg(query, model, country_origin, mpg)
			elsif(!model.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "1") && !mpg.empty? && !mpg_two.empty? && horsepower.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByQueryModelCountryMpgRange(query, model, country_origin, mpg, mpg_two)
			elsif(!horsepower.empty? && query.empty? && country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty? && query.empty? && horsepower_two.empty?)
				@coche_datos = CocheDato.searchByHorsepower(horsepower)
			elsif(!horsepower.empty? && !horsepower_two.empty? && query.empty? && country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty?)
				@coche_datos = CocheDato.searchByHorsepowerRange(horsepower, horsepower_two)
			elsif(!horsepower.empty? && !horsepower_two.empty? && !query.empty? && country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty?)
				@coche_datos = CocheDato.searchByHorsepowerRangeQuery(horsepower, horsepower_two, query)
			elsif(!horsepower.empty? && !horsepower_two.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "0") && mpg.empty? && mpg_two.empty?)
				@coche_datos = CocheDato.searchByHorsepowerRangeQueryCountry(horsepower, horsepower_two, query, country_origin)
			elsif(!horsepower.empty? && !horsepower_two.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "1") && !mpg.empty? && mpg_two.empty?)
				@coche_datos = CocheDato.searchByHorsepowerRangeQueryCountryMpg(horsepower, horsepower_two, query, country_origin, mpg)
			elsif(!horsepower.empty? && !horsepower_two.empty? && !query.empty? && !country_origin.empty? && (mpg_checkbox == "1") && !mpg.empty? && !mpg_two.empty?)
				@coche_datos = CocheDato.searchByHorsepowerRangeQueryCountryMpgRange(horsepower, horsepower_two, query, country_origin, mpg, mpg_two)
			end
		end


=begin
			if(mpg_checkbox == "1")
				if(query.empty?)
					if(mpg_two.empty?)
						if(country_origin.empty?)
							@coche_datos = CocheDato.searchByMpg(mpg)
						else 
							@coche_datos = CocheDato.searchByMpgCountry(mpg, country_origin)
						end
					else 
						if(country_origin.empty?)
							@coche_datos = CocheDato.searchByMpgRange(mpg, mpg_two)
						else 
							@coche_datos = CocheDato.searchByMpgRangeCountry(country_origin, mpg, mpg_two)
						end
					end
				else
					if(mpg_two.empty?)
						if(country_origin.empty?)
							@coche_datos = CocheDato.searchByCarNameMpg(query, mpg)
						else
							@coche_datos = CocheDato.searchByCarNameMpgCountry(query, mpg, country_origin)
						end
					else 
						if(country_origin.empty?)
							@coche_datos = CocheDato.searchByCarNameMpgRange(query, mpg, mpg_two)
						else
							@coche_datos = CocheDato.searchByCarNameMpgRangeCountry(query, mpg, mpg_two, country_origin)
						end
					end
				end
			else
				@coche_datos = CocheDato.searchByCarName(query)
			end
		else
			@coche_datos = nil
		end
=end
	end

	def ajax_search
    @rhs_coches = CocheDato.all
	end

	def retrieve_searches
		@search_results_posts = CocheDato.searchByCarName(params[:search])
		respond_to do |format|
				format.js { render layout: false }
		end
	end

	def index_autocomplete
		# @all_cars = CocheDato.all
	end

	def buscar_autocomplete
		# q = params[:q].downcase
		# @people = CocheDato.where("car LIKE ?", "%#{q}%").limit(5)
		q = params[:q]
		@people = CocheDato.suggestSearchCarName(q)
	end

	def index_latest_autocomplete
	# like ajax_search
	end

	def buscar_latest_autocomplete
	# like retrieve_searches
		q = params[:q]
		@people = CocheDato.suggestSearchCarName(q)
		# @people = CocheDato.searchByCarName(params[:search])
		respond_to do |format|
			# format.js { render layout: false }
			# format.json { render json: @people }
			format.json { render layout: false }
			# render :partial => "coche_datos/test.json.erb"
		end
	end

  # GET /coche_datos or /coche_datos.json
  def index
    @coche_datos = CocheDato.all
  end

  # GET /coche_datos/1 or /coche_datos/1.json
  def show
  end

  # GET /coche_datos/new
  def new
    @coche_dato = CocheDato.new
  end

  # GET /coche_datos/1/edit
  def edit
  end

  # POST /coche_datos or /coche_datos.json
  def create
    @coche_dato = CocheDato.new(coche_dato_params)

    respond_to do |format|
      if @coche_dato.save
        format.html { redirect_to coche_dato_url(@coche_dato), notice: "Coche dato was successfully created." }
        format.json { render :show, status: :created, location: @coche_dato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coche_dato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coche_datos/1 or /coche_datos/1.json
  def update
    respond_to do |format|
      if @coche_dato.update(coche_dato_params)
        format.html { redirect_to coche_dato_url(@coche_dato), notice: "Coche dato was successfully updated." }
        format.json { render :show, status: :ok, location: @coche_dato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coche_dato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coche_datos/1 or /coche_datos/1.json
  def destroy
    @coche_dato.destroy

    respond_to do |format|
      format.html { redirect_to coche_datos_url, notice: "Coche dato was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coche_dato
      @coche_dato = CocheDato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coche_dato_params
      params.fetch(:coche_dato, {})
    end

		def force_json
			request.format = :json
		end

end
