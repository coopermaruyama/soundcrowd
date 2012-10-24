module MyActiveRecordExtensions

  extend ActiveSupport::Concern

  # add your instance methods here
  module ClassMethods
    def random
      if (c = count) != 0
        find(:first, :offset =>rand(c))
      end
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, MyActiveRecordExtensions)