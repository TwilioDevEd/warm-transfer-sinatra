require_relative '../spec_helper'

describe 'POST /conference/connect/client' do
  it 'is successful' do
    call_sid = '1234'
    post 'conference/connect/client', CallSid: call_sid
    expect(last_response).to be_ok
  end
end
