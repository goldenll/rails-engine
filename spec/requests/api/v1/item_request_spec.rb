require 'rails_helper'

describe "Items API" do
  it "sends a list of all items" do
    id = create(:merchant).id
    create_list(:item, 5, merchant_id: id)

    get "/api/v1/items"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(5)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to eq(id)
    end
  end

  it "can get one item by its id" do
    id = create(:merchant).id
    item1 = create(:item, merchant_id: id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(item).to have_key(:data)
    expect(item[:data]).to be_a(Hash)
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq("#{item1.id}")

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to eq(id)
  end
end
