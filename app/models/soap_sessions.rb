

class SoapSessions < ActiveRecord::Base
	attr_accessible :security_token, :session_id

	def self.get_new_session
		current_session = SoapSessions.where("updated_at < '#{1.minutes.ago}'")

		if current_session.empty?
			begin
			#SoapSessions.find(updated_at: < 30.seconds.ago)s
				@client = Savon.client(wsdl: "amadeus.wsdl")
			  	@xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
			  		xmlns:wbs="http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd" 
			  		xmlns:vls="http://xml.amadeus.com/VLSSLQ_06_1_1A">
					   <soapenv:Header>
					      <wbs:Session>
					         <wbs:SessionId></wbs:SessionId>
					         <wbs:SequenceNumber></wbs:SequenceNumber>
					         <wbs:SecurityToken></wbs:SecurityToken>
					      </wbs:Session>
					   </soapenv:Header>
					   <soapenv:Body>
					   	<Security_Authenticate> 
						  <userIdentifier> 
						    <originIdentification> 
						      <sourceOffice>DCA1S218G</sourceOffice> 
						    </originIdentification> 
						    <originatorTypeCode>U</originatorTypeCode> 
						    <originator>WSDEGDEG</originator> 
						  </userIdentifier> 
						  <dutyCode> 
						    <dutyCodeDetails> 
						      <referenceQualifier>DUT</referenceQualifier> 
						      <referenceIdentifier>SU</referenceIdentifier> 
						    </dutyCodeDetails> 
						  </dutyCode> 
						  <systemDetails> 
						    <organizationDetails> 
						      <organizationId>NMC-US</organizationId> 
						    </organizationDetails> 
						  </systemDetails> 
						  <passwordInfo> 
						    <dataLength>7</dataLength> 
						    <dataType>E</dataType> 
						    <binaryData>QU1BREVVUw==</binaryData> 
						  </passwordInfo> 
						</Security_Authenticate>
					   </soapenv:Body>
					</soapenv:Envelope>'

				response = @client.call(:security_authenticate, xml: @xml)
				rescue  Savon::SOAPFault => error
					Rails.logger.warn error.http.code
				rescue Savon::HTTPError => error
					Rails.logger.warn error.http.code
				else
					@session_id = response.header[:session][:session_id]
					@security_token = response.header[:session][:security_token]
					SoapSessions.create({:session_id => @session_id, :security_token => @security_token})
			end

			current_session = SoapSessions.first
		else
			current_session = current_session.first
			current_session.updated_at = Time.now
			current_session.save

			current_session
		end
	end

	def self.end_this_session(session_id)
		@client = Savon.client(wsdl: "amadeus.wsdl")
		@session_id = session_id
		SoapSessions.where(session_id: @session_id).delete_all

		#@xml = 
	end

	def self.sweep(time = 14.minutes)
		#if time.is_a?(String)
	  	#	time = time.split.inject { |count, unit| count.to_i.send(unit) }
		#end
		@client = Savon.client(wsdl: "amadeus.wsdl")
		@sessions_to_sign_out = SoapSessions.where("updated_at < '#{14.minutes.ago}'")

		@sessions_to_sign_out.each do |session|
			begin
				@xml = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" 
				xmlns:wbs=\"http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd\" 
				xmlns:vls=\"http://xml.amadeus.com/VLSSOQ_04_1_1A\">
				   <soapenv:Header>
				      <wbs:Session>
				        <SessionId>#{session.session_id}</SessionId>
				         <SequenceNumber>1</SequenceNumber>
				         <SecurityToken>#{session.security_token}</SecurityToken>
				      </wbs:Session>
				   </soapenv:Header>
				   <soapenv:Body>
				      <vls:Security_SignOut>
				      </vls:Security_SignOut>
				   </soapenv:Body>
				</soapenv:Envelope>"

				response = @client.call(:security_sign_out, xml: @xml)
			rescue Savon::SOAPFault => error
				Rails.logger.warn error.http.code
			rescue Savon::HTTPError => error
				Rails.logger.warn error.http.code
			end
		end

		delete_all "created_at < '#{time.ago.to_s(:db)}'"
	end
end
