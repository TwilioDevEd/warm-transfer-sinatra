require 'twilio-ruby'
require_relative '../../lib/twilio_capability'

describe TwilioCapability do
  describe '.generate' do
    it 'generates a capability token' do
      capability_double = double(:capability)
      capability_scope = double(:scope)
      agent_id = 'agent'

      allow(Twilio::JWT::ClientCapability).to receive(:new)
        .with(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
        .and_return(capability_double)

      allow(Twilio::JWT::ClientCapability::IncomingClientScope).to receive(:new)
        .with(agent_id)
        .and_return(capability_scope)

      expect(capability_double).to receive(:add_scope)
        .with(capability_scope)
        .once

      expect(capability_double).to receive(:to_jwt)
        .once

      described_class.generate(agent_id)
    end
  end
end
