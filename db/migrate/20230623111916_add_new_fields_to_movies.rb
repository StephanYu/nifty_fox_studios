class AddNewFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :genre, :string
    add_column :movies, :imdb_id, :string
    add_column :movies, :image_url, :string
    add_column :movies, :image_thumbnail_url, :string
    add_column :movies, :trailer_url, :string
    add_column :movies, :rank, :integer
  end
end
