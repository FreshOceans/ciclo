class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
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

# < ======= fname, lname, email, username, password, img_src ======= >
