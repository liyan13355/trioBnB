class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.timestamps null: false
      t.string :role
      
    end
  end
end
