class AddPositionToBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :position, :integer
  end
end
