class Result < ActiveRecord::Base
  belongs_to :match
  after_save :actualizarPuntaje

  private

  def actualizarPuntaje
    Forecast.where{match: result.match}.find_each do |p|
  if (p.local == result.local) && (p.visitor == result.visitor)
    p.score = 3
    p.user.score_total = p.user.score_total + 3
  if ((p.local < p.visitor) && (result.local < result.visitor)) || ((p.local > p.visitor) && (result.local > result.visitor))
    p.score = 1
    p.user.score_total = p.user.score_total + 1

  end
  end
end