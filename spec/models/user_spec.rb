# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it 'Userオブジェクトが作成できる' do
    user = described_class.new(name: 'a', email: 'a@a.a', password: 'foobar', password_confirmation: 'foobar')
    expect(user).to be_valid
  end

  it 'nameは空白文字のみではだめ' do
    user = described_class.new(name: ' ', email: 'a@a.a', password: 'foobar', password_confirmation: 'foobar')
    expect(user).not_to be_valid
  end

  it 'emailは空白文字のみではだめ' do
    user = described_class.new(name: 'a', email: ' ', password: 'foobar', password_confirmation: 'foobar')
    expect(user).not_to be_valid
  end

  it 'nameが長すぎるとだめ' do
    user = described_class.new(name: 'a' * 51, email: 'a@a.a', password: 'foobar', password_confirmation: 'foobar')
    expect(user).not_to be_valid
  end

  it 'emailが長すぎるとだめ' do
    user = described_class.new(
      name: 'a', email: "#{'a' * 255}@example.com".last(256), password: 'foobar',
      password_confirmation: 'foobar'
    )
    expect(user).not_to be_valid
  end

  it '有効なメールアドレスを使える' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user = described_class.new(name: 'a', email: valid_address, password: 'foobar', password_confirmation: 'foobar')
      expect(user).to be_valid
    end
  end

  it '無効なアドレスは使えない' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = described_class.new(name: 'a', email: invalid_address, password: 'foobar', password_confirmation: 'foobar')
      expect(user).not_to be_valid
    end
  end

  it 'すでに登録されているアドレスは使えない' do
    user = User.create!(name: 'a', email: 'a@a.a', password: 'foobar', password_confirmation: 'foobar')
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    expect(duplicate_user).not_to be_valid
  end

  it 'passwordが短すぎるとだめ' do
    user = described_class.new(name: 'a', email: 'a@a.a', password: 'a' * 5, password_confirmation: 'a' * 5)
    expect(user).not_to be_valid
  end

  it 'passwordが空白のみだとだめ' do
    user = described_class.new(name: 'a', email: 'a@a.a', password: ' ' * 6, password_confirmation: ' ' * 6)
    expect(user).not_to be_valid
  end

  describe 'db制約' do
    user = nil
    before do
      user = described_class.create!(name: 'a', email: 'a@a.a', password: 'foobar', password_confirmation: 'foobar')
    end

    it 'nameを空白文字のみで更新できない' do
      expect { user.update_attribute(:name, ' ') }.to \
        raise_error(ActiveRecord::StatementInvalid, /name_present/)
    end

    it 'emailを空白文字のみで更新できない' do
      expect { user.update_attribute(:email, ' ') }.to \
        raise_error(ActiveRecord::StatementInvalid, /email_format/)
    end

    it 'nameを50文字以上にできない' do
      expect { user.update_attribute(:name, 'a' * 51) }.to \
        raise_error(ActiveRecord::StatementInvalid, /name_length/)
    end

    it 'emailを255文字以上にできない' do
      expect { user.update_attribute(:email, "#{'a' * 255}@example.com".last(256)) }.to \
        raise_error(ActiveRecord::StatementInvalid, /email_length/)
    end

    it '正しくないフォーマットのemailを使えない' do
      expect { user.update_attribute(:email, 'user@example,com') }.to \
        raise_error(ActiveRecord::StatementInvalid, /email_format/)
    end

    it 'すでに登録されているアドレスは使えない' do
      described_class.create!(name: 'a', email: 'b@b.b', password: 'foobar', password_confirmation: 'foobar')
      expect { user.update_attribute(:email, 'B@b.b') }.to \
        raise_error(ActiveRecord::RecordNotUnique, /email_unique/)
    end

    it '大文字のメールアドレスは登録できない' do
      expect { user.update_columns(email: user.email.upcase) }.to \
        raise_error(ActiveRecord::StatementInvalid, /email_lower/)
    end

    it 'origial_emailにemailと大文字小文字以外に違う文字列は保存できない' do
      expect { user.update_columns(original_email: 'b@b.b') }.to \
        raise_error(ActiveRecord::StatementInvalid, /email_and_original_email_allow_case_difference/)
    end
  end
end
