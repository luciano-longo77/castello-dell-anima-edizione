<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" encoding="UTF-8" indent="no"
      doctype-system="about:legacy-compat"/>
  <xsl:strip-space elements="tei:choice tei:app tei:subst tei:listBibl"/>

  <!-- ===================== SCHELETRO ===================== -->
  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>
          <xsl:value-of select="//tei:titlePart[@type='main']"/>
          <xsl:text> — edizione di lettura</xsl:text>
        </title>
        <style><xsl:call-template name="css"/></style>
      </head>
      <body class="view-interp">
        <header class="toolbar">
          <div class="tb-title"><xsl:value-of select="//tei:titlePart[@type='main']"/></div>
          <div class="tb-controls">
            <div class="seg" role="group" aria-label="Livello di trascrizione">
              <button id="bI" class="on" type="button">Interpretativo</button>
              <button id="bD" type="button">Diplomatico</button>
            </div>
            <button id="bApp" class="toggle" type="button">Apparato genetico</button>
            <button id="bStati" class="toggle on" type="button">Stati mistici</button>
          </div>
        </header>

        <main class="page">
          <xsl:apply-templates select="//tei:text"/>
        </main>

        <!-- Note a piè di pagina -->
        <xsl:if test="//tei:text//tei:note[@place='foot']">
          <section class="footnotes">
            <h2>Note</h2>
            <ol>
              <xsl:for-each select="//tei:text//tei:note[@place='foot']">
                <li id="fn-{position()}">
                  <xsl:apply-templates select="node()"/>
                  <xsl:text> </xsl:text>
                  <a class="fn-back" href="#fnref-{position()}">↩</a>
                </li>
              </xsl:for-each>
            </ol>
          </section>
        </xsl:if>

        <!-- Colophon dal teiHeader -->
        <footer class="colophon">
          <p>
            <xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/>
            <xsl:text>. Autografo: </xsl:text>
            <xsl:value-of select="normalize-space((//tei:bibl[@xml:id='castello-anima']/tei:note)[1])"/>
            <xsl:text>.</xsl:text>
          </p>
          <p class="lic">
            <xsl:value-of select="normalize-space(//tei:availability/tei:licence)"/>
          </p>
          <p class="gen">Pagina di lettura generata da <code>castello-anima.xsl</code>
             sul master risolto TEI. Fonte autorevole: i dati TEI in <code>data/</code>.</p>
        </footer>

        <script><xsl:call-template name="js"/></script>
      </body>
    </html>
  </xsl:template>

  <!-- ===================== STRUTTURA ===================== -->
  <xsl:template match="tei:text">
    <xsl:apply-templates select="tei:front"/>
    <xsl:apply-templates select="tei:body"/>
  </xsl:template>

  <xsl:template match="tei:front">
    <div class="titlepage">
      <h1><xsl:value-of select="//tei:titlePart[@type='main']"/></h1>
      <p class="subtitle"><xsl:value-of select="normalize-space(//tei:titlePart[@type='sub'])"/></p>
      <p class="author"><xsl:value-of select="normalize-space(//tei:docAuthor)"/></p>
    </div>
  </xsl:template>

  <xsl:template match="tei:body"><xsl:apply-templates/></xsl:template>

  <!-- div libro: contenitore; l'incipit lungo come epigrafe -->
  <xsl:template match="tei:div[@type='book']">
    <div class="book">
      <p class="incipit"><xsl:value-of select="normalize-space(tei:head)"/></p>
      <xsl:apply-templates select="*[not(self::tei:head)]"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:div[@type='preface'] | tei:div[@type='chapter']">
    <section class="chapter" id="{generate-id()}">
      <xsl:apply-templates select="tei:head"/>
      <xsl:apply-templates select="tei:argument"/>
      <xsl:apply-templates select="*[not(self::tei:head) and not(self::tei:argument)]"/>
    </section>
  </xsl:template>

  <xsl:template match="tei:div/tei:head">
    <h2 class="chap-title"><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="tei:argument">
    <aside class="argument"><xsl:apply-templates/></aside>
  </xsl:template>

  <!-- paragrafo con numerazione continua d'autrice -->
  <xsl:template match="tei:p">
    <p class="para">
      <xsl:if test="@n">
        <span class="pnum" title="paragrafo {@n}">§<xsl:value-of select="@n"/></span>
      </xsl:if>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- ===================== TRASCRIZIONE A DUE LIVELLI ===================== -->
  <xsl:template match="tei:choice[tei:orig and tei:reg]">
    <span class="ch"
      ><span class="lv-i"><xsl:apply-templates select="tei:reg/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:orig/node()"/></span></span>
  </xsl:template>

  <xsl:template match="tei:choice[tei:abbr and tei:expan]">
    <span class="ch"
      ><span class="lv-i"><xsl:apply-templates select="tei:expan/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:abbr/node()"/></span></span>
  </xsl:template>

  <xsl:template match="tei:choice[tei:sic and tei:corr]">
    <span class="ch corr" title="emendatio editoriale"
      ><span class="lv-i"><xsl:apply-templates select="tei:corr/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:sic/node()"/></span></span>
  </xsl:template>

  <!-- ===================== APPARATO GENETICO ===================== -->
  <xsl:template match="tei:app">
    <span class="app">
      <xsl:apply-templates select="tei:lem"/>
      <xsl:if test="tei:rdg">
        <span class="appnote" title="stato genetico Tb0">
          <span class="appnote-lbl">Tb0:</span>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="tei:rdg/node()" mode="app"/>
        </span>
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="tei:lem"><xsl:apply-templates/></xsl:template>

  <!-- ===================== FENOMENI MATERIALI ===================== -->
  <!-- del: nel testo di lettura è omesso; nell'apparato è barrato -->
  <xsl:template match="tei:del"/>
  <xsl:template match="tei:del" mode="app">
    <del class="del"><xsl:apply-templates mode="app"/></del>
  </xsl:template>

  <!-- add: aggiunta d'autrice, sempre visibile e marcata -->
  <xsl:template match="tei:add">
    <span class="add" title="aggiunta ({@place})"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:add" mode="app">
    <span class="add" title="aggiunta ({@place})"><xsl:apply-templates mode="app"/></span>
  </xsl:template>

  <!-- subst: sostituzione = si legge l'add (il del resta come traccia barrata) -->
  <xsl:template match="tei:subst">
    <xsl:apply-templates select="tei:add"/>
  </xsl:template>
  <xsl:template match="tei:subst" mode="app">
    <span class="subst"><xsl:apply-templates select="tei:del" mode="app"/><xsl:apply-templates select="tei:add" mode="app"/></span>
  </xsl:template>

  <!-- retrace: rivergatura, testo invariato -->
  <xsl:template match="tei:retrace">
    <span class="retrace" title="rivergatura: ripasso a inchiostro, testo invariato"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:retrace" mode="app">
    <span class="retrace"><xsl:apply-templates mode="app"/></span>
  </xsl:template>

  <!-- gap / unclear / supplied -->
  <xsl:template match="tei:gap">
    <span class="gap" title="guasto: illeggibile">⟨…⟩</span>
  </xsl:template>
  <xsl:template match="tei:gap" mode="app">
    <span class="gap">⟨…⟩</span>
  </xsl:template>

  <xsl:template match="tei:unclear">
    <span class="unclear" title="lettura incerta"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:unclear" mode="app">
    <span class="unclear"><xsl:apply-templates mode="app"/></span>
  </xsl:template>

  <xsl:template match="tei:supplied">
    <span class="supplied" title="integrazione editoriale (@cert={@cert})">[<xsl:apply-templates/>]</span>
  </xsl:template>
  <xsl:template match="tei:supplied" mode="app">
    <span class="supplied">[<xsl:apply-templates mode="app"/>]</span>
  </xsl:template>

  <!-- ===================== ANCORAGGIO SEMANTICO ===================== -->
  <xsl:template match="tei:term[@ref]">
    <span class="term" data-state="{substring-after(@ref,'#')}"
          title="stato mistico: {substring-after(@ref,'#')}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:term"><span class="term-plain"><xsl:apply-templates/></span></xsl:template>

  <!-- ===================== SEGNALETICA MATERIALE ===================== -->
  <xsl:template match="tei:pb">
    <span class="pb" title="carta {@n}"><span class="pb-lbl"><xsl:value-of select="@n"/></span></span>
  </xsl:template>

  <!-- lb: se break="no" la parola continua (niente spazio); altrimenti marca di riga -->
  <xsl:template match="tei:lb">
    <xsl:choose>
      <xsl:when test="@break='no'"><span class="lb nobreak"></span></xsl:when>
      <xsl:otherwise><span class="lb">&#160;</span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- fw: richiami e simili (segnaletica di pagina) -->
  <xsl:template match="tei:fw">
    <span class="fw" title="richiamo / segnaletica di pagina"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- ===================== NOTE ===================== -->
  <xsl:template match="tei:note[@place='foot']">
    <sup class="fnref" id="fnref-{count(preceding::tei:note[@place='foot'])+1}">
      <a href="#fn-{count(preceding::tei:note[@place='foot'])+1}"
        ><xsl:value-of select="count(preceding::tei:note[@place='foot'])+1"/></a>
    </sup>
  </xsl:template>
  <!-- il contenuto delle note è reso solo nella sezione finale (vedi template /) -->
  <xsl:template match="tei:note"/>

  <!-- intertesto -->
  <xsl:template match="tei:quote"><q class="quote"><xsl:apply-templates/></q></xsl:template>
  <xsl:template match="tei:cit"><span class="cit"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:ref"><span class="ref"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:hi"><em><xsl:apply-templates/></em></xsl:template>

  <!-- il teiHeader non entra nel corpo di lettura -->
  <xsl:template match="tei:teiHeader"/>

  <!-- ===================== CSS ===================== -->
  <xsl:template name="css">
