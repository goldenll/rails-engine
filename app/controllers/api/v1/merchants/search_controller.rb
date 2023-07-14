class Api::V1::Merchants::SearchController < ApplicationController
  def search
    if params[:name] == nil || params[:name] == ''
      render(status: 404, json: { error: "Merchant not found" } )
    elsif Merchant.find_name(params[:name]) == []
      render json: MerchantSerializer.new(Merchant.new)
    else 
      render json: MerchantSerializer.new(Merchant.find_name(params[:name]).first)
    end
  end
end