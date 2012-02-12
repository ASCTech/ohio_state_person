require 'spec_helper'

describe 'callbacks' do
  let(:student) { create :student, :emplid => 87654321 }

  it 'should set id to emplid.to_i' do
    student.id.should == 87654321
  end
end
