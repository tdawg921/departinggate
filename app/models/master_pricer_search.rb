class MasterPricerSearch < ActiveRecord::Base
  attr_accessible :id, :search_id, :xml
  belongs_to :search

  def self.new_request(search)
  	@search = Search.find(search)
  	#@search = Search.find(208)
  	@cities = @search.cities
  	puts @cities
  	@client = Savon.client(wsdl: "amadeus.wsdl")
  	#@session = SoapSessions.get_new_session

  	@xml = ::Builder::XmlMarkup.new(:indent => 3)

  	call = @xml.tag!("soapenv:Envelope", :"xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
  		:"xmlns:wbs" => "http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd"){
  		@xml.soapenv :Header do |xml|
  			xml.wbs :Session do |xml|
	  			#xml.wbs :SessionId, @session.session_id
	  			xml.wbs :SequenceNumber, "2"
	  			#xml.wbs :SecurityToken, @session.security_token
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

    puts call
=begin
  	#response = @client.call(:fare_master_pricer_travel_board_search, xml: call)
  	rescue  Savon::SOAPFault => error
          Rails.logger.warn error.http.code
    rescue Savon::HTTPError => error
      Rails.logger.warn error.http.code
    else
      body = response.body[fare_master_pricer_travel_board_search_reply]
      MasterPricerSearch.create({:xml => response})
=end  
  end

end
