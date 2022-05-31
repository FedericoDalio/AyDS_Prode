require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  def password
    @password ||= Password.new(password_digest)
  end
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
  def name
    @name ||= Name.new(name_digest)
  end
  def name=(new_name)
    @name = Name.create(new_name)
    self.name_digest = @name
  end
end