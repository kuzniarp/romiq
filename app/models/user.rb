require "digest/sha1"
class User
  attr_accessor :login, :password 
  USERS = {"admin" => {:login => "admin", :password => "d033e22ae348aeb5660fc2140aec35850c4da997"}}
  
  def self.authenticate login, password
    User::USERS.values.map{|u| {:login => u[:login], :password => u[:password]}}.include?({:login => login, :password => Digest::SHA1.hexdigest(password)})
  end
end
