require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
  end
  
  # def find_items(search_params)

  # end
end
