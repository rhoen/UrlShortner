class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id
      t.integer :visitor_user_id
    end
  end
end
