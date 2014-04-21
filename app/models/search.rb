class Search
  
  def initialize(word)
    @word = word
    @results = {}
  end
  
  def find_results!
    words = Key.find_words_for(@word) || []
    words.each do |w|
      self.score_word(w)
    end
  end
  
  # input is a Word
  def score_word(input)
    score = SearchHelper::edit_dist(@word, input.citation)
    form = nil
    
    # keys are form names, values are forms themselves
    input.forms.each do |k, v|
      dist = SearchHelper::edit_dist(@word, v)
      if dist < score then
        score = dist
        form = k
      end
    end

    @results[input] = [score, form]
  end
  
  def results
    return @results.sort_by {|k, v| v[0]}
  end
  
end