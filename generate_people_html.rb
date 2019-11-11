require 'json'

# This file regenerates the about/people page html using the data encoded in `people.json`.
# To use, run `ruby generate_people_html.rb > about.md`

people = JSON.parse(File.read('people.json'))

steering = people.select { |p| p['committees'].include? 'steering' }
advisory = people.select { |p| p['committees'].include? 'advisory' }

def to_html(p)
  <<-HTML
<a class="person__item" href="#{p['website_url']}" target="_blank">
  <div class="person__pic-wrapper">
    <img class="person__pic" src="#{p['image_url'].split(".")[0]}_200x200.jpg">
  </div>
  <div class="person__name">#{p['name']}</div>
  <div class="person__affil">#{p['affiliation']}</div>
  <div class="person__title">#{p['title']}</div>
</a>
  HTML
end

puts <<-HTML
---
title: Climate Change AI - About
description: Climate Change AI is a group of volunteers from academia and industry who believe in using machine learning, where it is relevant, to help tackle the climate crisis.
---

# About Climate Change AI

Climate Change AI is a group of volunteers from academia and industry who believe in using machine learning, where it is relevant, to help tackle the climate crisis.  We aim to facilitate meaningful action by a range of stakeholders &mdash; researchers and engineers, entrepreneurs and investors, established businesses, the public sector, and more.

We believe that:
* **There are many ways to have an impact:** The diversity of problems posed by climate change can be seen as an opportunity; there are many ways to have an impact.
* **AI is a powerful tool:** AI and ML can enable or accelerate many strategies to address climate change. That said, it is not a silver bullet.
* **Collaboration is key:** Effective solutions require cooperation between AI/ML experts and other stakeholders working in areas relevant to climate change.

## Our Vision
A world where effective climate change mitigation and robust adaptation strategies are deployed for the benefit of all.

## Our Mission
To empower solutions that meaningfully address the climate crisis and are well-served by machine learning tools.

## Our Goals

* To facilitate work at the intersection of climate change and machine learning through resource- and knowledge-sharing.
* To enable impactful collaborations by connecting machine learning experts and experts working in areas relevant to climate change through physical and digital platforms.
* To promote discourse about best practices regarding the use of machine learning in climate change domains.

# People

## Steering Committee

<div class="person__list">
HTML

puts steering.map { |p| to_html(p) }.join("\n")

puts <<-HTML
</div>
## Advisors
<div class="person__list">
HTML

puts advisory.map { |p| to_html(p) }.join("\n")

puts "</div>"

puts <<-HTML

# Press

## Releases
* Nov. 11, 2019: <a href="/press_releases/2019-11-11/release.html" target="_blank">press release</a> and [press packet](/press_releases/2019-11-11/press_packet.zip)

## Selected coverage
* "Not Cool: A Climate Podcast" by the Future of Life Institute: <a href="https://futureoflife.org/2019/10/22/not-cool-ep-16-tackling-climate-change-with-machine-learning-part-1/" target="_blank">Part 1</a> and <a href="https://futureoflife.org/2019/10/24/not-cool-ep-17-tackling-machine-learning-with-climate-change-part-2/" target="_blank">Part 2</a>
* Eye on A.I. podcast: <a href="https://www.eye-on.ai/podcast-024" target="_blank">"Climate Change and AI"</a>
* National Geographic: <a href="https://www.nationalgeographic.com/environment/2019/07/artificial-intelligence-climate-change/" target="_blank">"How artificial intelligence can tackle climate change"</a>
* The Verge: <a href="https://www.theverge.com/2019/6/25/18744034/ai-artificial-intelligence-ml-climate-change-fight-tackle" target="_blank">"Here’s how AI can help fight climate change according to the field’s top thinkers"</a>
* MIT Technology Review: <a href="https://www.technologyreview.com/s/613838/ai-climate-change-machine-learning/" target="_blank">"Here are 10 ways AI could help fight climate change"</a>

HTML
