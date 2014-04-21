class Key < ActiveRecord::Base
  has_and_belongs_to_many :words
  
  # Return or create the key for a given form
  def self.key_for(word)
    k = Key.calculate_key(word)
    return Key.find_or_create_by_val(k)
  end
  
  # Calculate the key for a given form
  def self.calculate_key(word)
    # clean off diacritics
    word = SearchHelper::clean_input(word)
    
    # remove leading 'ge'
    word = word.gsub(/^ge/, '')
    
    # substitute k for c
    word = word.gsub('k', 'c')
    
    # sc, cs -> x
    word = word.gsub('sc', 'x')
    word = word.gsub('cs', 'x')
    
    # only one nasal
    word = word.gsub('m', 'n')
    
    # make all dentals into t
    word = word.gsub(/[0d]/, 't')
    
    # remove non-leading h, g
    word = word.gsub('h', '')
    word = word.gsub(/(?<pre>.)g/, '\k<pre>')
    
    # remove vowels
    word = word.gsub(/[aieuoy1]/, '')
    
    return word
  end
  
  def self.find_words_for(word)
    k = Key.find_by_val(Key.calculate_key(word))
    return k if k.nil?
    return k.words
  end
  
end
