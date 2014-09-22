class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_salt
      t.string :password_hash
      t.string :blob
      t.string :location
      t.string :looking_for
      t.boolean :employer, default: false
    end
  end
end
