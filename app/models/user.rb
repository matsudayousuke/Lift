require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password

  validates :first_name, :presence => true, :length => {:maximum => 20}

  validates :last_name, :presence => true, :length => {:maximum => 20}

  validates :user_name, :presence => true, :length => {:maximum => 20}

  validates :password, :presence => true, :length => 4..20, :confirmation => true

  before_save :encrypt_password

  def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(user_name, submitted_password)
    user = find_by_user_name(user_name)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
