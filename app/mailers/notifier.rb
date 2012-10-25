class Notifier < ActionMailer::Base
  default :from=> "no-replayt@nasport.pl"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.event_changed.subject
  #
  def event_changed user, event
    @event = event
    @user = user

    mail :to=>user.email, :subject=>'Event has changed!'
  end
  
  def event_in_one_day user, event
   @event = event
   @user = user
   mail :to=>user.email, :subject => 'NaSport.pl - przypomnienie' 
  end
end
