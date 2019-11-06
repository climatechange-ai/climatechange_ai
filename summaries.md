# Section Summaries

On this page, we provide an interactive view of <a href='https://arxiv.org/abs/1906.05433' target='_blank'>the paper</a> at a subsection level. You can select keywords below to filter the list.



<div class='keywords field'>
  <label class='label'>Machine Learning Keywords</label>
  <div class='control'>
    <select multiple data-placeholder="Select machine learning keywords..." class="chosen-select" id='ml-keywords'></select>
  </div>
</div>

<div class='keywords field'>
  <label class='label'>Thematic Keywords</label>
  <div class='control'>
    <select multiple data-placeholder="Select thematic keywords..." class="chosen-select" id='thematic-keywords'></select>
  </div>
</div>

<div class='keywords field topic-keywords'>
  <label class='label'>Topic Keywords</label>
  <div class='control'>
  <select multiple data-placeholder="Select topic-specific keywords..." class="chosen-select" id='topic-keywords'></select>
  </div>
</div>


<style>
  /* quick hack: hide the topic keywords without changing the code. comment or uncomment as desired */
  .tag.is-topic, .topic-keywords {
    // display: none !important;
  }
</style>

<section id='sections' class='clearfix'>
  <p><button class='button is-small' id='reset'>Clear filters</button></p>
</section>

<script src="assets/js/chosen.jquery.js"></script>

<script>
$(document).ready(function() {
  $.get('/section-summaries.json', (summaries) => {
    let ml_kwds = new Set();
    let topic_kwds = new Set();
    let thematic_kwds = new Set();

    let html = '';
    for (let j = 0; j < summaries.length; j++) {
      const s = summaries[j];

      html += `<div class='section'><h2>${s.title}</h2>`;
      for (let i = 0; i < s.subsections.length; i++) {
        const ss = s.subsections[i];
        const tags = [];
        const flags = [];
        for (let kw of ss.ml_keywords) {
          ml_kwds.add(kw);
          tags.push(`<a class="tag is-light is-ml">#${kw}</a>`);
        }
        for (let kw of ss.topic_keywords) {
          topic_kwds.add(kw);
          tags.push(`<a href="#" class="tag is-light is-topic">#${kw}</a>`);
        }
        for (let kw of ss.thematic_keywords) {
          thematic_kwds.add(kw);
          tags.push(`<a href="#" class="tag is-light is-thematic">#${kw}</a>`);
        }
        for (let flag of ss.paper_flags) {
          if (flag == 'High Risk' || flag == 'Uncertain Impact') {
            flags.push(`<span class='tag paper-flag is-uncertain-impact'>Uncertain Impact</span>`);
          } else if (flag == 'Long-term') {
            flags.push(`<span class='tag paper-flag is-long-term'>Long-Term</span>`);
          } else if (flag == 'High Leverage') {
            flags.push(`<span class='tag paper-flag is-high-leverage'>High Leverage</span>`);
          }
        }

        html += `
          <div class="subsection card clearfix"
            data-ml='${JSON.stringify(ss.ml_keywords)}'
            data-topic='${JSON.stringify(ss.topic_keywords)}'
            data-thematic='${JSON.stringify(ss.thematic_keywords)}'>

            <header class="card-header collapsible-header">
              <div class="card-header-title">
                ${ss.title}
                <div class='paper-flags'>${flags.join(" ")}</div>
              </div>
            </header>
            <div class="card-content">
              <div class="content">
                <p>${ss.summary}</p>
                <a class='button is-link' href="https://arxiv.org/pdf/1906.05433.pdf#subsection.${j+1}.${i+1}" target="_blank">Read More</a>
              </div>
            </div>
            <footer class='card-footer'>
              <div class='card-footer-item'>
                <p>
                ${tags.join(" ")}
                </p>
              </div>
            </footer>
          </div>
        `;
      }
      html += `</div>`;
    }

    function allWithin(a, b) {
      for (const el of b)
        if (a.indexOf(el) == -1)
          return false;
      return true;
    }

    $('#sections').append(html);

    $(document).on('click', '.collapsible-header', (ev) => {
      $(ev.currentTarget).closest('.subsection').toggleClass('is-expanded');
    });

    const learn_sel = $('#ml-keywords');
    const topic_sel = $('#topic-keywords');
    const theme_sel = $('#thematic-keywords');

    ml_kwds.forEach((kw) => {
      learn_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    topic_kwds.forEach((kw) => {
      topic_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    thematic_kwds.forEach((kw) => {
      theme_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    function toggleVisibility(select, key) {
      if (select.val()) {
        $('#sections').addClass(`${key}-filtering`);
      } else {
        $('#sections').removeClass(`${key}-filtering`);
      }

      $('.subsection').each((index, el) => {
        if (allWithin($(el).data(key), select.val())) {
          $(el).removeClass(`${key}-filtered`);
        } else {
          $(el).addClass(`${key}-filtered`);
        }
      });

      $('.section').each((index, el) => {
        if ($(el).find(`.subsection:not(.${key}-filtered)`).length) {
          $(el).removeClass(`${key}-filtered`);
        } else {
          $(el).addClass(`${key}-filtered`);
        }
      });
    }

    for (let pair of [[learn_sel, 'ml'], [topic_sel, 'topic'], [theme_sel, 'thematic']]) {
      const select = pair[0];
      const key = pair[1];

      select.change(() => {
        toggleVisibility(select, key);
      });

      $(`is-${key}`).click((ev) => {
        select.val($(ev.currentTarget).text().slice(1));
        select.trigger("change").trigger("chosen:updated");
      });
    }

    $('#reset').click(() => {
      learn_sel.val('').trigger("change").trigger("chosen:updated");
      theme_sel.val('').trigger("change").trigger("chosen:updated");
      topic_sel.val('').trigger("change").trigger("chosen:updated");
    });

    $('.chosen-select').chosen();
  });
});
