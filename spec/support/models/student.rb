ActiveRecord::Base.connection.create_table :students, :force => true do |table|
  table.column :emplid, :string
  table.column :name_n, :string
  table.column :first_name, :string
  table.column :last_name, :string
end

class Student < ActiveRecord::Base
  is_a_buckeye
end