:root{
  --bg:#faf8f4; --fg:#241f1a; --muted:#7a7167; --rule:#e4ddd0;
  --accent:#7a5a2f; --accent2:#4a6a55; --card:#fffdf9;
  --term:#eef3ee; --term-b:#cfe0d3; --add:#e9f0f7; --supp:#f3eee2;
  --appbg:#f6f1e7; --del:#b23a3a;
}
:root:not([data-theme="light"]) @media (prefers-color-scheme: dark){}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#17140f; --fg:#e9e2d6; --muted:#9a9182; --rule:#332c22;
    --accent:#c9a86a; --accent2:#8fb89b; --card:#1e1a14;
    --term:#1c261e; --term-b:#31463a; --add:#182430; --supp:#2a2417;
    --appbg:#201b13; --del:#e07a7a;
  }
}
:root[data-theme="dark"]{
  --bg:#17140f; --fg:#e9e2d6; --muted:#9a9182; --rule:#332c22;
  --accent:#c9a86a; --accent2:#8fb89b; --card:#1e1a14;
  --term:#1c261e; --term-b:#31463a; --add:#182430; --supp:#2a2417;
  --appbg:#201b13; --del:#e07a7a;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);
  font-family:"Iowan Old Style","Palatino Linotype",Palatino,Georgia,serif;
  line-height:1.7;font-size:18px}
