# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def follow data
    stop_all_streams
    room = Room.find data["id"].to_i
    number_of_unread_message = 1
    stream_from "rooms:#{data['id'].to_i}:messages"
  end

  def unfollow
    stop_all_streams
  end
end
