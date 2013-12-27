class UserProfile < ActiveRecord::Base
	set_table_name "user_profile"

	belongs_to :user

	###alias_attribute :user_id, :User_ID  ###This seems to break it


  def birthday_text
    birthday.try(:strftime, "%m/%d/%Y")
  end

  def birthday_text=(date)
    self.birthday = Time.parse(date) if date.present?
  end

#Strip all non-digits in phone before saving
def mobile_phone=(temp_mobile_phone)
  self[:mobile_phone] = temp_mobile_phone.gsub(/[^0-9]/,'')
end

def work_phone=(temp_work_phone)
  self[:work_phone] = temp_work_phone.gsub(/[^0-9]/,'')
end

def home_phone=(temp_home_phone)
  self[:home_phone] = temp_home_phone.gsub(/[^0-9]/,'')
end

	attr_accessible :user_id, :first_name, :middle_name, :last_name, :name_suffix, 
	:gender, :home_phone, :work_phone, :mobile_phone,
	:language_preference, :home_airport, :seat_preference, :meal_preference, 
	:special_request_preference, :birthday_text
end