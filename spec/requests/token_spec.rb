require_relative '../spec_helper'

describe 'POST :agent_id/token' do
  agent_id = 'agent'
  it 'generates a capability token' do
    expect(TwilioCapability).to receive(:generate)
      .with(agent_id)
      .once
      .and_return('token')

    post "/#{agent_id}/token"

    expect(last_response).to be_ok
  end
end

