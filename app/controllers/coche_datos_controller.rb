class CocheDatosController < ApplicationController
  before_action :set_coche_dato, only: %i[ show edit update destroy ]

	def search
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

end
