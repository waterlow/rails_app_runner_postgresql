# frozen_string_literal: true

class User < ApplicationRecord
  # DBのcheck制約とvalidationで共通
  EMAIL_REGEXP_STR = '[a-z_0-9+-.]+@[.a-z0-9-]+[.]{1}[a-z]+'

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A#{EMAIL_REGEXP_STR}\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  before_save do
    self.original_email = email
    self.email = email.downcase
  end
end
