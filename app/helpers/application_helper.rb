module ApplicationHelper

  def original_url
    base_url + original_fullpath
  end

  def read_notification(notification_id)
    @notification = Notification.find(notification_id)
    @notification.update read: true
    # redirect_to events_path
  end

end
