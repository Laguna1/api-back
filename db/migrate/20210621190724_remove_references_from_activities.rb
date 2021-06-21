class RemoveReferencesFromActivities < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :activities, :users
  end
end
