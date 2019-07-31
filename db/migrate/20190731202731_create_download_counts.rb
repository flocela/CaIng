class CreateDownloadCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :download_counts do |t|
      t.integer :song_id
      t.date :month
      t.integer :month_total, :default => 0

      t.timestamps
    end
  end
end
