require 'json'

# ensure there is a blank line at the start of this text file
f = "\n\n"+File.read('section-summaries.txt')

key_dict = {
  '1-2 sentence summary' => 'summary',
  'ML keywords' => 'ml_keywords',
  'Topic keywords' => 'topic_keywords',
  'Thematic keywords' => 'thematic_keywords',
  'Paper flags' => 'paper_flags',
  'Section number' => 'section_number'
}

data = f.split(/^#/m)[1..-1].map(&:strip).map { |section|
  {
    'title' => section.split("\n")[0].strip.gsub(/^#\s+/,''),
    'subsections' => section.split(/Title: /m)[1..-1].map(&:strip).map { |sub|
      sub.split("\r\n")[1..-1].each.with_object({
        'title' => sub.split("\r\n")[0].strip
      }) do |line, h|
        key, val = line.split(/:\s*/)
        next unless key
        key = key_dict.fetch(key.strip, key.strip.downcase.gsub(/\s+/, '_'))
        if key.include?('_keywords') || key.include?('_flags')
          val = val.to_s.split(', ').map(&:strip)
        else
          val = val.to_s.strip
        end
        h[key] = val
      end
    }
  }
}

data.each do |section|
  section['subsections'].each do |sub|
    key_dict.values.each do |key|
      unless sub.keys.include?(key)
        puts "WARNING: '#{section['title']} > #{sub['title']}' missing #{key}"
      end
    end
  end
end

File.open('section-summaries.json', 'w') do |f|
  f.write(JSON.pretty_generate(data))
end
