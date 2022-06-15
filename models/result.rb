class Result < ActiveRecord::Base
  belongs_to :match
   #after_save :actualizarPuntaje

  

  #def actualizarPuntaje
   # partido = Match.find_by(id: match.id)
   # Forecast.where{"match: partido"}.find_each do |p|
  #if (p.local == local) && (p.visitor == visitor)
   # p.score = 3
   # p.user.score_total = p.user.score_total + 3
  #if ((p.local < p.visitor) && (local < visitor)) || ((p.local > p.visitor) && (local > visitor))
   # p.score = 1
    #p.user.score_total = p.user.score_total + 1
#
 #       end
  #    end
   # end
 # end
end