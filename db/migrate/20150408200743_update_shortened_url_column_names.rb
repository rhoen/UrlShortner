class UpdateShortenedUrlColumnNames < ActiveRecord::Migration
  def change
    rename_column :shortened_urls, :submitter_id, :submitter_user_id
  end
end
