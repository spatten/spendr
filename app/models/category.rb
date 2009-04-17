class Category < ActiveRecord::Base
  belongs_to :user
  has_many :expenditures, :dependent => :destroy
  
  def expenditure_sum
    Expenditure.sum(:amount, :conditions => ['category_id = ?', id])
  end
  
  def expenditure_count
    Expenditure.count(:conditions => ['category_id = ?', id])
  end
end
