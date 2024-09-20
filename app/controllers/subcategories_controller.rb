class SubcategoriesController < ApplicationController
  # before_action :authorize_request, except: [:new, :show]
  before_action :set_category, only: [:create]
  before_action :set_subcategory, only: [:show, :update, :destroy]


  def new
    @subcategory = Subcategory.new
    @categories = Category.all
  end
  def index
    if params[:category_id]
      subcategories = @category.subcategories
    else
      subcategories = Subcategory.all
    end
    render json: subcategories
  end

  def show
    render json: @subcategory
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Subcategory not found' }, status: :not_found
  end

  def create
    @subcategory = @category.subcategories.new(subcategory_params)
    if @subcategory.save
      render json: @subcategory, status: :created
    else
      render json: @subcategory.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subcategory.update(subcategory_params)
      render json: @subcategory, status: :ok
    else
      render json: @subcategory.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @subcategory.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  def subcategory_params
    params.require(:subcategory).permit(:name)
  end
end
