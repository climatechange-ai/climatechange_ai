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

        html += `
          <div class="subsection card clearfix"
            data-ml='${JSON.stringify(ss.ml_keywords)}'
            data-topic='${JSON.stringify(ss.topic_keywords)}'
            data-thematic='${JSON.stringify(ss.thematic_keywords)}'>

            <header class="card-header collapsible-header">
              <span class="card-header-title">
                ${ss.title}
              </span>
              <a href="#" class="card-header-icon" aria-label="more options">
              </a>
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

    function setOverlap(a, b) {
      if (!a) return false;
      if (!b) return false;
      for (const el of a)
        if (b.indexOf(el) >= 0)
          return true;
      return false;
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

    function toggleOverall() {
      if (learn_sel.val() + topic_sel.val() + theme_sel.val()) {
        $('#sections').addClass('filtering');
      } else {
        $('#sections').removeClass('filtering');
      }
    };

    learn_sel.change(() => {
      toggleOverall();
      $('.subsection').each((index, el) => {
        if (setOverlap($(el).data('ml'),learn_sel.val())) {
          $(el).addClass('ml-visible');
        } else {
          $(el).removeClass('ml-visible');
        }
      });

      $('.section').each((index, el) => {
        if ($(el).find('.subsection.ml-visible').length) {
          $(el).addClass('ml-visible');
        } else {
          $(el).removeClass('ml-visible');
        }
      });
    });

    topic_sel.change(() => {
      toggleOverall();
      $('.subsection').each((index, el) => {
        if (setOverlap($(el).data('topic'), topic_sel.val())) {
          $(el).addClass('topic-visible');
        } else {
          $(el).removeClass('topic-visible');
        }
      });

      $('.section').each((index, el) => {
        if ($(el).find('.subsection.topic-visible').length) {
          $(el).addClass('topic-visible');
        } else {
          $(el).removeClass('topic-visible');
        }
      });
    });

    theme_sel.change(() => {
      toggleOverall();
      $('.subsection').each((index, el) => {
        if (setOverlap($(el).data('thematic'), theme_sel.val())) {
          $(el).addClass('theme-visible');
        } else {
          $(el).removeClass('theme-visible');
        }
      });

      $('.section').each((index, el) => {
        if ($(el).find('.subsection.theme-visible').length) {
          $(el).addClass('theme-visible');
        } else {
          $(el).removeClass('theme-visible');
        }
      });
    });

    $('.is-thematic').click((ev) => {
      theme_sel.val($(ev.currentTarget).text().slice(1)).trigger("change").trigger("chosen:updated");
    });

    $('.is-topic').click((ev) => {
      topic_sel.val($(ev.currentTarget).text().slice(1)).trigger("change").trigger("chosen:updated");
    });

    $('.is-ml').click((ev) => {
      learn_sel.val($(ev.currentTarget).text().slice(1)).trigger("change").trigger("chosen:updated");
    });

    $('#reset').click(() => {
      learn_sel.val('').trigger("change").trigger("chosen:updated");
      theme_sel.val('').trigger("change").trigger("chosen:updated");
      topic_sel.val('').trigger("change").trigger("chosen:updated");
    });

    $('.chosen-select').chosen();
  });
});
