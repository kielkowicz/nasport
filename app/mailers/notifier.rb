class Notifier < ActionMailer::Base
  default :from=> "nasport@example.com"

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
end
