class GenericMailer < ApplicationMailer
  def notification(to, subject, body)
    mail(to: to, subject: subject, body: body)
  end
end
