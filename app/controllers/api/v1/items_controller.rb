class Api::V1::ItemsController < ApplicationController
  def index 
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render(status: 201, json: ItemSerializer.new(Item.create(item_params)))
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  def update
    item = Item.update(params[:id], item_params)
    if item.save 
      render(json: ItemSerializer.new(Item.update(params[:id], item_params)))
    else 
      render(status: 404, json: { error: 'Item not found' })
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
