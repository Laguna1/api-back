class CreateAccessTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :access_tokens do |t|
      t.references :user, foreign_key: true
      t.string :token, null: false

      t.timestamps
    end
  end
end
