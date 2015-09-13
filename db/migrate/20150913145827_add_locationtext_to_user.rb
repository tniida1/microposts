class AddLocationtextToUser < ActiveRecord::Migration
  def change
    add_column :users, :locationtext, :string
  end
end
