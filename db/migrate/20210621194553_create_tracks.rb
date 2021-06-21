class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :distance
      t.integer :duration
      t.integer :repeat
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
