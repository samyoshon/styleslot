class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :dob
      t.string :citizenship

      t.timestamps null: false
    end
  end
end
