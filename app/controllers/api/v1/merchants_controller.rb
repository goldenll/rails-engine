class Api::V1::MerchantsController < ApplicationController
  def index 
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show 
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  # private
  # def choose_merchant
  #   params.permit(:id)
  # end
end