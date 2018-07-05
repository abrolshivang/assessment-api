class RenameUriColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :uri, :url
  end
end
