class User < ActiveRecord::Base
  has_many :books
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  after_initialize :generate_random_password
  after_create :assign_token
  
  private
  
  def assign_token
    self.reset_authentication_token!
  end
  
  def generate_random_password
    self.password = random if password.nil?
  end
  
  def random
    Digest::MD5.hexdigest(Time.now.to_s + rand(100000).to_s)
  end
  
end
