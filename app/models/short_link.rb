class ShortLink < ApplicationRecord
  validates :long_link, presence: true
  validates :encoded_id, uniqueness: true
  validate :valid_long_link

  before_create :generate_unique_encoded_id

  private
    def generate_unique_encoded_id
      while encoded_id.blank? || ShortLink.exists?(encoded_id: encoded_id)
        self.encoded_id = SecureRandom.uuid
      end
    end

    def valid_long_link
      uri = URI.parse(long_link)
      unless uri.is_a?(URI::HTTP) && uri.host.present?
        errors.add(:long_link, "is invalid")
      end
    end
end
