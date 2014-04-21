class StrongVerb
  
  def self.add_class1(input, eng)
    forms = {}
    
    # Generate principle parts
    
    pp1 = input.gsub(/an$/, '') # chop off the -an from the infinitive
    
    pp2 = pp1.gsub(/ī/, 'ā')
    
    pp3 = pp1.gsub(/ī/, 'i')
    
    pp4 = pp1 # 4th principle part has the same vowel as 1st
    
    # Add -an for infinitive
    inf = pp1 + 'an'
    
    # Deal with "proto" forms
    inf = inf.gsub('īha', 'ēo')
    
    forms[:pres_1] = pp1 + 'e'
    forms[:pres_2] = pp1 + 'st'
    forms[:pres_3] = pp1 + 'ð'
    forms[:pres_pl] = pp1 + 'að'
    
    forms[:past_1] = pp2
    forms[:past_2] = pp3 + 'e'
    forms[:past_3] = pp2
    forms[:past_pl] = pp3 + 'on'
    
    forms[:pres_subj_sg] = pp1 + 'e'
    forms[:pres_subj_pl] = pp1 + 'en'
    
    forms[:past_subj_sg] = pp3 + 'e'
    forms[:past_subj_pl] = pp3 + 'en'
    
    forms[:imp_sg] = pp1
    forms[:imp_pl] = pp1 + 'að'
    
    # Strong verbs don't always have ge-, but fuzzy search will take care of it
    forms[:part_past] = 'ge' + pp4 + 'en'
    forms[:part_pres] = pp1 + 'nde'
    
    # apply phonological rules
    # (some of these don't have an exact linguistic basis,
    #  but they get to the right surface forms)
    
    forms.each do |k, v|
      # verner's law
      v = v.gsub(/(?<v1>[īāēōȳaeiuoyæǣū])h(?<v2>[īāēōȳaeiuoyæǣū])/, '\k<v1>g\k<v2>')
      
      # insert an 'e' before h word-finally or followed by 'st', 'ð', or 'nd'
      v = v.gsub(/(?<i>ī)(?<h>h(st|ð|nd|$))/, '\k<i>e\k<h>')
       
      # reduce h + nd to nd
      v = v.gsub("hnd", "nd") 
      
      # add an -e before non-h consonants for certain suffixes
      v = v.gsub(/(?<c>[qwrtpsdfgjklzxcvbnmð])(?<suf>st|ð|nde)$/, '\k<c>e\k<suf>')
      
      forms[k] = v
    end
    
    forms[:inflect_inf] = inf + 'ne'
    
    Word.word_with_keys(inf, eng, forms, "verb")
  end
  
end