---
layout: default
description: 'Frequently Asked Questions'
---

<div id='questions'>
  <div class='card collapsible'>
    <header class='card-header collapsible-header'>
      <p class='card-header-title'>Q: What's your favorite color?</p>
    </header>
    <div class='card-content collapsible-content'>
      <div class='content collapsible-content-inner'>
        A: Blue. No, yel-- auuuuuuuugh!
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function() {
  $.get('/FAQ.json', (questions) => {
    for (let faq of questions) {
      $('#questions').append(`
        <div class='card collapsible'>
          <header class='card-header collapsible-header'>
            <p class='card-header-title'>Q: ${faq.Q}</p>
          </header>
          <div class='card-content collapsible-content'>
            <div class='content collapsible-content-inner'>
              A: ${faq.A}
            </div>
          </div>
        </div>
      `);
    }
  });
});
