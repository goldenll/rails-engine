module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        def index
          render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
        end
      end
    end
  end
end



# class Api::V1::Items::MerchantController < ApplicationController
#   def index 
#     require 'pry'; binding.pry
#     render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
#   end
# end