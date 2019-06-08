module Followable
  extend ActiveSupport::Concern

  included do
    has_many :follows, as: :followable, dependent: :destroy
    has_many :followers, through: :follows, source: :user
  end

  def followed_by follower
    if self.followers.include? follower
      self.followers.delete follower
    else
      self.followers << follower
    end
  end

  def followed_by? follower
    self.followers.include? follower
  end
end