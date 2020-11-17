class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :email_confirmation, :message

  validates :name, presence: { message: '名前を入力してください' }
  validates :email, presence: { message: 'メールアドレスを入力してください' }
  validates :email_confirmation, presence: { message: '確認用メールアドレスが一致しません' }
end