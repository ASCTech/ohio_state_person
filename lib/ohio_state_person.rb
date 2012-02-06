require "ohio_state_person/version"

module OhioStatePerson

  module ModelAdditions
    def is_a_buckeye
      extend ClassMethods
      include InstanceMethods

      validates_uniqueness_of :name_n
      validates_format_of :name_n, :with => /\A[a-z]([a-z-]*[a-z])?\.[1-9]\d*\z/, :message => 'must be in format: name.#'

      validates_uniqueness_of :emplid
      validates_format_of :emplid, :with => /\A\d{8,9}\z/, :message => 'must be 8 or 9 digits'

      before_validation :set_id, :on => :create
      validate :id_is_emplid
    end
  end

  module ClassMethods
    def search(q)
      q.strip! if q
      h = ActiveSupport::OrderedHash.new
      h[/\A\d+\z/] = where(:emplid => q)
      h[/\A\D+\.\d+\z/] = where(:name_n => q)
      h[/(\S+),\s*(\S+)/] = where('last_name LIKE ? AND first_name LIKE ?', $1, "#{$2}%")
      h[/(\S+)\s+(\S+)/] = where('first_name LIKE ? AND last_name LIKE ?', $1, "#{$2}%")
      h[/\S/] = where('last_name LIKE ?', "#{q}%")
      h[nil] = where('1=2')

      h.each do |regex, where_clause|
        if regex.nil? or q =~ regex
          return where_clause
        end
      end

    end
  end

  module InstanceMethods
    def email
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
