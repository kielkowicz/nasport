module ApplicationHelper
  def dolacz_do_eventu_link(event)
    if event.has_free_spot?
      link_to('Dolacz!', join_event_path(event))
    else
      "Brak miejsc".html_safe
    end
  end
  
  def join_or_resign_from_event_link(user, event)
     event.users.include?(user) ? link_to('Zrezygnuj', resign_event_path(event)) : dolacz_do_eventu_link(event)
  end
end
