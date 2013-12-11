class MasterPricerSearch < ActiveRecord::Base
  attr_accessible :id, :search_id, :xml
  serialize :xml
  belongs_to :search

  def self.xml
    @xml
  end

  def self.load_results(results_hash, search)
  	@search_id = search
  	@results_hash = results_hash
  	@results_hash[:flight_index].each do |flight|
  		flight_proposal = flight[:requested_segment_ref][:seg_ref]
  		@group_of_flights = GroupOfFlights.create({:search_id => @search_id}, {:flight_proposal => flight_proposal})
  		flight[:group_of_flights].each do |group|
  			group[:prop_flight_gr_detail][:flight_proposal].each do |flight_proposal|
  				ref = flight_proposal[:ref]
  				unit_qualifier = flight_proposal[:unit_qualifier] #if flight_proposal[:unit_qualifier].present?
  				PropFlightGrDetails.create({:ref => ref, :group_of_flights_id => @group_of_flights.id, :unit_qualifier => unit_qualifier})
  			end

  			flight_information = flight[:flight_details][:flight_information]
  			time_details = flight_information[:product_date_time]
  			date_of_departure = time_details[:date_of_departure]
  			time_of_departure = time_details[:time_of_departure]
  			date_of_arrival = time_details[:date_of_arrival]
  			time_of_arrival = time_details[:time_of_arrival]

  			location_details = flight_information[:location]
  			dep_location_id = location_details.first[:location_id]
  			dep_terminal = location_details.first[:terminal]
  			arr_location_id = location_details.second[:location_id]
  			arr_terminal = location_details.second[:terminal]

  			carrier_details = flight_information[:company_id]
  			marketing_carrier = carrier_details[:marketing_carrier]
  			operating_carrier = carrier_details[:operating_carrier]

  			flight_number = flight_information[:flight_ortrain_number]
  			equipment_type = flight_information[:product_detail][:equipment_type]
  			electronic_ticketing = flight_information[:add_product_detail][:electronic_ticketing]
  			product_detail_qualifier = flight_information[:add_product_detail][:product_detail_qualifier]

  			FlightDetails.create({:group_of_flights_id => @group_of_flights.id, :date_of_departure => date_of_departure, 
  				:time_of_departure => time_of_departure, :date_of_arrival => date_of_arrival, :time_of_arrival => time_of_arrival,
  				:dep_location_id => dep_location_id, :dep_terminal => dep_terminal, :arr_location_id => arr_location_id,
  				:arr_terminal => arr_terminal, :marketing_carrier => marketing_carrier, :operating_carrier => operating_carrier,
  				:flight_number => flight_number, :equipment_type => equipment_type, :electronic_ticketing => electronic_ticketing,
  				:product_detail_qualifier => product_detail_qualifier})
  		end

  	end

  end

  def self.generate_xml(search)
  	@search = search

  	#Get a new session for the SOAP header
  	@session = SoapSessions.get_new_session

  	#Initialize Builder
  	@xml = ::Builder::XmlMarkup.new(:indent => 3)

  	#Generate XML for Fare_MasterPricerTravelBoardSearch
  	call = @xml.tag!("soapenv:Envelope", :"xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
	:"xmlns:wbs" => "http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd"){
		@xml.soapenv :Header do |xml|
			xml.wbs :Session do |xml|
				xml.wbs :SessionId, @session.session_id
				xml.wbs :SequenceNumber, "2"
				xml.wbs :SecurityToken, @session.security_token
			end
		end
		@xml.tag!("soapenv:Body"){
			@xml.tag!("Fare_MasterPricerTravelBoardSearch"){
				@xml.tag!("numberOfUnit"){
					@xml.tag!("unitNumberDetail"){
						@xml.numberOfUnits("200")
						@xml.typeOfUnit("RC")
					}
					@xml.tag!("unitNumberDetail"){
						@xml.numberOfUnits(@search.traveller.to_s)
						@xml.typeOfUnit("PX")
					}
				}
				@xml.tag!("paxReference"){
					@xml.ptc "ADT"
					@xml.traveller{
						@xml.ref  @search.traveller.to_s
					}
				}
				@xml.itinerary{
					@xml.tag!("requestedSegmentRef"){
						@xml.segRef("1")
					}
					@xml.tag!("departureLocalization"){
						@xml.tag!("departurePoint"){
							@xml.locationId(@search.origin)
						}
					}
					@xml.tag!("arrivalLocalization"){
						#@cities.each do |city|
							@xml.tag!("arrivalPointDetails"){
								@xml.locationId("NYC")
							}
						#end
					}
					@xml.tag!("timeDetails"){
						@xml.tag!("firstDateTimeDetail"){
							@xml.date @search.depart_date.to_s(:amadeus)
						}
					}
				}
				@xml.itinerary{
					@xml.tag!("requestedSegmentRef"){
						@xml.segRef("2")
					}  				
					@xml.tag!("departureLocalization"){
						#@cities.each do |city|
							@xml.tag!("departurePoint"){
								@xml.locationId("NYC")
							}
						#end
					}
					@xml.tag!("arrivalLocalization"){
						@xml.tag!("arrivalPointDetails"){
							@xml.locationId(@search.origin)
						}
					}

					@xml.tag!("timeDetails"){
						@xml.tag!("firstDateTimeDetail"){
							@xml.date @search.return_date.to_s(:amadeus)
						}
					}
				}
			}
		}
	}

	#Return XML for use in call
	call
  end

  def self.new_request(search)
  	@search = Search.find(search)

  	@client = Savon.client(wsdl: "amadeus.wsdl")

  	call = MasterPricer.generate_xml(@search)

  	response = @client.call(:fare_master_pricer_travel_board_search, xml: call)
  	rescue  Savon::SOAPFault => error
      Rails.logger.warn error.http.code
    rescue Savon::HTTPError => error
      Rails.logger.warn error.http.code
    else
      master_pricer = response.body[:fare_master_pricer_travel_board_search_reply]
      MasterPricerSearch.create({:xml => master_pricer.to_s, :search_id => @search.id})
      MasterPricerSearch.load_results(master_pricer, @search.id)

  end

  
end
