class RemoveImageIdInItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :image_id, :string
  end
end
