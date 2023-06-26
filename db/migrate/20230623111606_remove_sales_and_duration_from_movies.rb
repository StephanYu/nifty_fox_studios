class RemoveSalesAndDurationFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :total_gross, :string
    remove_column :movies, :duration, :string
  end
end
