class CreateRemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    create_table :remove_columns_from_users do |t|
      t.string :expertise
      t.integer :experience
      t.string :residence
      t.string :education
      t.string :skills
      t.string :languages
      t.string :facebook
      t.string :linkedin
      t.string :description
      t.string :countrya
      t.string :countryb
      t.string :countryc

      t.timestamps null: false
    end
  end
end
