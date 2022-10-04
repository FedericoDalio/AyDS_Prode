# Esta clase genera en la base de datos La tabla Result, que guarda los resultados de los partidos.
# El metodo actualizar_puntaje guarda el resultado de un partido en la base de datos, con los campos match y puntaje
class Result < ActiveRecord::Base
  belongs_to :match
  after_save :actualizar_puntaje

  def actualizar_puntaje
    partido = Match.find_by(id: match.id)
    Forecast.where(match: partido).find_each do |p|
      if (p.local == local) && (p.visitor == visitor)
        p.score = 3
        p.save
        p.user.total_score = p.user.total_score + 3
        p.user.save
      elsif ((p.local < p.visitor) && (local < visitor)) || ((p.local > p.visitor) && (local > visitor))
        p.score = 1
        p.save
        p.user.total_score = p.user.total_score + 1
        p.user.save
      else
        p.score = 0
      end
    end
  end
end
