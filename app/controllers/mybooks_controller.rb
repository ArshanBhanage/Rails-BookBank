class MybooksController < ApplicationController
  before_action :set_mybook, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /mybooks or /mybooks.json
  
  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to mybooks_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to mybooks_path
  end
   


  def index
    search = params[:query].presence || "*"
    #search = params[:query].present? ? params[:query] : nil
    #@mybooks = Mybook.search(params[:query]) 
    #@mybooks = if search
      #Book.where("title LIKE ? OR plot LIKE ?", "%#{search}%", "%#{search}%")
     # Mybook.search(search, where: {price: { gt: 0}})
      # else
      #Mybook.all
    #end
   
      args ={}
      args[:email] = params[:email] if params[:email].present?
      args[:semester] = params[:semester] if params[:semester].present?
      args[:year] = params[:year] if params[:year].present?     
    #price_ranges = [{to: 200}, {from: 200, to: 400}, {from: 400, to: 600}, {from: 600}]    
      @mybooks = Mybook.search search, misspellings: {edit_distance: 4}, suggest: true , where: args, aggs: {title: {}, email: {}, year: {}, semester: {}, price: {}}  
  end

  def autocomplete
     render json: Mybook.search(params[:query], fields: [{title: :word_middle}], limit: 10, misspellings: {below: 5}).map(&:title)
  end

  def browse
     @mybooks = Mybook.all
  end
  


  # GET /mybooks/1 or /mybooks/1.json
  def show
  end

  # GET /mybooks/new
  def new
    #@mybook = Mybook.new
    @mybook = current_user.mybooks.build 
  end

  # GET /mybooks/1/edit
  def edit

  end

  # POST /mybooks or /mybooks.json
  def create
    #@mybook = Mybook.new(mybook_params)
   @mybook = current_user.mybooks.build(mybook_params) 
    respond_to do |format|
      if @mybook.save
        format.html { redirect_to @mybook, notice: "Book added successfully." }
        format.json { render :show, status: :created, location: @mybook }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mybook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mybooks/1 or /mybooks/1.json
  def update
    respond_to do |format|
      if @mybook.update(mybook_params)
        format.html { redirect_to @mybook, notice: "Book updated successfully." }
        format.json { render :show, status: :ok, location: @mybook }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mybook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mybooks/1 or /mybooks/1.json
  def destroy
    @mybook.destroy
    respond_to do |format|
      format.html { redirect_to mybooks_url, notice: "Book deleted successfully." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @mybook = current_user.mybooks.find_by(id: params[:id])
    redirect_to mybooks_path, notice:"Not authorized" if @mybook.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mybook
      @mybook = Mybook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mybook_params
      params.require(:mybook).permit(:title, :year, :price, :semester, :user_id, :image, :name, :email, :instagram, :subject, :description)
    end
end
