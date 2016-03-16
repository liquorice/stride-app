class LibLib
  class << self

    @@patterns = {}
    @@parts = {}

    def name
      build(:name)
    end

    def sentence(*pattern_names)
      build(pattern_names.sample.to_s).humanize + '.'
    end

    def sentences(count, *pattern_names)
      count = count.to_a.sample if count.instance_of? Range
      count.times.map{ sentence(*pattern_names) }.join(' ')
    end

    def paragraphs(count, *pattern_names)
      count = count.to_a.sample if count.instance_of? Range
      count.times.map{ sentences(1..10, *pattern_names) }.join("\n\n")
    end

    private

    # Assembly

    def build(pattern_name)
      pattern = pick_pattern(pattern_name)
    end

    # Patterns

    def pick_pattern(name)
      pattern_data = @@patterns[name] || load_pattern_data(name)
      parse_pattern(pattern_data.sample)
    end

    def load_pattern_data(name)
      IO.binread(Rails.root.join('lib', 'classes', 'liblib', 'patterns', "#{name}.txt")).split("\n")
    end

    # Parts

    def parse_pattern(pattern)
      pattern.gsub(/\$([a-zA-Z_])+/){|match| pick_part(match.slice(1..-1))}
    end

    def pick_part(name)
      part_data = @@parts[name] || load_part_data(name)
      part_data.sample
    end

    def load_part_data(name)
      IO.binread(Rails.root.join('lib', 'classes', 'liblib', 'parts', "#{name}.txt")).split("\n")
    end

  end
end