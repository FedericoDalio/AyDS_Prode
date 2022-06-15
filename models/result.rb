class Result < ActiveRecord::Base
  belongs_to :match
  after_save :actualizarPuntaje

  

  def actualizarPuntaje
   partido = Match.find_by(id: match.id)
   Forecast.where(match: partido).find_each do |p|
      if ((p.local == local) && (p.visitor == visitor))
          p.score = 3
          p.save
          p.user.total_score = p.user.total_score + 3
          p.user.save
      if (((p.local < p.visitor) && (local < visitor)) || ((p.local > p.visitor) && (local > visitor)))
          p.score = 1
          p.save
          p.user.total_score = p.user.total_score + 1
          p.user.save
        end
      end
    end
  end
end