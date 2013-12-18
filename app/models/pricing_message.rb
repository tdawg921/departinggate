class PricingMessage < ActiveRecord::Base
  attr_accessible :id, :recommendation_id_id, :text_subject_qualifier, :information_type, :description

  def self.id
  	@id
  end
    
end
