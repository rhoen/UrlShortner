class Visit < ActiveRecord::Base
  validate :visitor_user_id, presence: true
  validate :shortened_url_id, presence: true

  belongs_to :visitor,
    class_name: "User",
    foreign_key: :visitor_user_id,
    primary_key: :id

  belongs_to :url,
    class_name: "ShortenedUrl",
    foreign_key: :shortened_url_id,
    primary_key: :id

  def self.record_visit!(options)
    create!(shortened_url_id: options[:shortened_url].id, visitor_user_id: options[:user].id)
  end

end
