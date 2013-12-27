class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :user_profile_attributes
  has_one :user_profile
  accepts_nested_attributes_for :user_profile
  
  before_create :build_user_profile





  # Setup accessible (or protected) attributes for your model
 validates_presence_of :username
end
