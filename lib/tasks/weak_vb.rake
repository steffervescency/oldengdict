require 'weak_vb'
require 'strong_vb'

namespace :dict do
  
  desc "Reset db"
  task :reset_db => [:clean_db, :add_weak_verbs, :add_strong_verbs] do
  end
    
    
  desc "Add weak verbs to database"
  task :add_weak_verbs => [:environment] do
    file = "lib/dict/weak_vb1.txt"
    File.open(file, "r").each_line do |line|
      line = line.split("\t")
      WeakVerb::add_class1(line[0], line[1])
    end
    
    file = "lib/dict/weak_vb2.txt"
    File.open(file, "r").each_line do |line|
      line = line.split("\t")
      WeakVerb::add_class2(line[0], line[1])
    end
  end
  
  desc "Add strong verbs to database"
  task :add_strong_verbs => [:environment] do
    file = 'lib/dict/strong_vb1.txt'
    File.open(file, "r").each_line do |line|
      line = line.split("\t")
      StrongVerb::add_class1(line[0], line[1])
    end
  end
  
  desc "Clean out database"
  task :clean_db => [:environment] do
    Word.delete_all
    Key.delete_all
  end
  
end 