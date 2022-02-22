class StaticsController < ApplicationController
  before_action :set_static, only: %i[ show edit update destroy ]
	# skip_before_action :verify_authenticity_token
	# https://stackoverflow.com/questions/3364492/actioncontrollerinvalidauthenticitytoken
	## VULNERABILITY ?? 
	# skip_before_action :skip_forgery_protection

	def home
	end

	def search
	end

	def execute_search
		@searchResults = params["SearchResults"].as_json
		@hashSearchResults = @searchResults.to_h
		@hello = "hello world"
		# byebug
		respond_to do |format|
			format.js { render layout: false }
		end
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
		@rhs_coches = CocheDato.all
	end

	def retrieve_searches
		# @search_results_posts = "" #:CocheDato.searchByCarName(params[:search])
		@search_results_posts = CocheDato.suggestSearchCarName(params["SearchPhrase"])
		@hello = "hello"
		# byebug
		respond_to do |format|
			# format.html { render layout: false}
			# format.html { render partial: 'statics/retrieve_searches',
					# locals: { hello: @hello, search_results_posts: @search_results_posts }}
			# format.js { render partial: 'retrieve_searches.js.erb' }
			format.js { render layout: false }
			# format.js # { render layout: false }
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
