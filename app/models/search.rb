class Search < ActiveRecord::Base
  attr_accessible :origin, :depart_date, :return_date, :destination, :region_id, :vacation_id, :budget, :flight, :hotel, :car
  before_create :find_enums
  #validates_inclusion_of :origin, in: ['DCA'], message: "Please enter a valid origination airport"

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
    end
    
    #order by ratings DESC
    cities.sort! { |a,b| b.rating <=> a.rating }

    
    cities = Kaminari.paginate_array(cities).page(1).per(4)

    cities


  end


end