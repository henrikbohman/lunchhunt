class Restaurant < ActiveRecord::Base
	default_scope -> { order('score DESC') }
end
