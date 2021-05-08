class CreateTrackings < ActiveRecord::Migration[6.1]
  def change
    create_table :trackings do |t|
      t.references :activity, null: false, foreign_key: true
      t.datetime :date
      t.integer :pulse
      t.integer :duration
      t.integer :distance
      t.integer :calories
      t.string :rate

      t.timestamps
    end
  end
end
