require 'data_mapper'

require_relative '../models/active_call'

module DataMapperHelper
  def self.setup(database_url)
    DataMapper.setup(:default, database_url)
    DataMapper.finalize

    # this section automatically creates the tables
    ActiveCall.auto_upgrade!
  end
end
