class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :password_digest
    end
  end
end
