class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.references :activ, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :distance, null: false
      t.integer :duration, null: false
      t.integer :repeat, null: false

      t.timestamps
    end
  end
end
