class DownloadCount < ApplicationRecord
  validates :song_id,     presence:true
  validates :month,       presence:true
  validates :month_total, presence:true
end
