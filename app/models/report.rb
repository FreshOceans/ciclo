class Report < ApplicationRecord
  belongs_to :user
  has_many :trail_reports
  has_many :trails, through: :trail_reports, dependent: :destroy
end
