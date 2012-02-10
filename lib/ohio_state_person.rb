require "ohio_state_person/version"

module OhioStatePerson

  module ModelAdditions
    def is_a_buckeye
      extend ClassMethods
      include InstanceMethods

      if column_names.include? 'name_n'
        validates_uniqueness_of :name_n
        validates_format_of :name_n, :with => /\A[a-z]([a-z-]*[a-z])?\.[1-9]\d*\z/, :message => 'must be in format: name.#'
      end

      validates_uniqueness_of :emplid
      validates_format_of :emplid, :with => /\A\d{8,9}\z/, :message => 'must be 8 or 9 digits'

      before_validation :set_id, :on => :create
      validate :id_is_emplid
    end
  end

  module ClassMethods
    def search(q)
      q = q.to_s
      h = ActiveSupport::OrderedHash.new
      h[/\A\d+\z/]        = lambda { where('emplid LIKE ?', "#{q}%").order('emplid ASC') }
      h[/\A\D+\.\d*\z/]   = lambda { where('name_n LIKE ?', "#{q}%") } if column_names.include? 'name_n'
      h[/(\S+),\s*(\S*)/] = lambda { where('last_name LIKE ? AND first_name LIKE ?', $1, "#{$2}%") }
      h[/(\S+)\s+(\S*)/]  = lambda { where('first_name LIKE ? AND last_name LIKE ?', $1, "#{$2}%") }
      h[/\S/]             = lambda { where('last_name LIKE ?', "#{q}%") }
      h[//]               = lambda { where('1=2') }

      h.each do |regex, where_clause|
        return where_clause.call if q =~ regex
      end

    end
  end

  module InstanceMethods
    def email
      return self[:email] if self.class.column_names.include? 'email'
      return nil      unless self.class.column_names.include? 'name_n'
      name_n.present? ? "#{name_n}@osu.edu" : ''
    end

    protected
    def set_id
      self.id = self.emplid.to_i
    end

    def id_is_emplid
      unless self.id == self.emplid.to_i
        errors.add(:id, 'must be the same as the emplid')
      end
    end
  end

end

::ActiveRecord::Base.send :extend, OhioStatePerson::ModelAdditions
