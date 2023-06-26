class UpdateReleasedOnToMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :released_on, :date
    add_column :movies, :release_year, :integer
  end
end
