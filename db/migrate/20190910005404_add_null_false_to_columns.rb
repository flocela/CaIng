class AddNullFalseToColumns < ActiveRecord::Migration[5.2]
  def change
    change_column_null :songs, :orig_english_changes_made, false
    change_column_null :songs, :orig_spanish_changes_made, false
    change_column_null :songs, :zip_size, false
  end
end
