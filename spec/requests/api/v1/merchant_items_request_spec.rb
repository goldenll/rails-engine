require 'rails_helper'

describe "Merchant Items API" do
  it "can get a merchants items" do
    @id = create(:merchant).id

    create_list(:item, 10, merchant_id: @id)
    
    get "/api/v1/merchants/#{@id}/items"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(10)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end
end
# return a 404 if merchant is not found