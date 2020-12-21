class Player < ApplicationRecord
  mount_uploader :image, ImageUploader

  enum position: { GK: 1, DF: 2, MF: 3, FW: 4 }

  validates :name, presence: { message: '選手名を入力してください' },
                    length: { maximum: 10, message: '選手名は10文字以下に設定して下さい' }
  validates :squad_number, presence: { message: '背番号を選択してください' },
                            uniqueness: { message: '選択した背番号は既に使用されています' }
  validates :position, presence: { message: 'ポジションを選択してください' }
end