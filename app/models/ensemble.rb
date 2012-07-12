class Ensemble < ActiveRecord::Base

  include Overrides

  extend SimpleSearch
  SEARCH_INCLUDES = %w{ }
  SEARCH_FIELDS = %w{ ensembles.notes ensembles.created_at ensembles.updated_at }

  has_many :runs

  named_scope :order, lambda { |order| {:order => order, :include => SEARCH_INCLUDES } }
  named_scope :search, lambda { |search| {:conditions => simple_search(search) } } 

  comma do
    id
    notes
    created_at
    updated_at
  end

  def to_s
    notes[0..20]
  end
  def select_default
    "#{id}: #{self}"
  end

  #Columns we search when referenced from another model
  #Fields present in 'select_default'
  def self.search_columns
    return ["ensembles.id", "ensembles.notes"]
  end

end
