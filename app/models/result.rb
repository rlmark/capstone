class Result < ActiveRecord::Base

  def self.transcript_generator(filler_words)
    transcripts = []
    filler_words.each do |word|
      word.with_details.each do |record, detail|
        transcripts.push( detail[:highlight][:transcript] )
      end
    end
    transcripts
  end

  def self.filler_word_counter(transcripts)
    count = []
    transcripts.each do |transcript|
      count << transcript.scan(/<em>/)
    end
    if count.flatten! != nil
      return count.length
    else
      return 0
    end
  end

  def self.search_filler_words(response)
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
