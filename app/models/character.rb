class Character < ApplicationRecord
    has_and_belongs_to_many :comics
    validates :uuid, uniqueness: true
end
