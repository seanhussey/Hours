# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require "spec_helper"

describe Project do
  let(:project) { create(:project) }

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe "associations" do
    it { should have_many :users }
    it { should have_many :categories }
    it { should have_many :entries }
    it { should have_many :tags }
  end

  describe "#label" do
    it "returns the projects name" do
      project = create(:project, name: "ProjectAwesome")
      expect(project.label).to eq("ProjectAwesome")
    end
  end

  describe "#by_last_updated" do
    it "orders the projects by last updated first" do
      create(:project)
      project = create(:project)
      create(:project)
      project.touch

      expect(Project.by_last_updated.first).to eq(project)
    end
  end

  describe "#by_name" do
    it "orders by name case insensitive" do
      create(:project, name: "B")
      a = create(:project, name: "a")
      expect(Project.by_name.first).to eq(a)
    end
  end

  describe "#budget" do
    it "can have a budget" do
      project = create(:project, name: "on a tight budget", budget: 10)
      expect(project.budget).to eq(10)
    end
  end
end
