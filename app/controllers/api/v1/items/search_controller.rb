class Api::V1::Items::SearchController < ApplicationController
  def search
    # require 'pry'; binding.pry
    # if Item.find_items(name: params[:name] || min_price: params[:min_price]) == []
      render json: [ItemSerializer.new(Item.find_items(params[:name]))]
    # else
    #   render(status: 404, json: { error: "Items not found" })
    # end
  end
end