class FermentMailer < ApplicationMailer

  def review_reminder(ferment)
    @ferment = ferment
    @user = ferment.user

    mail(
      to: @user.email,
      subject: "⏰ ¡Hora de revisar tu fermento: #{@ferment.name}!"
    )
  end
  
end
