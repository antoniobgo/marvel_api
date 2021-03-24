class Comic < ApplicationRecord
  has_and_belongs_to_many :characters
  validates :uuid, uniqueness: true
end
