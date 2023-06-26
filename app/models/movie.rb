class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_one_attached :main_image

  validates :title, presence: true, uniqueness: true
  validates :release_year, :rating, :director, :rank, :genre, :imdb_id, :image_url, presence: true
  validates :description, length: { minimum: 25 }
  validate :acceptable_image_format

  scope :released, -> { where("release_year < ?", Time.now.year).order(release_year: :desc) }
  scope :upcoming, -> { where("release_year > ?", Time.now.year).order(release_year: :asc) }
  scope :recent, ->(max=5) { released.limit(max) }

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def to_param
    slug
  end

  private
    def set_slug
      self.slug = title.parameterize
    end

    def acceptable_image_format
      return if !main_image.attached?

      if main_image.blob.byte_size > 1.megabyte
        errors.add(:main_image, "file size is too large")
      end

      unless %("image/jpeg" "image/png").include?(main_image.blob.content_type)
        errors.add(:main_image, "file type must be a JPEG or PNG")
      end
    end
end
