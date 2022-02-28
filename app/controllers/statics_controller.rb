class StaticsController < ApplicationController
  before_action :set_static, only: %i[ show edit update destroy ]

	def home
	end

	def test
	end

	def get_data
		@test_data = "hello world!"
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def hide_data
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def renovated_search
		@rhs_coches = CocheDato.all.order(:car)
	end

	def retrieve_searches
		# @search_results_posts = CocheDato.suggestSearchCarName(params["carName"])
		@search_results_posts = CocheDato.suggestCarNameOrigin(params["carName"], params["originName"])
		puts "==========================="
		puts MultiJson.dump(CocheDato.mapping.to_hash, pretty: true)
		puts "==========================="
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def post_car_name
		@search_results_posts = CocheDato.suggestSearchCarName(params["carName"])
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def yesCar_noOrigin_noYear_noMpg_noHorsepower
		@search_results_posts = CocheDato.suggestSearchCarName(params["carName"])
		respond_to do |format|
			format.js { render layout: false }
		end
	end

  # GET /statics or /statics.json
  def index
    # @statics = Static.all
  end

  # GET /statics/1 or /statics/1.json
  def show
  end

  # GET /statics/new
  def new
    @static = Static.new
  end

  # GET /statics/1/edit
  def edit
  end

  # POST /statics or /statics.json
  def create
    @static = Static.new(static_params)

    respond_to do |format|
      if @static.save
        format.html { redirect_to static_url(@static), notice: "Static was successfully created." }
        format.json { render :show, status: :created, location: @static }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @static.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statics/1 or /statics/1.json
  def update
    respond_to do |format|
      if @static.update(static_params)
        format.html { redirect_to static_url(@static), notice: "Static was successfully updated." }
        format.json { render :show, status: :ok, location: @static }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @static.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statics/1 or /statics/1.json
  def destroy
    @static.destroy

    respond_to do |format|
      format.html { redirect_to statics_url, notice: "Static was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static
      @static = Static.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def static_params
      params.fetch(:static, {})
    end
end
