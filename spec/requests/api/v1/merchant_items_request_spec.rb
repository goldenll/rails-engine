require 'rails_helper'

describe "Merchant Items API" do
  it "can get a merchants items" do
    @id = create(:merchant).id

    create_list(:item, 10, merchant_id: @id)
    # 
    get "/api/v1/merchants/#{@id}/items"
# require 'pry'; binding.pry
    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
    end
  end
end