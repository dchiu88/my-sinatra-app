class CreateResponseEntries < ActiveRecord::Migration
  def change
    create_table :response_entries do |t|

      t.timestamps null: false
    end
  end
end
