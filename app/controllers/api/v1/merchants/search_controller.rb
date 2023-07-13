class Api::V1::Merchants::SearchController < ApplicationController
  def search 
    render json: MerchantSerializer.new(Merchant.find_name(params[:name]).first)
  end
end