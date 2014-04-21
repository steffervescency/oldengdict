class Word < ActiveRecord::Base
  has_and_belongs_to_many :keys
  serialize :forms
  
  # Generate a new word along with its keys
  def self.word_with_keys(citation, eng, forms, pos)
    w = Word.new(:citation => citation, :eng => eng, :pos => pos, :forms => forms)
    
    keys = []
    forms.each do |k, v|
      keys << Key.key_for(v)
    end
    
    w.keys = keys.uniq
    w.save
    return w
  end
  
end
