class Markus

  def self.word_pairs
    @@word_pairs ||= self.build_word_pairs
  end

  def self.all_words
    @@words ||= self.word_pairs.keys
  end

  def self.build_word_pairs
    sentence_pattern = /[^.]+\.\s+/
    allowable_pattern = /\A[A-Za-z\.,\-\(\);: ]+\z/
    corpus = IO.binread(Rails.root.join('markus.txt')) + ' '

    sentences = corpus
      .scan(sentence_pattern)
      .select{|p| allowable_pattern.match(p) }
      .map{|p| p.tr('^A-Za-z ', '') }

    word_pairs = {}

    sentences.each do |sentence|
      words = sentence.split(/\s+/)
      words.each_with_index do |word, index|
        next_word = words[index + 1]

        unless word_pairs[word]
          word_pairs[word] = []
        end

        if next_word
          word_pairs[word] << next_word
        end
      end
    end

    word_pairs
  end

  def self.debug
    self.build_sentence
  end

  def self.title(min, max)
    assembled = []

    while assembled.length < min
      assembled += self.build_chain
    end

    assembled.take(max).join(' ').humanize
  end

  def self.paragraph(min, max)
    target = rand(min..max)
    target.times.map{ self.sentence }.join(' ')
  end

  def self.sentence
    self.build_chain.join(' ').humanize + '.'
  end

  def self.build_chain
    previous_word = self.all_words.sample
    chain = [previous_word]

    while (chain.length < 30)
      next_word = self.word_pairs[previous_word].sample
      break unless next_word

      chain << next_word
      previous_word = next_word
    end

    chain
  end

end