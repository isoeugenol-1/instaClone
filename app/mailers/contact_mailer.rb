class ContactMailer < ApplicationMailer
  def contact_mail(contact,picture)
    @picture = picture
    mail from: contact.name, to: contact.email, subject: "投稿確認メール"
  end
end
