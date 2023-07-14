class Api::V1::Items::SearchController < ApplicationController
  def search
    if params[:min_price] != nil
      render json: [ItemSerializer.new(Item.find_items(params[:min_price]))]
    else
      render json: [ItemSerializer.new(Item.find_items(params[:name]))]
    end
    # render(status: 404, json: { error: "Items not found" })
  end
end
