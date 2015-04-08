class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true
  validates :long_url, presence: true

  def self.random_code
    code = SecureRandom::urlsafe_base64

    until !ShortenedUrl.exists?(short_url: "code")
      code = SecureRandom::urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(submitter_id: user.id, short_url: random_code, long_url: long_url)
  end

end
