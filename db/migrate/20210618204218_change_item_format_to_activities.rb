class ChangeItemFormatToActivities < ActiveRecord::Migration[6.1]
  def change
    remove_column :activities, :item, :datetime
    add_column :activities, :item, :date
  end
end
