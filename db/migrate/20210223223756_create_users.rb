class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :google_token
      t.string :utility_token
      t.string :password_digest
      t.string :email
      t.string :username
      t.string :address

      t.timestamps
    end
  end
end
