module ApplicationHelper
  def dolacz_do_eventu_link(event, options={})
    if event.has_free_spot?
      link_to('Dolacz!', join_event_path(event), :class=>options[:class])
    else
      "Brak miejsc".html_safe
    end
  end
  
  def join_or_resign_from_event_link(user, event, options={})
     event.users.include?(user) ? link_to('Zrezygnuj', resign_event_path(event), :class=>options[:class]) : dolacz_do_eventu_link(event, :class=>options[:class])
  end
end
