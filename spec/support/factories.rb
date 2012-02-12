FactoryGirl.define do
  sequence :emplid do |n|
    '%08d' % n
  end
  sequence :name_n do |n|
    "buckeye.#{n}"
  end

  factory :student do
    first_name 'Brutus'
    last_name  'Buckeye'
    name_n
    emplid
  end

  factory :applicant do
    first_name 'Brutus'
    last_name  'Buckeye'
    email      'brutus_buckeye@gmail.com'
    emplid
  end

  factory :luddite do
    first_name 'Some'
    last_name  'Guy'
  end
end
