class Attendance < ActiveRecord::Base
	belongs_to :user
	belongs_to :event
	include Workflow
	workflow_column :state

	workflow do 
		state :request_sent do
			event :accept, :transitions_to => 'request_accepted'
			event :reject, :transitions_to => 'request_rejected'
		end
		state :request_accepted
		state :request_rejected
	end

	def self.join_event(user_id, event_id, state)
		self.create(user_id: user_id, event_id: event_id, state: state)
	end
end
