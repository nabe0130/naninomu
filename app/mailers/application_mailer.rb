# frozen_string_literal: true

# ApplicationMailer serves as the base class for all mailer classes in the application.
# It sets default values and configurations that are shared across all mailers.
# For example, it sets the default from email address and specifies the layout used for emails.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com' # Set the default sender email address.
  layout 'mailer' # Specify the layout file to use for emails.
end
