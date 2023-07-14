class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_items(search_params)
    if search_params == Integer
      where('min_price ILIKE ?', "%#{search_params}%").order(name: :asc)
    else
      where('name ILIKE ?', "%#{search_params}%").order(name: :asc)
    end
  end
end
