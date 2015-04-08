class Visit < ActiveRecord::Base
  validate :submitter_user_id, presence: true
  validate :shortened_url_id, presence: true

end
