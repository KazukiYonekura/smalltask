class AddCompleteToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :complete, :boolean, default: false, null: false
  end
end
