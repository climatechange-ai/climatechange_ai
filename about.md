---
title: Climate Change AI - About
description: Climate Change AI is a group of volunteers from academia and industry who believe in using machine learning, where it is relevant, to help tackle the climate crisis.
---

# About Climate Change AI

Climate Change AI (CCAI) is an organization composed of volunteers from academia and industry who believe that tackling climate change requires concerted societal action, in which machine learning can play an impactful role. Since it was founded in June 2019, CCAI has led the creation of a global movement in climate change and machine learning, encompassing researchers, engineers, entrepreneurs, investors, policymakers, companies, and NGOs.

### Our Mission
To catalyze impactful work at the intersection of climate change and machine learning.

### Our Goals
* **Community:** To build a community of diverse stakeholders.
* **Education:** To guide impactful work through educational resources and programs.
* **Infrastructure:** To fill gaps in essential infrastructure such as funding, tools, and datasets.
* **Discourse:** To advance discourse and advise relevant players.

### Our Guiding Principles
* **On climate change:** Climate change is a pressing issue with major implications for societal well-being, particularly for the world’s most disadvantaged populations. Addressing climate change requires rapid, sustained, equitable, and scientifically informed efforts in both mitigation and adaptation, in conjunction with relevant stakeholders.
* **On machine learning:** Machine learning is a powerful tool with wide applicability in many technological and societal applications (both positive and negative), and should be practiced in a manner consistent with its strengths, weaknesses, and limitations, as well as with climate change goals (considering both its applications and its emissions footprint).
* **On machine learning for climate change:** Machine learning can play an impactful role in many broader strategies for reducing and responding to climate change. At the same time, machine learning is not a silver bullet, and should serve to supplement (rather than divert attention from) other impactful actions to address climate change.
* **On diversity, inclusion, and equity:** Diversity, inclusion, and equity are central to the advancement of society in general, and moreover fundamental to progress in addressing climate change. Where possible, it is important that work in climate change and machine learning attempt to address the structural inequities that exist in today’s society.



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
{% if p.roles %}
<div class="person__role">{{p.roles | join: ";<br>"}}</div>
{% endif %}
{% if p.website_url %}
</a>
{% else %}
</div>
{% endif %}
{% endfor %}
</div>
{% endfor %}

## Former Core Team Members
- Ebude Antem Yolande Ebong
- Natasha Jaques
- Kelly Kochanski
- Alexandre Lacoste
- Wei-Wei Lin
- Kris Sankaran
- Anna Waldman-Brown
- Sharon Zhou

# Press

## Releases
* MIT Technology Review 35 Under 35 awards (Jun. 30, 2021): <a href="/press_releases/2021-06-30/release.html" target="_blank">press release</a>
* CCAI paper (Nov. 11, 2019): <a href="/press_releases/2019-11-11/release.html" target="_blank">press release</a> and [press packet](/press_releases/2019-11-11/press_packet.zip)

## Selected articles
* <b>The Economist Intelligence Unit:</b> <a href="https://eiuperspectives.economist.com/sustainability/green-intelligence-ai-could-boost-efforts-fight-climate-change" target="_blank">Green Intelligence - AI could boost efforts to fight climate change</a> (May 2021)
* <b>Capgemini:</b> <a href="https://www.capgemini.com/research/climate-ai/" target="_blank">Climate AI: How artificial intelligence can power your climate action strategy</a> (Nov 2020)
* <b>Forbes:</b> <a href="https://www.forbes.com/sites/jeffmcmahon/2020/04/27/is-fusion-really-closer-to-reality-yes-thanks-to-machine-learning/" target="_blank">Is Fusion Really Close To Reality? Yes, Thanks To Machine Learning</a> (Apr 2020)
* <b>CleanTechnica:</b> <a href="https://cleantechnica.com/2020/01/20/machine-learning-experts-issue-call-to-arms-for-climate-focus/" target="_blank">Machine Learning Experts Issue Call To Arms For Climate Focus</a> (Jan 2020)
* <b>National Geographic:</b> <a href="https://www.nationalgeographic.com/environment/2019/07/artificial-intelligence-climate-change/" target="_blank">How artificial intelligence can tackle climate change</a> (Jul 2019)
* <b>The Verge:</b> <a href="https://www.theverge.com/2019/6/25/18744034/ai-artificial-intelligence-ml-climate-change-fight-tackle" target="_blank">Here’s how AI can help fight climate change according to the field’s top thinkers</a> (Jun 2019)
* <b>MIT Technology Review:</b> <a href="https://www.technologyreview.com/s/613838/ai-climate-change-machine-learning/" target="_blank">Here are 10 ways AI could help fight climate change</a> (Jun 2019)

## Selected podcasts and radio shows
* <b>The Interchange:</b> <a href="https://www.greentechmedia.com/articles/read/how-a.i-will-revolutionize-climate-tech" target="_blank">How A.I. Will Revolutionize Climate Tech</a> (Jun 2021)
* <b>Körber Stiftung:</b> <a href="https://www.koerber-stiftung.de/mediathek/der-zusammenhang-von-klima-und-ki-2182" target="_blank">Der Zusammenhang von Klima und KI</a> (Mar 2021, German)
* <b>ASP Flashpoint:</b> <a href="https://www.americansecurityproject.org/climate-and-ai-with-dr-david-rolnick/" target="_blank">Climate and AI</a> (Aug 2020)
* <b>Deutschlandfunk:</b> <a href="https://www.deutschlandfunk.de/umwelt-kuenstliche-intelligenz-gegen-den-klimawandel.684.de.html?dram:article_id=477738" target="_blank">Künstliche Intelligenz gegen den Klimawandel</a> (May 2020, German)
* <b>The Interchange:</b> <a href="https://www.greentechmedia.com/articles/read/beyond-forecasting-artificial-intelligence-is-a-powerful-decarbonization-tool" target="_blank">Beyond Forecasting: Artificial Intelligence Is a Powerful Decarbonization Tool</a> (Feb 2020)
* "Not Cool: A Climate Podcast" by the <b>Future of Life Institute:</b> <a href="https://futureoflife.org/2019/10/22/not-cool-ep-16-tackling-climate-change-with-machine-learning-part-1/" target="_blank">Part 1</a> and <a href="https://futureoflife.org/2019/10/24/not-cool-ep-17-tackling-machine-learning-with-climate-change-part-2/" target="_blank">Part 2</a> (Oct 2019)
* <b>Eye on A.I. podcast:</b> <a href="https://www.eye-on.ai/podcast-024" target="_blank">Climate Change and AI</a> (Sep 2019)
