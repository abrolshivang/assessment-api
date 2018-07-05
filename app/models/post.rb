class Post < ApplicationRecord
  validates :title, :url, presence: true
  validates_uniqueness_of :url

  validate :validate_url

  belongs_to :user

  private 

  def validate_url
    uri = URI.parse(url)
    errors.add(:url, I18n.t('post.invalid_url')) unless uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    errors.add(:url, I18n.t('post.invalid_url'))
  end
end
