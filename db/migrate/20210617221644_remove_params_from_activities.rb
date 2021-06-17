class RemoveParamsFromActivities < ActiveRecord::Migration[6.1]
  def change
    remove_column :activities, :name
    remove_column :activities, :place
    remove_column :activities, :intensity
  end
end
