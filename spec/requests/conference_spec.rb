require_relative '../spec_helper'

describe 'POST /conference/connect/client' do
  it 'is successful' do
    call_sid = '1234'
    expect(TwimlGenerator).to receive(:generate_connect_conference)
      .with(call_sid, '/conference/wait', false, true)
      .once
      .and_return('<Response></Response>')

    expect(Caller).to receive(:call_agent)
      .with("agent1", '')
      .once
    post 'conference/connect/client', CallSid: call_sid
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
