module Routes
  module Conference
    def self.registered(app)
      app.post '/conference/connect/client' do
        agent_id = 'agent1'
        conference_id = params[:CallSid]
        Caller.call_agent(
          agent_id,
          ''
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
      app.post '/conference/wait' do
        content_type 'text/xml'
        TwimlGenerator.generate_wait
      end
    end
  end
end
