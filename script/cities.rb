    destination = 'p'
    region_id = 2
    vacation_id = 5

        cities = City.order(:city_name)

        reg_ids = {}
        vac_ids = {}
        dest_ids = {}
        city_rating = {}
        @cityregions = CityRegion.select("ref_city_id, rating").where("ref_region_id = ?", region_id)
        @cityregions.each do |cr|
            reg_ids[cr.ref_city_id.to_i] = cr.rating.to_i
        end

        @cityvacations = CityVacation.select("City_Code, rating").where("Vacation_Type = ?", vacation_id) if vacation_id.present?
        @cityvacations.each do |cv|
            vac_ids[cv.City_Code.to_i] = cv.rating.to_i
        end

        cityids = City.select(:id).where("city_name like ?", "%#{destination}")
        cityids.each do |ci|
            dest_ids[ci.id.to_i] = 10.to_i
        end

        reg_ids.each do |k1, v1|
            if vac_ids[k1].nil?
                vac_ids[k1] = v1
            else
                v2 = vac_ids[k1]
                vac_ids[k1] = v1 + v2
            end
        end

        dest_ids.each do |k1, v1|
            if vac_ids[k1].nil?
                vac_ids[k1] = v1
            else
                v2 = vac_ids[k1]
                vac_ids[k1] = v1 + v2
            end
        end

        reversed_h = vac_ids.sort_by {|k, v| v}
        vac_ids = Hash[reversed_h.reverse!]


        cities = cities.find(vac_ids.keys)

        cities.each do |c|
            c.set_rating(vac_ids[c.id])
        end

        puts cities.class
        puts cities