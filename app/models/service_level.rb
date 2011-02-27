class ServiceLevel < ActiveRecord::Base
  has_and_belongs_to_many :institutions
  has_and_belongs_to_many :segments
  has_many :users
  named_scope :infantil, :conditions => "name IN ('Creche','EMEI')"
  named_scope :fundamental, :conditions => "name = 'EMEF'"

  def to_s
    name
  end

end

