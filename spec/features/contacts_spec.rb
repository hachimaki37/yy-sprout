require 'rails_helper'

RSpec.feature "Contacts", js: true do
  describe '問合せフォーム' do
    context '入力項目が正常な場合' do
      before do
        visit root_path
        click_on 'Contact'
      end

      scenario '問合せ内容が送信されること' do
        expect(page).to have_content 'Contact'
        expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

        fill_in 'contact_name', with: name = Faker::Name.name
        fill_in 'contact_email', with: email = Faker::Internet.email
        fill_in 'contact_email_confirmation', with: email
        fill_in 'contact_comment', with: comment = 'テスト応募です。'
        click_on '確認画面へ'

        expect(page).to have_content 'Contact 確認'
        expect(page).to have_content 'お問い合わせ内容をご確認の上、「送信する」を押してください。'
        expect(find('#contact_contact_name', visible: false).value).to eq name
        expect(find('#contact_contact_email', visible: false).value).to eq email
        expect(find('#contact_contact_comment', visible: false).value).to eq comment
        click_on '送信する'

        expect(page).to have_content 'Contact 完了'
        expect(page).to have_content 'お問い合わせいただきありがとうございました！'

        sent_contact = ActionMailer::Base.deliveries.last
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        expect(sent_contact.from).to eq ["contact@sproutfc.com"]
        expect(sent_contact.subject).to eq '【SPROUT FC】お問い合わせがありました'
        expect(sent_contact.to).to eq ['ksezj93908@yahoo.co.jp']
        expect(sent_contact.body).to have_content 'SPROUT FCの問合せフォームからお問い合わせがありました。'
        expect(sent_contact.body).to have_content name
        expect(sent_contact.body).to have_content email
        expect(sent_contact.body).to have_content comment
      end
    end

    context '入力項目が非正常な場合' do
      before do
        visit root_path
        click_on 'Contact'
      end

      context 'バリデーションがでること' do
        scenario '入力項目が全て未入力の場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: ''
          fill_in 'contact_email', with: ''
          fill_in 'contact_email_confirmation', with: ''
          fill_in 'contact_comment', with: ''
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content '名前を入力してください'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(page).to have_content '確認用メールアドレスを入力してください'
          expect(page).to have_content 'お問い合わせ内容を入力してください'
        end

        scenario '入力項目の名前がnilの場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: ''
          fill_in 'contact_email', with: email = Faker::Internet.email
          fill_in 'contact_email_confirmation', with: email
          fill_in 'contact_comment', with: comment = 'テスト応募です。'
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content '名前を入力してください'
        end

        scenario '入力項目のemailがnilの場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: name = Faker::Name.name
          fill_in 'contact_email', with: ''
          fill_in 'contact_email_confirmation', with: email = Faker::Internet.email
          fill_in 'contact_comment', with: comment = 'テスト応募です。'
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content 'メールアドレスを入力してください'
        end

        scenario '入力項目のemail_confirmationがnilの場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: name = Faker::Name.name
          fill_in 'contact_email', with: email = Faker::Internet.email
          fill_in 'contact_email_confirmation', with: ''
          fill_in 'contact_comment', with: comment = 'テスト応募です。'
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content '確認用メールアドレスが一致しません'
          expect(page).to have_content '確認用メールアドレスを入力してください'
        end

        scenario '入力項目のemail_confirmationが異なる場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: name = Faker::Name.name
          fill_in 'contact_email', with: email = Faker::Internet.email
          fill_in 'contact_email_confirmation', with: email + 'test'
          fill_in 'contact_comment', with: comment = 'テスト応募です。'
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content '確認用メールアドレスが一致しません'
        end

        scenario '入力項目のcommentがnilの場合' do
          expect(page).to have_content 'Contact'
          expect(page).to have_content '「メンバー募集」に関するお問い合わせ、「その他」お問い合わせはこちらのフォームよりご連絡ください。'

          fill_in 'contact_name', with: name = Faker::Name.name
          fill_in 'contact_email', with: email = Faker::Internet.email
          fill_in 'contact_email_confirmation', with: email
          fill_in 'contact_comment', with: comment = ''
          click_on '確認画面へ'

          expect(page).to have_content '入力内容にエラーがあるため、ご確認ください。'
          expect(page).to have_content 'お問い合わせ内容を入力してください'
        end
      end
    end
  end
end
