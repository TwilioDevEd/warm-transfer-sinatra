module Routes
  module Token
    def self.registered(app)
      app.post '/:agent_id/token' do
        agent_id = params[:agent_id]
        json :token => TwilioCapability.generate(agent_id), :agentId => agent_id
      end
    end
  end
end

