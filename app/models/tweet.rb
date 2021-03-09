class Tweet < ActiveRecord::Base
  include Slugs::InstanceMethods
  extend Slugs::ClassMethods

  belongs_to :user
end
