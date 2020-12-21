FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "test#{n}" }
    squad_number { 10 }
    position { 'MF' }
    File.open(File.join(Rails.root, 'spec/factories/images/test_pic.png'))
  end
end