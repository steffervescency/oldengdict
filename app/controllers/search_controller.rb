class SearchController < ApplicationController
  
  def find
    @word = params[:word]
    search = Search.new(@word)
    search.find_results!
    @results = search.results
  end
  
  def findpde
    @word = params[:word]
    res = Word.all( :conditions => ["eng LIKE ?", "%#{@word}%"]) || []
    
    # hackish way to fill up the results array - no score or form
    # for PDE searches
    @results = Hash.new {|h, k| h[k] = [100, nil]}
    res.each {|r| @results[r] }
    render :find
  end
  
  def index 
    render :find
  end
  
end
