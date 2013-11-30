class Search < ActiveRecord::Base
  attr_accessible :origin, :depart_date_text, :return_date_text, :destination, 
    :region_id, :vacation_id, :budget, :flight, :hotel, :car, :traveller
  has_one :master_pricer_search
  before_create :find_enums
  #before_save :traveller_to_int

  validates_date :depart_date, on_or_after: 1.day.ago, on_or_after_message: "must be on or after #{Date.today}"
  validates_date :return_date, on_or_after: :depart_date, on_or_after_message: "must be after the departure date"

  def depart_date_text
    #depart_date.try(:strftime, "%Y-%m-%d")
    depart_date.to_s(:db)
  end

  def return_date_text
    #return_date.try(:strftime, "%Y-%m-%d")
    return_date.to_s(:db)
  end

  def depart_date_text=(date)
    self.depart_date = Time.parse(date) if date.present?
  end

  def return_date_text=(date)
    self.return_date = Time.parse(date) if date.present?
  end

  def cities
  	@cities ||= find_cities
  end


  def find_enums
    code = self.origin.split(' ').first
    self.origin = code
  end

  private
  def find_cities
    #declare arrays and initialize Cities
    cities = City.order(:city_name)
    reg_ids = {}
    vac_ids = {}
    dest_ids = {}
    city_rating = {}

    #add IDs to hash in order to get City objects later
    if region_id.present?
      @cityregions = CityRegion.select("ref_city_id, rating").where("ref_region_id = ?", region_id)
      @cityregions.each do |cr|
          reg_ids[cr.ref_city_id.to_i] = cr.rating.to_i
      end
    end

    if vacation_id.present?
      @cityvacations = CityVacation.select("City_Code, rating").where("Vacation_Type = ?", vacation_id) if vacation_id.present?
      @cityvacations.each do |cv|
          vac_ids[cv.City_Code.to_i] = cv.rating.to_i
      end
    end

    if destination.present?
      cityids = City.select(:id).where("city_name like ?", "%#{destination}")
      cityids.each do |ci|
          dest_ids[ci.id.to_i] = 10.to_i
      end
    end 

    #add region keys and ratings to hash
    reg_ids.each do |k1, v1|
        if vac_ids[k1].nil?
            vac_ids[k1] = v1
        else
            v2 = vac_ids[k1]
            vac_ids[k1] = v1 + v2
        end
    end

    #add destination keys and ratings to hash
    dest_ids.each do |k1, v1|
        if vac_ids[k1].nil?
            vac_ids[k1] = v1
        else
            v2 = vac_ids[k1]
            vac_ids[k1] = v1 + v2
        end
    end
    
    #collect array of Cities, set ratings
    cities = cities.find(vac_ids.keys)

    cities.each do |c|
      c.set_rating(vac_ids[c.id])
      #c.get_best_airport
    end
    
    #order by ratings DESC
    cities.sort! { |a,b| b.rating <=> a.rating }

    
    cities = Kaminari.paginate_array(cities).page(1).per(4)

    cities


  end


end