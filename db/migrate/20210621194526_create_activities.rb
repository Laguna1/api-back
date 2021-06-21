class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.date :item

      t.timestamps
    end
  end
end