.toolbar{position:sticky;top:0;z-index:10;display:flex;flex-wrap:wrap;gap:.6rem;
  align-items:center;justify-content:space-between;
  padding:.6rem 1rem;background:var(--card);border-bottom:1px solid var(--rule)}
.tb-title{font-weight:600;font-size:.95rem;color:var(--accent)}
.tb-controls{display:flex;gap:.5rem;flex-wrap:wrap;align-items:center}
.seg{display:inline-flex;border:1px solid var(--rule);border-radius:8px;overflow:hidden}
.seg button{border:0;background:transparent;color:var(--fg);padding:.35rem .7rem;
  font:inherit;font-size:.82rem;cursor:pointer}
.seg button.on{background:var(--accent);color:#fff}
button.toggle{border:1px solid var(--rule);background:transparent;color:var(--muted);
  border-radius:8px;padding:.35rem .7rem;font:inherit;font-size:.82rem;cursor:pointer}
button.toggle.on{color:var(--fg);border-color:var(--accent2);
  box-shadow:inset 0 0 0 1px var(--accent2)}
.page{max-width:44rem;margin:0 auto;padding:2rem 1.2rem 4rem}
.titlepage{text-align:center;margin:2rem 0 3rem;padding-bottom:2rem;
  border-bottom:1px solid var(--rule)}
.titlepage h1{font-size:2rem;margin:.2rem 0;color:var(--accent)}
.subtitle{color:var(--muted);font-size:1rem;font-style:italic}
.author{margin-top:1rem;font-variant:small-caps;letter-spacing:.03em}
.incipit{font-style:italic;color:var(--muted);text-align:center;
  border-left:0;margin:1rem auto 2rem;max-width:38rem}
.chapter{margin:2.4rem 0}
.chap-title{font-size:1.3rem;color:var(--accent);border-bottom:1px solid var(--rule);
  padding-bottom:.3rem;margin-bottom:.6rem}
.argument{font-style:italic;color:var(--muted);background:var(--card);
  border-left:3px solid var(--accent2);padding:.6rem .9rem;border-radius:0 6px 6px 0;
  margin:.4rem 0 1.2rem;font-size:.95rem}
.para{margin:0 0 1.1rem;text-align:justify;position:relative}
.pnum{color:var(--accent2);font-size:.72rem;font-weight:700;vertical-align:super;
  margin-right:.35rem;user-select:none;font-family:ui-monospace,monospace}
/* livelli */
body.view-interp .lv-d{display:none}
body.view-dipl  .lv-i{display:none}
.ch.corr .lv-i{border-bottom:1px dotted var(--accent)}
/* apparato */
.appnote{display:none;font-size:.82rem;color:var(--muted);background:var(--appbg);
  border:1px solid var(--rule);border-radius:6px;padding:.05rem .4rem;margin:0 .15rem;
  white-space:normal}
.appnote-lbl{font-variant:small-caps;color:var(--accent);font-weight:600;font-size:.75rem}
body.show-app .appnote{display:inline}
.del{color:var(--del);text-decoration:line-through}
.add{background:var(--add);border-radius:3px;padding:0 .1em}
/* fenomeni */
.gap{color:var(--muted)}
.unclear{border-bottom:1px dotted var(--muted)}
.supplied{color:var(--accent2)}
.retrace{border-bottom:1px solid var(--accent);}
/* stati mistici */
.term{background:var(--term);border-bottom:1px solid var(--term-b);border-radius:3px;
  padding:0 .12em;cursor:help}
body:not(.show-stati) .term{background:transparent;border-bottom-color:transparent}
/* segnaletica */
.pb{display:inline-block;vertical-align:middle;margin:0 .25rem;user-select:none}
.pb-lbl{font-family:ui-monospace,monospace;font-size:.62rem;color:#fff;
  background:var(--accent2);border-radius:4px;padding:.02rem .3rem;letter-spacing:.02em}
.fw{font-size:.72rem;color:var(--muted);font-style:italic}
body.view-interp .fw{display:none}
.lb.nobreak{}
/* note */
.fnref a{color:var(--accent2);text-decoration:none;font-size:.7em;padding:0 .1em}
.footnotes{max-width:44rem;margin:2rem auto 0;padding:1.4rem 1.2rem;
  border-top:1px solid var(--rule)}
.footnotes h2{font-size:1rem;color:var(--accent);font-variant:small-caps}
.footnotes ol{font-size:.86rem;color:var(--muted);line-height:1.6}
.footnotes li{margin-bottom:.4rem}
.fn-back{text-decoration:none;color:var(--accent2)}
.colophon{max-width:44rem;margin:1rem auto 3rem;padding:1.2rem;color:var(--muted);
  font-size:.8rem;text-align:center;border-top:1px solid var(--rule)}
.colophon code{font-size:.9em;background:var(--card);padding:.05rem .3rem;border-radius:4px}
.colophon .lic{font-style:italic}
@media (max-width:640px){body{font-size:17px}.tb-title{display:none}}
  </xsl:template>

  <!-- ===================== JS ===================== -->
  <xsl:template name="js">
(function(){
  var b=document.body;
  var bI=document.getElementById('bI'), bD=document.getElementById('bD');
  var bApp=document.getElementById('bApp'), bStati=document.getElementById('bStati');
  function lvl(interp){
    b.classList.toggle('view-interp',interp); b.classList.toggle('view-dipl',!interp);
    bI.classList.toggle('on',interp); bD.classList.toggle('on',!interp);
  }
  bI.onclick=function(){lvl(true)};
  bD.onclick=function(){lvl(false)};
  bApp.onclick=function(){b.classList.toggle('show-app');bApp.classList.toggle('on',b.classList.contains('show-app'))};
  bStati.onclick=function(){b.classList.toggle('show-stati');bStati.classList.toggle('on',b.classList.contains('show-stati'))};
  b.classList.add('show-stati'); // stati evidenziati di default
})();
  </xsl:template>

</xsl:stylesheet>
