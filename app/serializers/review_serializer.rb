class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :stars, :comment
  belongs_to :movie
end
