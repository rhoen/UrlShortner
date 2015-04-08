class AddTimestampsToVisits < ActiveRecord::Migration
  def change
    change_table :visits do |t|
      t.timestamps

    end

    add_index :visits, :visitor_user_id
    add_index :visits, :shortened_url_id

  end
end
