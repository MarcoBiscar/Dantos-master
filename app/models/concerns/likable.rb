module Likable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable, dependent: :destroy
    has_many :likers, through: :likes, source: :user
  end

  def liked_by liker
    if self.likers.include? liker
      self.likers.delete liker
    else
      self.likers << liker
    end
  end

  def liked_by? liker
    self.likers.include? liker
  end
end