class CocheDatosController < ApplicationController
  before_action :set_coche_dato, only: %i[ show edit update destroy ]

	def search
		if (params[:search_coche_datos].nil? == false)
			query = params[:search_coche_datos].presence && params[:search_coche_datos][:query]
			mpg = params[:search_coche_datos].presence && params[:search_coche_datos][:MPG]
			mpg_checkbox = params[:search_coche_datos].presence && params[:search_coche_datos][:MPG_checkbox]
			
			if(mpg_checkbox == "1")
				if(query.empty?)
					@coche_datos = CocheDato.searchByMpg(mpg)
				else
					@coche_datos = CocheDato.searchByCarNameMpg(query, mpg)
				end
			else
				@coche_datos = CocheDato.searchByCarName(query)
			end
		else
			@coche_datos = nil
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
end