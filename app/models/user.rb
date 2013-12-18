class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :user_data_attributes
  has_one :user_data
  accepts_nested_attributes_for :user_data

  def user_data
  	@user_data
  end
###end

  #####def user_data
  	#####@user_data
  ###end

  ###def address_attributes=(attributes)
  	###:first_name, :last_name
  ###end

  # Setup accessible (or protected) attributes for your model
 validates_presence_of :username
end
