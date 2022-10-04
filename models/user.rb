require 'bcrypt'
# Esta clase crea la tabla User en la base de datos, incluyendo una contrasenia y la creacion de la misma.
class User < ActiveRecord::Base
  include BCrypt
  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
