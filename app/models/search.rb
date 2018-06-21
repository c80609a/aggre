class Search
  SUBJS = %w(Offers Categories)

  def self.find(query, subj)
    secure_query = ThinkingSphinx::Query.escape query
    if SUBJS.include?(subj)
      model = subj.singularize.classify.constantize
      model.search secure_query
    else
      ThinkingSphinx.search secure_query
    end
  end
end
