module SearchHelper
  
  # list of possible correspondences (mainly from Baker)
  CORRESPONDENCES = {
    "ea"=>["a", "e"],
    "a"=>["ea", "o"], 
    "o"=>["a"],
    "eo"=>["e", "io", "u", "i", "ie", "y"],
    "e"=>["eo", "y", "ea", "i", "ie"],
    "y"=>["e", "i", "ie", "eo", "io"],
    "io"=>["eo", "i", "ie", "y"],
    "u"=>["eo"],
    "i"=>["eo", "io", "y", "ie", "e"],
    "ie"=>["i", "y", "eo", "io", "e"],
    "mm"=>["fn"],
    "fn"=>["mm", "mn"],
    "mn"=>["fn"],
    "k"=>["c"],
    "c"=>["k"],
    "g"=>["h"],
    "h"=>["g"],
    "x"=>["sc"],
    "sc"=>["x"],
    "d"=>["t"],
    "t"=>["d", "0"],
    "0"=>["t"]} 
    
    
  
  # Clean off diacritics and special characters
  def self.clean_input(word)
    # standardize eth/thorn and ash
    word = word.gsub(/[þð]/, "0")
    word = word.gsub(/æ/, "1")
    
    # lowercase
    word = word.downcase
    
    # remove diacritics and any other unicode cruft that sneaks in
    word = word.mb_chars.normalize(:kd).gsub(/[^x00-\x7F]/, '').to_s
  end



  # Group consonants and vowels together
  # Ex: input "hierden", output ["h", "ie", "rd", "e", "n"]
  def self.split_input(word)
    return self.clean_input(word).split(/(?<c>[qwrtpsdfghjklzxcvbnm0]+)|(?<v>[aeiuoy1]+)/).reject(&:empty?)
  end
  
  
  # Match one "block" from the above function against another
  # For example, "ie" vs "y" or "cg" vs "g"
  def self.score_block(w1, w2)
    
    if w1 == w2 # exact match
      return 0
    elsif CORRESPONDENCES[w1] and CORRESPONDENCES[w1].include?(w2) # accepted correspondence
      return 1
    elsif w1.length == 2 and w2.length == 1 and w1[0] == w1[1] and w1[0] == w2[0] # duplicated consonant
      return 1
    elsif w1 =~ /^[aiuoye1]$/ and w2 =~ /^[aiuoye1]$/ # mismtached vowel sequences
      return 2
    elsif w2.split("").any?{|x| w1.include?(x)} # consonant sequences with at least one match
      return 2
    end
    
    return 4  # non-match
  end


  # Calculate the edit distance between two words
  # using modified Levenshtein algorithm
  def self.edit_dist(w1, w2)
    s1 = split_input(w1)
    s2 = split_input(w2)
    s1, s2 = s2, s1 if s2.length > s1.length #s1 should be longer
    
    matrix = [(0..s1.length).to_a]
    
    (1..s2.length).each do |j|
      matrix << [j] + [0] * (s1.length)
    end
    
    (1..s2.length).each do |i|
      (1..s1.length).each do |j|
        d = self.score_block(s1[j-1], s2[i-1])
        matrix[i][j] = [matrix[i-1][j-1] + d, matrix[i-1][j] + d, matrix[i][j-1] + d].min
      end
    end
    
    return matrix.last.last
  end

end
