require 'spec_helper'

describe 'the search method' do

  before(:all) do
    Student.delete_all
    @student = create :student,
                      :first_name => 'Brutus',
                      :last_name  => 'Buckeye',
                      :name_n     => 'buckeye.11',
                      :emplid     => '18181818'
  end

  it "should return no results given a blank search" do
    Student.search(nil).should == []
    Student.search('').should == []
  end

  it "should return exact matches on emplid" do
    Student.search(18181818).should == [@student]
    Student.search(1818).should == []
  end

  it "should return exact matches on name_n" do
    Student.search('buckeye.11').should == [@student]
    Student.search('buckeye.1').should == []
  end

  it "should return fuzzy matches on emplid" do
    Student.search(18181818, :fuzzy => true).should == [@student]
    Student.search(1818,     :fuzzy => true).should == [@student]
  end

  it "should return fuzzy matches on name_n" do
    Student.search('buckeye.11', :fuzzy => true).should == [@student]
    Student.search('buckeye.1',  :fuzzy => true).should == [@student]
  end

  it "should not give results on first name only" do
    Student.search('Brutus').should == []
    Student.search('Brut').should == []
  end

  it "should give results on last name only" do
    Student.search('Buckeye').should == [@student]
    Student.search('Buck').should == [@student]
  end

  it "should give results for full name" do
    Student.search('Brutus Buckeye').should == [@student]
    Student.search('Brutus Bu').should == [@student]
  end

  it "should ignore case" do
    Student.search('BUCKEYE').should == [@student]
    Student.search('buckeye').should == [@student]
  end

  it "should return multiple results sorted by name_n" do
    other_buckeye = create :student,
                           :first_name => 'Derpina',
                           :last_name  => 'Buckeye',
                           :name_n     => 'buckeye.99'
    Student.search('buckeye').order('name_n').should == [@student, other_buckeye]
    other_buckeye.destroy
  end

  it "should match on last name, first name" do
    Student.search('Buckeye, Brutus').should == [@student]
  end

  it "should ignore case on last name, first name" do
    Student.search('BUCKEYE, BRUTUS').should == [@student]
  end

  it "should partially match on last name, first name" do
    Student.search('Buckeye, Brut').should == [@student]
  end

  it "should ignore beginning and trailing whitespace" do
    Student.search('18181818 ').should == [@student]
    Student.search(' 18181818').should == [@student]
  end

end
