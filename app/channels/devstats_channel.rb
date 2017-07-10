class DevstatsChannel < ApplicationCable::Channel
  def subscribed
  	@developer = User.all.where(role: :developer).first
     stream_from "online_channel"
     stream_from "call_log_channel"
     stream_from "active_log_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
