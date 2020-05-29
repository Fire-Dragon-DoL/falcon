# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@mw.com'
  layout 'mailer'
end
