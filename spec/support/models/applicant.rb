ActiveRecord::Base.connection.create_table :applicants, :force => true do |table|
  table.column :emplid, :string
  table.column :first_name, :string
  table.column :last_name, :string
end

class Applicant < ActiveRecord::Base
  is_a_buckeye
end
