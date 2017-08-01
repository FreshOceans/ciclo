class CountyTrail < ApplicationRecord
  belongs_to :county
  belongs_to :trail
end
