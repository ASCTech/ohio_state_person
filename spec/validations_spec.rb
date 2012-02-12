require 'spec_helper'

describe 'validations' do

  specify { build(:student).should be_valid }
  specify { build(:applicant).should be_valid }

  let(:student)   { create :student }
  let(:applicant) { create :applicant }

  describe 'the name_n field' do
    subject { student }

    it { should validate_uniqueness_of :name_n }
    it { should validate_format_of(:name_n).not_with('gee2').
           with_message(/must be in format: name.#/) }
    it { should validate_format_of(:name_n).with('gee.2').
           with_message(/must be in format: name.#/) }
  end

  describe 'the emplid field' do
    subject { applicant }

    it { should validate_uniqueness_of :emplid }
    it { should validate_format_of(:emplid).not_with('54321').
           with_message(/must be 8 or 9 digits/) }
    it { should validate_format_of(:emplid).with('987654321').
           with_message(/must be 8 or 9 digits/) }
  end

  describe 'the id field' do
    subject { student }

    specify { subject.id.should == subject.emplid.to_i }
  end
end
