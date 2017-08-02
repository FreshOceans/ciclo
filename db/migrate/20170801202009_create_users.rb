class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :username
      t.string :password
      t.string :img_src

      t.timestamps
    end
  end
end

# < ======= firstname, lastname, email, username, password, img_src ======= >
