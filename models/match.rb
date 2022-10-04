class Match < ActiveRecord::Base
  belongs_to :local, class_name: 'Team'
  belongs_to :visitor, class_name: 'Team'
end
