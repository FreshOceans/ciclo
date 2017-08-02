class County < ApplicationRecord
    has_many :county_trails
    has_many :trails, through: :county_trails, dependent: :destroy
end
