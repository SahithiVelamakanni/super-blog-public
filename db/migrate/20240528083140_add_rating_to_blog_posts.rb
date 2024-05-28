class AddRatingToBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :rating, :integer
  end
end
