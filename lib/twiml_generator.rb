module TwimlGenerator
  def self.generate_connect_conference(call_sid,
                                       wait_url,
                                       start_on_enter,
                                       end_on_exit)
    dial = Twilio::TwiML::Dial.new
    dial.conference(call_sid, start_conference_on_enter: start_on_enter,
                              end_conference_on_exit: end_on_exit,
                              wait_url: wait_url)
    response = Twilio::TwiML::VoiceResponse.new
    response.append(dial)

    response.to_xml_str
  end

  def self.generate_wait
    response = Twilio::TwiML::VoiceResponse.new
    response.say 'Thank you for calling. '\
      'Please wait in line for a few seconds. '\
      'An agent will be with you shortly.'
    response.play 'http://com.twilio.music.classical.s3.amazonaws.com/BusyStrings.mp3'

    response.to_xml_str
  end
end
