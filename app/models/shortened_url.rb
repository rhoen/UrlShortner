class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_user_id, presence: true
  validates :long_url, presence: true

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_user_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    code = SecureRandom::urlsafe_base64

    until !ShortenedUrl.exists?(short_url: "code")
      code = SecureRandom::urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(submitter_user_id: user.id, short_url: random_code, long_url: long_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
    #visits.select(:visitor_user_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:visitor_user_id).distinct.where("created_at > '#{Time.now("-05:00") - 10.minutes}'").count
  end

end
