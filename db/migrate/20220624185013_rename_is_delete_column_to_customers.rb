class RenameIsDeleteColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :is_delete, :is_deleted
  end
end
