require 'data_mapper'

class ActiveCall
  include DataMapper::Resource

  property :id, Serial
  property :agent_id, String
  property :conference_id, String

end
