class Trail < ApplicationRecord
    has_many :county_trails
    has_many :counties, through: :county_trails, dependent: :destroy
    has_many :photos
    has_many :trail_reports
    has_many :reports, through: :trail_reports, dependent: :destroy
    has_many :trail_tags
    has_many :tags, through: :trail_tags, dependent: :destroy
end
