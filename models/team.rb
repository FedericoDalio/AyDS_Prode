# Esta clase crea la tabla Teams en la base de datos con claves foraneas para la tabla Match.
class Team < ActiveRecord::Base
  has_many :visitor_matches, foreign_key: 'visitor_id', class_name: 'Match'
  has_many :local_matches, foreign_key: 'local_id', class_name: 'Match'

  def matches
    visitor_matches + local_matches
  end
end
