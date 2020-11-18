class ContactsMailer < ApplicationMailer
  #NOTE: config/settings/mail_address.ymlで管理したい
  default from: "contact@sproutfc.com"
  default to: "juta1991lon@gmail.com"

  def received_email(contact)
    mail_subject = "【SPROUT FC】お問い合わせがありました"

    @contact = contact
    mail(subject: mail_subject)
  end
end
