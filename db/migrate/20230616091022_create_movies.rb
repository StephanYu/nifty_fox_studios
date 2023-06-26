class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title      
      t.text :description
      t.date :released_on
      t.string :rating
      t.decimal :total_gross

      t.timestamps
    end
  end
end
