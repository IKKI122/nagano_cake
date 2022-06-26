class Item < ApplicationRecord
    has_one_attached :image
    
    has_many :cart_items, dependent: :destroy
    has_many :order_details, dependent: :destroy
    belongs_to :genre
    
    validates :genre_id, :name, :introduction, :price, presence: true
    validates :is_active, inclusion: {in: [true, false]}
end
