module TwilioCapability
  def self.generate(agent_id)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    scope = Twilio::JWT::ClientCapability::IncomingClientScope.new(agent_id)
    capability = Twilio::JWT::ClientCapability.new(account_sid, auth_token)
    capability.add_scope(scope)
    capability.to_jwt
  end
end
