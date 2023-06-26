class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :release_year, :rating, :director, :genre, :image_url, :rank
  has_many :reviews
end
