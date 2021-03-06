# == Schema Information
#
# Table name: freelancers
#
#  id                         :integer          not null, primary key
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  reset_password_token       :string
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  sign_in_count              :integer          default(0), not null
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :inet
#  last_sign_in_ip            :inet
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  username                   :string
#  bio                        :string
#  first_name                 :string
#  last_name                  :string
#  picture                    :string
#  headline                   :string
#  work_experience            :string
#  gender                     :string
#  avatar                     :string
#  category                   :string
#  availability               :datetime
#  primary_skill              :integer
#  years_of_experiences       :string
#  project_description        :string
#  project_url                :string
#  professional_profile_link1 :string
#  professional_profile_link2 :string
#  status                     :string           default("pause")
#  authentication_token       :string(30)
#  stripe_publishable_key     :string
#  stripe_token               :string
#  stripe_client_id           :string
#  last_seen_at               :datetime
#  accepted_kriya_policy      :boolean          default(FALSE)
#
# Indexes
#
#  index_freelancers_on_authentication_token  (authentication_token) UNIQUE
#  index_freelancers_on_email                 (email) UNIQUE
#  index_freelancers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Freelancer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum status: { pause: 'pause', live: 'live' }

  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :picture, :headline, :category, :availability, :primary_skill, :years_of_experiences, :project_description, :professional_profile_link1, presence: true

  before_save :ensure_authentication_token

  has_many :freelancer_authorizations, dependent: :destroy
  has_many :unseen_messages, dependent: :destroy

  has_many :freelancer_skills
  has_many :skills, through: :freelancer_skills, dependent: :destroy

  has_many :freelancers_rooms, class_name: 'FreelancersRooms'
  has_and_belongs_to_many :asigned_rooms, join_table: :freelancers_rooms, class_name: "Room", after_add: :send_asigned_room_email_to_freelancer
  has_many :messages, dependent: :destroy
  has_many :slack_channels, dependent: :destroy

  scope :live, -> { where(status: 'live') }

  def full_name
    [first_name, last_name].join(' ')
  end

  def profile_picture
    if self.picture.present?
      self.picture
    elsif self.gender == 'male'
      'default-male.png'
    else
      'default-female.png'
    end
  end

  def name
    [first_name, last_name].join(' ')
  end

  def gig_slack_channel
    slack_channels.find_by(room_id: nil)
  end

  def type
    'freelancer'
  end

  def first_name_for_email
    first_name
  end

  def accept_kriya_policy!
    update!(accepted_kriya_policy: true)
  end

  def pending_rooms
    self.asigned_rooms.where(freelancers_rooms: { status: 'pending' })
  end

  def accepted_rooms
    self.asigned_rooms.where(freelancers_rooms: { status: ['accepted', 'not_finished', 'more_work'] })
  end

  def just_accepted_rooms?(room_id)
    room = accepted_rooms.where(id: room_id).first
    room.messages.last.bot_task_accepted?
  end

  alias rooms accepted_rooms

  def completed_rooms
    self.asigned_rooms.where(freelancers_rooms: { status: 'completed' })
  end

  def available_rooms
    self.asigned_rooms.where(freelancers_rooms: { status: ['accepted', 'pending', 'not_finished', 'more_work'] })
  end

  def send_asigned_room_email_to_freelancer(record)
    UserNotifierMailer.delay(queue: :room).notify_asigned_room(record, self)
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = loop do
        token = Devise.friendly_token
        break token unless Freelancer.where(authentication_token: token).first
      end
    end
  end

  def self.from_omniauth auth
    authdata = case auth.provider
    when "twitter"
      {
        email: auth.info.email,
        first_name: auth.info.name.split(" ").first,
        picture: auth.info.image.gsub("_normal", ""),
        last_name: auth.info.name.split(" ").last,
        uid: auth.uid,
        token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        expires_at: auth.credentials.expires_at,
        username: auth.info.nickname,
        provider: "twitter"
      }
    when "linkedin"
      {
        email: auth.info.email,
        first_name: auth.info.first_name,
        picture: auth.extra.raw_info.pictureUrls.values.last.last,
        last_name: auth.info.last_name,
        uid: auth.uid,
        headline: auth.info.description,
        token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        expires_at: auth.credentials.expires_at,
        provider: "linkedin"
      }
    when "facebook"
      {
        email: auth.info.email,
        first_name: auth.info.first_name,
        picture: auth.info.image.gsub("square", "large"),
        last_name: auth.info.last_name,
        uid: auth.uid,
        token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        expires_at: auth.credentials.expires_at,
        provider: "facebook"
      }
    end

    auth = FreelancerAuthorization.find_by uid: authdata[:uid], provider: authdata[:provider]
    if authdata[:provider] == 'twitter'
      if !auth.nil? && !auth.freelancer.nil? && auth.freelancer.persisted?
        return auth.freelancer
      end
    else
      if auth.nil? || auth.freelancer.nil?
        freelancer = Freelancer.find_by email: authdata[:email]
        if !freelancer.nil? && freelancer.persisted?
          freelancer.freelancer_authorizations.create!(
            uid: authdata[:uid],
            provider: authdata[:provider],
            token: authdata[:token],
            refresh_token: authdata[:refresh_token]
            # expires_at: authdata["expires_at"],
          )
          return freelancer
        end
      end
    end
    return auth&.freelancer || authdata
  end



  rails_admin do
    list do
      field :full_name
      field :email
      field :created_at
      field :professional_profile_link1
      field :status
      field :skills do
        formatted_value{
          bindings[:object].skills.each do |skill|
            skill.skill
          end
        }
      end
    end

  end

  def offline?
    !online?
  end

  def online?
    return false if last_seen_at.nil?
    last_seen_at > 10.minutes.ago
  end

  private

  def update_status
    new_status = self.status == 'pause' ? 'live' : 'pause'
    self.update_attribute(:status, new_status)
  end
end
