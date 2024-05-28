class Addimagecolumn < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :image_data, :binary
  end
end