class CategoriesController < ApplicationController
    # skip_before_action :authorize_request, only: :new


    def new
      @category = Category.new
    end
  
    def index
      categories = Category.all
      render json: categories
    end

    def show
      @category = Category.find(params[:id])
      render json: @category
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Category not found' }, status: :not_found
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        respond_to do |format|
          format.html { redirect_to admin_pages_path, notice: 'Category was successfully created.' }
          format.json { render json: @category, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        render json: @category, status: :ok
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @category = Category.find(params[:id])
      @category.destroy
      head :no_content
    end
  
    private
  
    def category_params
      params.require(:category).permit(:name)
    end
  end
  