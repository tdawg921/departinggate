class MasterPricerSearch < ActiveRecord::Base
  attr_accessible :id, :search_id, :xml
  belongs_to :search

  def self.new_request(search)
  	#@search = Search.find(search)
  	@search = Search.find(208)
  	@cities = @search.cities
  	puts @cities
  	@client = Savon.client(wsdl: "amadeus.wsdl")
  	@session = SoapSessions.get_new_session
  	puts call = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" 
  	xmlns:wbs=\"http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd\" xmlns=\"http://xml.amadeus.com/FMPTBQ_12_4_1A\">
   <soapenv:Header>
      <wbs:Session>
         <wbs:SessionId>#{@session.session_id}</wbs:SessionId>
         <wbs:SequenceNumber>2</wbs:SequenceNumber>
         <wbs:SecurityToken>#{@session.security_token}</wbs:SecurityToken>
      </wbs:Session>
   </soapenv:Header>
   <soapenv:Body>
  	<Fare_MasterPricerTravelBoardSearch>
  <numberOfUnit>
    <unitNumberDetail>
      <numberOfUnits>1</numberOfUnits>
      <typeOfUnit>PX</typeOfUnit>
    </unitNumberDetail>
    <unitNumberDetail>
      <numberOfUnits>10</numberOfUnits>
      <typeOfUnit>RC</typeOfUnit>
    </unitNumberDetail>
  </numberOfUnit>
  <paxReference>
    <ptc>ADT</ptc>
    <traveller>
      <ref>1</ref>
    </traveller>
  </paxReference>
  <fareOptions>
    <pricingTickInfo>
      <pricingTicketing>
        <priceType>ET</priceType>
        <priceType>RP</priceType>
        <priceType>RU</priceType>
        <priceType>TAC</priceType>
      </pricingTicketing>
    </pricingTickInfo>
  </fareOptions>
  <itinerary>
    <requestedSegmentRef>
      <segRef>1</segRef>
    </requestedSegmentRef>
    <departureLocalization>
      <departurePoint>
        <locationId>BOS</locationId>
      </departurePoint>
    </departureLocalization>
    <arrivalLocalization>
      <arrivalPointDetails>
        <locationId>LON</locationId>
      </arrivalPointDetails>
    </arrivalLocalization>
    <timeDetails>
      <firstDateTimeDetail>
        <date>150914</date>
      </firstDateTimeDetail>
    </timeDetails>
  </itinerary>
  <itinerary>
    <requestedSegmentRef>
      <segRef>2</segRef>
    </requestedSegmentRef>
    <departureLocalization>
      <departurePoint>
        <locationId>LON</locationId>
      </departurePoint>
    </departureLocalization>
    <arrivalLocalization>
      <arrivalPointDetails>
        <locationId>BOS</locationId>
      </arrivalPointDetails>
    </arrivalLocalization>
    <timeDetails>
      <firstDateTimeDetail>
        <date>200914</date>
      </firstDateTimeDetail>
    </timeDetails>
  </itinerary>
</Fare_MasterPricerTravelBoardSearch>
   </soapenv:Body>
</soapenv:Envelope>"
=begin
  	@xml = ::Builder::XmlMarkup.new(:indent => 3)

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
	  					@xml.numberOfUnits("1")#(@search.traveller.to_s)
	  					@xml.typeOfUnit("PX")
	  				}
	  			}
	  			@xml.tag!("paxReference"){
	  				@xml.ptc "ADT"
	  				@xml.traveller{
	  					@xml.ref "1"#@search.traveller.to_s
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
	  						@xml.date "301113"
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
	  						@xml.date "301213"
	  					}
	  				}
	  			}
	  		}
	  	}
  	}
=end

  	response = @client.call(:fare_master_pricer_travel_board_search, xml: call)
  	#puts @search
  	#puts @xml.to_s
  end

end
