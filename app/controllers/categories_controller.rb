class CategoriesController < ApplicationController
    skip_before_action :authorize_request, only: :index
  
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
        render json: @category, status: :created
      else
        render json: @category.errors, status: :unprocessable_entity
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
  