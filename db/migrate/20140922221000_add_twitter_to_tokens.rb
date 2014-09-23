class AddTwitterToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :token, :string
    add_column :tokens, :secret, :string
  end
end
