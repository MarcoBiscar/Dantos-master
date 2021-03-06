# == Schema Information
#
# Table name: freelancers_rooms
#
#  id            :integer          not null, primary key
#  freelancer_id :integer
#  room_id       :integer
#  status        :string           default("pending")
#
# Indexes
#
#  index_freelancers_rooms_on_freelancer_id_and_room_id  (freelancer_id,room_id) UNIQUE
#

class FreelancersRooms < ApplicationRecord
  enum status: {pending: 'pending', accepted: 'accepted', in_progress: 'in_progress', completed: 'completed', rejected: 'rejected', more_work: 'more_work', not_finished: 'not_finished'}

  belongs_to :room
  belongs_to :freelancer

  has_many :freelancer_rates, dependent: :destroy, foreign_key: :freelancers_room_id, class_name: '::FreelancerRate'

  validates_presence_of :room_id, :freelancer_id

  after_create :send_asigned_room_email_to_freelancer

  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :more_work, -> { where(status: 'more_work') }
  scope :completed, -> { where(status: 'completed') }
  scope :not_finished, -> { where(status: 'not_finished') }

  def send_asigned_room_email_to_freelancer
    UserNotifierMailer.delay(queue: :room).notify_asigned_room(self.room, self.freelancer)
  end

  rails_admin do
    configure :freelancer do
      associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.live
        }
      end
    end
  end

end
