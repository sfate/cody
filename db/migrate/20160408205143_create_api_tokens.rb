class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :token_id
      t.string :token_digest

      t.timestamps null: false
    end

    add_index :api_tokens, :token_id, unique: true, using: :btree
  end
end
