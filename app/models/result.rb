class Result < ActiveRecord::Base

  def self.search_talking_points(talking_points, response)
    talking_points.collect do |point|
      Response.search( point.phrase,
      where: {id: response.id},
      fields: [:transcript],
      highlight: true
      )
    end
  end

  def self.transcript_generator(filler_words)
    transcripts = []
    filler_words.each do |word|
      if word.hits == []
        transcripts << ""
      else
        word.with_details.each do |record, detail|
          transcripts.push( detail[:highlight][:transcript].html_safe )
        end
      end
    end
    transcripts
  end

  # def self.filler_word_counter(transcripts)
  #   count = []
  #   transcripts.each do |transcript|
  #     count << transcript.scan(/<em>/)
  #   end
  #   if count.flatten! != nil
  #     return count.length
  #   else
  #     return 0
  #   end
  # end

  def self.filler_word_counter(transcript)
    word_hash = {}
    filler_word_list.collect do |word|
      word_hash[word] = transcript.scan(word).length
    end
    word_hash
  end

  def self.search_filler_words(response)
    filler_word_list.collect do |word|
      Response.search(word,
      where: {id: response.id},
      fields: [:transcript],
      misspellings: false,
      highlight: true
      )
    end
  end

  def self.filler_word_list
    ["like", "totally", "you know", "basically", "sorta", "sort of", "kinda", "kind of"]
  end
end
