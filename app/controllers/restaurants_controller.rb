class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to :root, notice: 'Restaurant added.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  def upvote
    @restaurant = Restaurant.find(params[:id])
    session[:upvotes] = 0 if session[:upvotes].blank?
    unless session[:upvotes] > 1
      @restaurant.increment!(:score)
      session[:upvotes] = session[:upvotes] + 1
      redirect_to :root
    else
      redirect_to :root, :alert => 'Easy George..'
    end
  end

  def downvote
    @restaurant = Restaurant.find(params[:id])
    session[:downvotes] = 0 if session[:downvotes].blank?
    unless session[:downvotes] > 1
      @restaurant.decrement!(:score)
      session[:downvotes] = session[:downvotes] + 1
      redirect_to :root
    else
      redirect_to :root, :alert => 'Enough of that..'
    end
  end

  def resetsession
    session[:downvotes] = nil
    session[:upvotes] = nil
    redirect_to :root
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :url, :score)
    end
end
