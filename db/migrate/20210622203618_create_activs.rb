class CreateActivs < ActiveRecord::Migration[6.1]
  def change
    create_table :activs do |t|
      t.references :user, foreign_key: true
      t.date :item, null: false

      t.timestamps
    end
  end
end
