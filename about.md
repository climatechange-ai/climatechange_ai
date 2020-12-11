---
title: Climate Change AI - About
description: Climate Change AI is a group of volunteers from academia and industry who believe in using machine learning, where it is relevant, to help tackle the climate crisis.
---

# About Climate Change AI

Climate Change AI (CCAI) is an organization composed of volunteers from academia and industry who believe that tackling climate change requires concerted societal action, in which machine learning can play an impactful role. Since it was founded in June 2019, CCAI has led the creation of a global movement in climate change and machine learning, encompassing researchers, engineers, entrepreneurs, investors, policymakers, companies, and NGOs.

### Our Mission
To catalyze impactful work at the intersection of climate change and machine learning.

### Our Goals
* To build a community of diverse stakeholders.
* To guide impactful work through educational resources and programs.
* To fill gaps in essential infrastructure such as funding, tools, and datasets. 
* To advance discourse and advise relevant players.


# People

{% for grp in site.data.people %}
<h2 id="{{grp.anchor}}">{{grp.group}}</h2>
<div class="person__list">
{% for p in grp.members %}
{% if p.website_url %}
<a class="person__item" href="{{p.website_url}}" target="_blank">
{% else %}
<div class="person__item">
{% endif %}
<div class="person__pic-wrapper">
<img class="person__pic" src="{{p.image_url}}">
</div>
<div class="person__name">{{p.name}}</div>
<div class="person__affil">{{p.affiliation}}</div>
{% if p.website_url %}
</a>
{% else %}
</div>
{% endif %}
{% endfor %}
</div>
{% endfor %}

# Organizational Structure

## CCAI Chairs
- Priya L. Donti
- Lynn H. Kaack
- David Rolnick

## Content Committee
- Sasha Luccioni <em>(Committee Chair)</em>
- Ebude Antem Yolande Ebong
- Lauren Kuntz
- Alexandre Lacoste
- Tegan Maharaj
- Ankur Mahesh
- Geneviève Patterson
- Kris Sankaran
- Isabelle Tingzon
- Marcus Voss

## Communications Committee
- Konstantin Klemmer <em>(Committee Chair)</em>
- Ján Drgoňa
- Jesse Dunietz
- Wei-Wei Lin
- Andrew Ross
- Kris Sankaran
- Katherine Stapleton
- Kasia Tokarska

## Programs Committee
- Evan D. Sherwin <em>(Committee Chair)</em>
- Hari Prasanna Das
- Jessica Fan
- Meareg Hailemariam
- Jeremy Irvin
- Maria João Sousa
- John Kieffer
- Konstantin Klemmer
- Felipe Oviedo
- Yumna Yusuf

## Community Leads
- David Dao <em>(Agriculture, Forestry, and Other Land Use)</em>
- Priya L. Donti <em>(Power Sector)</em>
- Lynn H. Kaack <em>(Public Sector and International Organizations)</em>
- Kelly Kochanski <em>(Climate and Earth Sciences)</em>
- Nikola Milojevic-Dupont <em>(Buildings and Transportation)</em>
- Kelton Minor <em>(Computational Social Sciences)</em>
- David Rolnick <em>(Tech Industry and ML Academia)</em>

## Former Core Team Members
- Natasha Jaques
- Anna Waldman-Brown
- Sharon Zhou

# Press

## Releases
* Nov. 11, 2019: <a href="/press_releases/2019-11-11/release.html" target="_blank">press release</a> and [press packet](/press_releases/2019-11-11/press_packet.zip)

## Selected coverage
* "Not Cool: A Climate Podcast" by the Future of Life Institute: <a href="https://futureoflife.org/2019/10/22/not-cool-ep-16-tackling-climate-change-with-machine-learning-part-1/" target="_blank">Part 1</a> and <a href="https://futureoflife.org/2019/10/24/not-cool-ep-17-tackling-machine-learning-with-climate-change-part-2/" target="_blank">Part 2</a>
* Eye on A.I. podcast: <a href="https://www.eye-on.ai/podcast-024" target="_blank">"Climate Change and AI"</a>
* National Geographic: <a href="https://www.nationalgeographic.com/environment/2019/07/artificial-intelligence-climate-change/" target="_blank">"How artificial intelligence can tackle climate change"</a>
* The Verge: <a href="https://www.theverge.com/2019/6/25/18744034/ai-artificial-intelligence-ml-climate-change-fight-tackle" target="_blank">"Here’s how AI can help fight climate change according to the field’s top thinkers"</a>
* MIT Technology Review: <a href="https://www.technologyreview.com/s/613838/ai-climate-change-machine-learning/" target="_blank">"Here are 10 ways AI could help fight climate change"</a>

