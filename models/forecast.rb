class Forecast < ActiveRecord::Base
  belongs_to :match
  belongs_to :user
end
