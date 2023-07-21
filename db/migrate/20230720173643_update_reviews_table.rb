class UpdateReviewsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :user_id, :integer
    remove_column :reviews, :name, :string
    Review.delete_all
  end
end