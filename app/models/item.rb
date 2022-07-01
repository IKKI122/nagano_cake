class Item < ApplicationRecord
    has_one_attached :item_image
    
    has_many :cart_items, dependent: :destroy
    has_many :order_details, dependent: :destroy
    belongs_to :genre
    
    validates :genre_id, :name, :image_id, :introduction, :price, presence: true
    validates :is_active, inclusion: {in: [true, false]}
    
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end
