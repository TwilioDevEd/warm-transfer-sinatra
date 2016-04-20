module Routes
  module Conference

    AGENT_WAIT_URL = 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical'

    def self.registered(app)
      app.post '/conference/connect/client' do
        agent_id = 'agent1'
        conference_id = params[:CallSid]
        Caller.call_agent(
          agent_id,
          "/conference/#{conference_id}/connect/agent1/"
        )

        twiml = TwimlGenerator.generate_connect_conference(
          conference_id,
          '/conference/wait',
          false,
          true
        )

        call = ActiveCall.first_or_create(agent_id: agent_id)
        call.conference_id = conference_id
        call.save!
        content_type 'text/xml'
        twiml
      end

      app.post '/conference/:conference_id/connect/agent1/' do
        content_type 'text/xml'
        TwimlGenerator.generate_connect_conference(
          params[:conference_id],
          AGENT_WAIT_URL,
          true,
          false
        )
      end

      app.post '/conference/:conference_id/connect/agent2/' do
        content_type 'text/xml'
        TwimlGenerator.generate_connect_conference(
          params[:conference_id],
          AGENT_WAIT_URL,
          true,
          true
        )
      end

      app.post '/conference/:agent_id/call' do
        agent_id = params[:agent_id]
        conference_id = ActiveCall.first(agent_id: agent_id).conference_id

        Caller.call_agent(
          'agent2',
          "/conference/#{conference_id}/connect/agent2/"
        )
      end

      app.post '/conference/wait' do
        content_type 'text/xml'
        TwimlGenerator.generate_wait
      end
    end
  end
end
