class Result < ActiveRecord::Base

  def filler_words(response)
    ["like", "totally", "you know", "basically", "sorta", "sort of", "kinda", "kind of"].collect do |word|
      Response.search(word,
      where: {id: response.id},
      fields: [:transcript],
      misspellings: false,
      highlight: true
      )
    end
  end
end
