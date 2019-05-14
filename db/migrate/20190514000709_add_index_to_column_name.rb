class AddIndexToColumnName < ActiveRecord::Migration[5.2]
  def change   
    add_index :songs, :new_work_title, unique: true
  end
end
