# frozen_string_literal: true

# ContactMailer is responsible for sending emails from the contact form.
# It uses the default settings to set the sender and recipient addresses,
# and it includes a method to send the email with the contact's details.
class ContactMailer < ApplicationMailer
  default from: 'noreply@example.com'
  default to: 'admin@example.com'
  layout 'mailer'

  # Sends an email with the details from a contact form submission.
  # @param contact [Contact] The contact instance containing the form details.
  def send_mail(contact)
    @contact = contact
    mail(from: contact.email, to: ENV.fetch('MAIL_ADDRESS', nil), subject: 'Webサイトより問い合わせが届きました', &:text)
  end
end
