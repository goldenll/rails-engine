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
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
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
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    expect(item[:data][:attributes][:merchant_id]).to eq(id)
  end

  it "can create a new item" do
    id = create(:merchant).id
    item_params = ({
                    name: "pizza", 
                    description: "cheesy yummy carbs", 
                    unit_price: 20, 
                    merchant_id: id
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can destroy an item" do
    id = create(:merchant).id
    item1 = create(:item, merchant_id: id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an existing item" do
    merchant_id = create(:merchant).id
    item1 = create(:item, merchant_id: merchant_id)

    previous_name = Item.last.name
    item_params = { name: "pizza" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item1.id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("pizza")
  end

  it "can get an items merchant" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}/merchant"

    new_item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(new_item).to have_key(:data)
    expect(new_item[:data]).to be_a(Hash)
# require 'pry'; binding.pry
    expect(new_item[:data][:attributes]).to have_key(:name)
    expect(new_item[:data][:attributes][:name]).to be_a(String)
    expect(new_item[:data][:attributes][:name]).to eq(merchant1.name)
  end
end
