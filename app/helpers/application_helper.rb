module ApplicationHelper
  def join_or_resign_from_event_link(user, event)
    event.users.include?(user) ? link_to('Zrezygnuj', resign_event_path(event)) : link_to('Dolacz!', join_event_path(event))
  end
end
