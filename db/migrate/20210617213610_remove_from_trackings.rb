class RemoveFromTrackings < ActiveRecord::Migration[6.1]
  def change
    rename_column :trackings, :rate, :name
    rename_column :trackings, :calories, :repeats
    remove_column :trackings, :date
    remove_column :trackings, :pulse
  end
end
