class User < ActiveRecord::Base
  has_many :expenditures, :dependent => :destroy
  has_many :categories, :dependent => :destroy
end
