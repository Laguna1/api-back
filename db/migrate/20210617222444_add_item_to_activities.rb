class AddItemToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :item, :datetime
  end
end
