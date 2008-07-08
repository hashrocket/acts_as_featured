require 'acts_as_featured'
ActiveRecord::Base.send :include, Hashrocket::Acts::Featured
