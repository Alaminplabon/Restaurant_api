class ItemsController < ApplicationController
    before_action :authorize_request, except: [:new, :show]
    before_action :set_subcategory, only: [:create, :new]

    def index
      if @subcategory.nil?
        render json: { error: 'Subcategory not found' }, status: :not_found
      else
        items = @subcategory.items
        render json: items
      end
    end
    
    def create
      @item = @subcategory.items.new(item_params)
      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @item.update(item_params)
        render json: @item, status: :ok
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @item.destroy
      head :no_content
    end


    private
  
    def set_subcategory
      @subcategory = Subcategory.find(params[:subcategory_id])
    end
  
    def item_params
      params.require(:item).permit(:name, :price)
    end
  end
  