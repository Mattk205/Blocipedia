class Wiki < ApplicationRecord
  belongs_to :user
  ##default_scope { order('rank DESC') }
end
