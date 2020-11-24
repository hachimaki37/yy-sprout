class ContactsMailer < ApplicationMailer
  #NOTE: config/settings/mail_address.ymlで管理したい
  default from: "contact@sproutfc.com"

  def received_email(contact)
    mail_subject = "【SPROUT FC】お問い合わせがありました"

    @contact = contact
    mail(to: "ksezj93908@yahoo.co.jp, juta1991lon@gmail.com", subject: mail_subject)
  end
end
