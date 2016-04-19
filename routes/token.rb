module Routes
  module Token
    def self.registered(app)
      app.post '/:agent_id/token' do
        TwilioCapability.generate(params[:agent_id])
      end
    end
  end
end

