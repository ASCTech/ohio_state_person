require 'spec_helper'

describe 'validations' do

  specify { build(:student).should be_valid }
  specify { build(:applicant).should be_valid }

  let(:student)   { create :student }
  let(:applicant) { create :applicant }

  describe 'the name_n field' do
    subject { student }

    it { should validate_uniqueness_of :name_n }
    it { should_not allow_value('gee2').for(:name_n) }
    it { should allow_value('gee.2').for(:name_n) }
  end

  describe 'the emplid field' do
    subject { applicant }

    it { should validate_uniqueness_of :emplid }
    it { should_not allow_value('54321').for(:emplid) }
    it { should allow_value('987654321').for(:emplid) }
  end

  describe 'the id field' do
    subject { student }

    specify { subject.id.should == subject.emplid.to_i }

    context 'with a different emplid' do
      before { subject.emplid = subject.id + 1 }
      specify do
        subject.should_not be_valid
        subject.errors[:id].should == ['must be the same as the emplid']
      end
    end
  end
end
