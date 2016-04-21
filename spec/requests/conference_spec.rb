require_relative '../spec_helper'

describe 'Conference routes'do

  agent_wait_url = 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical'
  conference_id = 'conference1234'

  before(:each) do
    ActiveCall.all.destroy
  end

  describe 'POST /conference/connect/client' do
    it 'returns Dial Conference TwiML' do
      call_sid = '1234'
      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(call_sid, '/conference/wait', false, true)
        .once
        .and_return('<Response></Response>')
  
      expect(Caller).to receive(:call_agent)
        .with("agent1", "http://example.org/conference/#{call_sid}/connect/agent1/")
        .once
      post 'conference/connect/client', CallSid: call_sid
      expect(last_response).to be_ok
    end
  end

  describe 'POST /conference/:conference_id/connect/agent1/' do
    it 'returns Dial Conference TwiML' do
      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(conference_id, agent_wait_url, true, false)
        .once
        .and_return('<Response></Response>')
  
      post "/conference/#{conference_id}/connect/agent1/"
  
      expect(last_response).to be_ok
    end
  end

  describe 'POST /conference/:conference_id/connect/agent2/' do
    it 'returns Dial Conference TwiML' do
  
      expect(TwimlGenerator).to receive(:generate_connect_conference)
        .with(conference_id, agent_wait_url, true, true)
        .once
        .and_return('<Response></Response>')
  
      post "/conference/#{conference_id}/connect/agent2/"
  
      expect(last_response).to be_ok
    end
  end

  describe 'POST /conference/:agent_id/call' do
    it 'creates a call to agent 2' do
      ActiveCall.create(agent_id: 'agent1', conference_id: conference_id)
      expect(Caller).to receive(:call_agent)
        .with('agent2', "http://example.org/conference/#{conference_id}/connect/agent2/")
        .once

      post "conference/agent1/call"
  
      expect(last_response).to be_ok
    end
  end

  describe 'POST /conference/wait' do
    it 'returns Dial Conference TwiML' do
      expect(TwimlGenerator).to receive(:generate_wait)
        .once
        .and_return('<Response></Response>')
  
      post '/conference/wait'

      expect(last_response).to be_ok
    end
  end
end
