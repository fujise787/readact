class ChangeEmailPwDefaultOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :email, ""
    change_column_default :users, :encrypted_password, ""
  end
end
