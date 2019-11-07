# Section Summaries

Climate change is one of the greatest challenges facing humanity, and we, as machine learning experts, may wonder how we can help. In our paper “Tackling Climate Change with Machine Learning,” we describe how machine learning can be a powerful tool in reducing greenhouse gas emissions and helping society adapt to a changing climate. Specifically, we identify high impact problems where existing gaps can be filled by machine learning, in collaboration with other fields.

This page provides an interactive summary of the applications described in our <a href='https://arxiv.org/abs/1906.05433' target='_blank'>paper</a>. Applications can be filtered by machine learning technique or thematic area using the keyword fields below.

<div class='keywords field'>
  <label class='label'>Paper Section</label>
  <div class='control'>
    <div class='select is-small'>
      <select id='section-select' placeholder="Select a paper section...">
        <option></option>
      </select>
    </div>
  </div>
</div>

<div class='keywords field'>
  <label class='label'>ML Keywords</label>
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
    display: none !important;
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

    const learn_sel = $('#ml-keywords');
    const topic_sel = $('#topic-keywords');
    const theme_sel = $('#thematic-keywords');
    const section_sel = $('#section-select');

    let html = '';
    for (let j = 0; j < summaries.length; j++) {
      const s = summaries[j];

      html += `<div class='section'><h2>${s.title}</h2>`;
      section_sel.append(`<option value="${s.title}">${s.title}</option>`);

      for (let i = 0; i < s.subsections.length; i++) {
        const ss = s.subsections[i];
        const tags = [];
        const flags = [];

        for (let kw of ss.ml_keywords) {
          ml_kwds.add(kw);
          tags.push(`<a class="tag is-light is-ml">#${kw}</a>`);
        }
        for (let kw of ss.topic_keywords || []) {
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

        let pdfLink;
        if (ss.pdf_location) {
          pdfLink = `https://arxiv.org/pdf/1906.05433.pdf#${ss.pdf_location.replace(/&zoom=.*$/gi, "")}`;
        } else if (ss.section_number) {
          const level = ss.section_number.split(".").length;
          if (level == 3) {
            pdfLink = `https://arxiv.org/pdf/1906.05433.pdf#subsubsection.${ss.section_number}`;
          } else if (level == 2) {
            pdfLink = `https://arxiv.org/pdf/1906.05433.pdf#subsection.${ss.section_number}`;
          } else if (level == 1) {
            pdfLink = `https://arxiv.org/pdf/1906.05433.pdf#section.${ss.section_number}`;
          } else {
            console.log(`WARNING: missing pdf link for ${s.title} > ${ss.title}`);
          }
        } else {
          console.log(`WARNING: missing pdf link for ${s.title} > ${ss.title}`);
        }

        html += `
          <div class="subsection card clearfix"
            data-section='${JSON.stringify([s.title])}'
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
                <a class='button is-link' href="${pdfLink}" target="_blank">Read More</a>
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
      if (!Array.isArray(b)) b = [b];
      for (const el of b)
        if (a.indexOf(el) == -1)
          return false;
      return true;
    }

    $('#sections').append(html);

    $(document).on('click', '.collapsible-header', (ev) => {
      $(ev.currentTarget).closest('.subsection').toggleClass('is-expanded');
    });

    ml_kwds.forEach((kw) => {
      learn_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    topic_kwds.forEach((kw) => {
      topic_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    thematic_kwds.forEach((kw) => {
      theme_sel.append(`<option value="${kw}">${kw}</option>`);
    });

    const filters = [
      [learn_sel, 'ml'],
      [topic_sel, 'topic'],
      [theme_sel, 'thematic'],
      [section_sel, 'section']
    ];
    const filterClassSelectors = filters.map((el) => `.${el[1]}-filtered`);

    function toggleVisibility(select, key) {
      if (select.val().length) {
        $('#sections').addClass(`${key}-filtering`);
      } else {
        $('#sections').removeClass(`${key}-filtering`);
        $('.subsection').removeClass(`${key}-filtered`);
      }

      $('.subsection').each((index, el) => {
        if (select.val().length == 0 || allWithin($(el).data(key), select.val())) {
          $(el).removeClass(`${key}-filtered`);
        } else {
          $(el).addClass(`${key}-filtered`);
        }
      });

      $('.section').each((index, el) => {
        if ($(el).find('.subsection').not(filterClassSelectors.join(", ")).length) {
          $(el).removeClass(`all-filtered`);
        } else {
          $(el).addClass(`all-filtered`);
        }
      });
    }

    for (let pair of filters) {
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
      section_sel.val('').trigger("change");
    });

    $('.chosen-select').chosen();
  });
});
