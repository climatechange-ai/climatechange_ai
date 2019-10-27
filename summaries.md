# Section Summaries

<select multiple data-placeholder="Select machine learning keywords..." class="chosen-select" id='ml-keywords'></select>

<select multiple data-placeholder="Select topic-specific keywords..." class="chosen-select" id='topic-keywords'></select>

<select multiple data-placeholder="Select thematic keywords..." class="chosen-select" id='thematic-keywords'></select>

<button class='button' id='reset'>Clear filters</button>

<section id='sections' class='clearfix'>
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
      for (let i = 0; i < s.subsections.length; i++) {
        const ss = s.subsections[i];
        const tags = [];
        for (let kw of ss.ml_keywords) {
          ml_kwds.add(kw);
          tags.push(`<a class="tag is-primary is-ml">${kw}</a>`);
        }
        for (let kw of ss.topic_keywords) {
          topic_kwds.add(kw);
          tags.push(`<a href="#" class="tag is-info is-topic">${kw}</a>`);
        }
        for (let kw of ss.thematic_keywords) {
          thematic_kwds.add(kw);
          tags.push(`<a href="#" class="tag is-success is-thematic">${kw}</a>`);
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
                ${tags.join(" ")}
                <hr/>
                ${ss.summary}
              </div>
            </div>
            <footer class='card-footer'>
              <a class='card-footer-item' href="https://arxiv.org/pdf/1906.05433.pdf#subsection.${j+3}.${i+1}" target="_blank">Read more</a>
            </footer>
          </div>
        `;
      }
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
    });

    $('.is-thematic').click((ev) => {
      theme_sel.val($(ev.currentTarget).text()).trigger("change").trigger("chosen:updated");
    });

    $('.is-topic').click((ev) => {
      topic_sel.val($(ev.currentTarget).text()).trigger("change").trigger("chosen:updated");
    });

    $('.is-ml').click((ev) => {
      learn_sel.val($(ev.currentTarget).text()).trigger("change").trigger("chosen:updated");
    });

    $('#reset').click(() => {
      learn_sel.val('').trigger("change").trigger("chosen:updated");
      theme_sel.val('').trigger("change").trigger("chosen:updated");
      topic_sel.val('').trigger("change").trigger("chosen:updated");
    });

    $('.chosen-select').chosen();
  });
});
