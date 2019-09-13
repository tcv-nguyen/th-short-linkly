class ShortLink < ApplicationRecord
  validates :long_link, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
  validates :encoded_id, uniqueness: true
  validate :valid_long_link

  after_create :generate_unique_encoded_id

  def self.decoded_id(id)
    id.to_i(36)
  end

  private
    def generate_unique_encoded_id
      while encoded_id.blank? || ShortLink.exists?(encoded_id: encoded_id)
        self.encoded_id = id.to_s(36)
      end
      self.save
    end

    def valid_long_link
      unless long_link.present? && (uri = URI.parse(long_link)) && uri.is_a?(URI::HTTP) && uri.host.present?
        errors.add(:long_link, "is invalid")
      end
    end
end
