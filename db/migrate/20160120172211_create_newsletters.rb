class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :first_name
      t.string :email

      t.timestamps null: false
    end
  end
end
