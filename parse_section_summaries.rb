require 'pry'
require 'yaml'
require 'json'

f = "\n"+File.read('section-summaries.txt')

key_dict = {
  '1-2 sentence summary' => 'summary',
  'ML keywords' => 'ml_keywords',
  'Topic keywords' => 'topic_keywords',
  'Thematic keywords' => 'thematic_keywords',
  'Paper flags' => 'paper_flags'
}

data = f.split(/^#/m)[1..-1].map(&:strip).map { |section|
  {
    'title' => section.split("\n")[0].strip,
    'subsections' => section.split(/Title: /m)[1..-1].map(&:strip).map { |sub|
      sub.split("\r\n")[1..-1].each.with_object({
        'title' => sub.split("\r\n")[0].strip
      }) do |line, h|
        key, val = line.split(/:\s*/)
        key = key_dict[key]
        if key == 'summary'
          val = val.strip
        else
          val = val.to_s.split(', ').map(&:strip)
        end
        h[key] = val
      end
    }
  }
}

File.open('section-summaries.json', 'w') do |f|
  f.write(JSON.pretty_generate(data))
end
