class AddTwitterToken < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :type
      
    end
  end
end
