class Contact
  include ActiveModel::Model

  attr_accessor :contact_name, :contact_email, :contact_email_confirmation, :contact_comment

  validates :contact_name, presence: { message: '名前を入力してください' }
  validates :contact_email, presence: { message: 'メールアドレスを入力してください' }
  validates :contact_email, confirmation: { message: '確認用メールアドレスが一致しません' }
  validates :contact_email_confirmation, presence: { message: '確認用メールアドレスを入力してください' }
  validates :contact_comment, presence: { message: 'お問い合わせ内容を入力してください' }
end