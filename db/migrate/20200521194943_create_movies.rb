class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.integer :id_movie
      t.string :title
      t.text :overview
      t.integer :vote_count
      t.string :poster_path
      t.date :release_date

      t.timestamps
    end
  end
end
