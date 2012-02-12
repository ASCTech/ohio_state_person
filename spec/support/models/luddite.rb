ActiveRecord::Base.connection.create_table :luddites, :force => true do |table|
  table.column :first_name, :string
  table.column :last_name, :string
end

class Luddite < ActiveRecord::Base
  is_a_buckeye
end
