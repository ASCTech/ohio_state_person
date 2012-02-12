require 'spec_helper'

describe 'email helper method' do

  context 'a model with neither email nor name_n fileds' do
    subject { build :luddite }
    its(:email) { should be_nil }
  end

  context 'a model with an email field' do
    subject { build :applicant, :email => 'email@address' }
    its(:email) { should == 'email@address' }
  end

  context 'a model with a name_n field' do
    subject { build :student, :name_n => 'student.1' }
    its(:email) { should == 'student.1@osu.edu' }
  end
end
