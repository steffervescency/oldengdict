class WeakVerb
  
  def self.add_class1(citation, eng)
    base = citation.gsub(/an$/, '')
    forms = {}
    
    forms[:pres_1] = base + 'e'
    forms[:pres_2] = base + 'st'
    forms[:pres_3] = base + 'ð'
    forms[:pres_pl] = base + 'að'
    
    forms[:past_1] = base + 'de'
    forms[:past_2] = base + 'dest'
    forms[:past_3] = base + 'de'
    forms[:past_pl] = base + 'don'
    
    forms[:pres_subj_sg] = base + 'e'
    forms[:pres_subj_pl] = base + 'en'
    
    forms[:past_subj_sg] = base + 'de'
    forms[:past_subj_pl] = base + 'den'
    
    forms[:imp_sg] = base
    forms[:imp_pl] = base + 'að'
    
    forms[:part_past] = 'ge' + base + 'ed'
    forms[:part_pres] = base + 'ende'
    forms[:inflect_inf] = base + 'enne'
    
    # apply phonological rules
    forms.each do |k, v|
      # word-final dst -> tst
      v = v.gsub('dst', 'tst')
      
      # word-final t or d followed by ð -> tt
      v = v.gsub(/[td]ð/, 'tt')
      
      forms[k] = v
    end
    
    Word.word_with_keys(citation, eng, forms, "verb")
  end
  
  
  def self.add_class2(citation, eng)
    base = citation.gsub(/ian$/, '')
    forms = {}
    
    forms[:pres_1] = base + 'ie'
    forms[:pres_2] = base + 'ast'
    forms[:pres_3] = base + 'að'
    forms[:pres_pl] = base + 'iað'
    
    forms[:past_1] = base + 'ode'
    forms[:past_2] = base + 'odest'
    forms[:past_3] = base + 'ode'
    forms[:past_pl] = base + 'odon'
    
    forms[:pres_subj_sg] = base + 'ie'
    forms[:pres_subj_pl] = base + 'ien'
    
    forms[:past_subj_sg] = base + 'ode'
    forms[:past_subj_pl] = base + 'oden'
    
    forms[:imp_sg] = base + 'a'
    forms[:imp_pl] = base + 'iað'
    
    forms[:part_past] = 'ge' + base + 'od'
    forms[:part_pres] = base + 'iende'
    forms[:inflect_inf] = base + 'ianne'
    
    Word.word_with_keys(citation, eng, forms, "verb")
  end
  
end