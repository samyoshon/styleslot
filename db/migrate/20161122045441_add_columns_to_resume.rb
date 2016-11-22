class AddColumnsToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :expertise, :string
    add_column :resumes, :experience, :integer
    add_column :resumes, :residence, :string
    add_column :resumes, :education, :string
    add_column :resumes, :skills, :string
    add_column :resumes, :languages, :string
    add_column :resumes, :facebook, :string
    add_column :resumes, :linkedin, :string
    add_column :resumes, :description, :string
    add_column :resumes, :countrya, :string
    add_column :resumes, :countryb, :string
    add_column :resumes, :countryc, :string
  end
end
