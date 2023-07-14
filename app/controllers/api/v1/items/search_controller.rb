class Api::V1::Items::SearchController < ApplicationController
  def search
    if Item.find_name(params[:name]) == []
      render json: ItemSerializer.new(Item.new)
    else 
      render json: ItemSerializer.new(Item.find_name(params[:name]))
    end
  end
end