class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true, name: 'email_unique' }
      t.string :original_email, null: false
      t.string :password_digest, null: false

      t.timestamps

      t.check_constraint "name !~ '^ *$'", name: "name_present"
      t.check_constraint "char_length(name) <= 50", name: "name_length"
      t.check_constraint "char_length(email) <= 255", name: "email_length"
      t.check_constraint "email ~* '^#{User::EMAIL_REGEXP_STR}$'", name: "email_format"
      t.check_constraint "email = LOWER(email)", name: "email_lower"
      t.check_constraint "LOWER(email) = LOWER(original_email)", name: "email_and_original_email_allow_case_difference"
      t.check_constraint "password_digest  !~ '^ *$'", name: 'password_digest_present'
    end
  end
end
