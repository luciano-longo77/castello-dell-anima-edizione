<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="about:legacy-compat"/>
  <xsl:strip-space elements="tei:listBibl tei:listWit tei:taxonomy tei:particDesc"/>

  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="//tei:titlePart[@type='main']"/> — teiHeader</title>
        <style><xsl:call-template name="css"/></style>
      </head>
      <body>
        <header class="topbar">
          <div class="tt">teiHeader — <xsl:value-of select="//tei:titlePart[@type='main']"/></div>
          <div class="tools">
            <button id="exp" class="btn" type="button">Espandi tutto</button>
            <button id="col" class="btn" type="button">Comprimi tutto</button>
            <a class="btn primary" href="castello-anima-lettura.html">📖 Testo dell'edizione →</a>
          </div>
        </header>

        <div class="layout">
          <!-- indice laterale -->
          <nav class="toc" aria-label="Indice">
            <a href="#sec1">1 · Descrizione bibliografica</a>
            <xsl:if test="//tei:notesStmt/tei:noteGrp"><a href="#sec2">2 · Note descrittive</a></xsl:if>
            <xsl:if test="//tei:msDesc"><a href="#sec3">3 · Il manoscritto</a></xsl:if>
            <xsl:if test="//tei:handNote"><a href="#sec4">4 · Mani</a></xsl:if>
            <a href="#sec5">5 · Stati genetici</a>
            <a href="#sec6">6 · Fonti e bibliografia</a>
            <a href="#sec7">7 · Criteri di codifica</a>
            <a href="#sec8">8 · Tassonomie</a>
            <a href="#sec9">9 · Lingue, persone ed enti</a>
          </nav>

          <main class="content">
            <h1 class="doc-h1">Descrizione dell'edizione</h1>
            <p class="doc-sub">Metadati completi del <code>teiHeader</code> — MC-1, Libro III, capp. I–V.
               <span class="muted">La cronologia redazionale (<code>revisionDesc</code>) è esclusa da questa pagina.</span></p>

            <!-- 1 -->
            <details class="acc" id="sec1" open="open">
              <summary><span class="secn">1</span>Descrizione bibliografica</summary>
              <div class="acc-body">
                <dl class="meta">
                  <dt>Titolo</dt><dd><xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/></dd>
                  <dt>Autrice</dt><dd><xsl:value-of select="normalize-space((//tei:titleStmt/tei:author)[1])"/></dd>
                  <dt>Responsabilità</dt><dd><xsl:for-each select="//tei:titleStmt/tei:respStmt"><xsl:value-of select="normalize-space(tei:resp)"/> — <xsl:value-of select="normalize-space(tei:name)"/><xsl:if test="position()!=last()">; </xsl:if></xsl:for-each></dd>
                  <dt>Editore</dt><dd><xsl:value-of select="normalize-space(//tei:publicationStmt/tei:publisher)"/><xsl:if test="//tei:publicationStmt/tei:date/@when">, <xsl:value-of select="//tei:publicationStmt/tei:date/@when"/></xsl:if></dd>
                  <dt>Tipo</dt><dd><xsl:value-of select="normalize-space(//tei:publicationStmt/tei:idno)"/></dd>
                  <dt>Licenza</dt><dd><xsl:value-of select="normalize-space(//tei:availability/tei:licence)"/></dd>
                  <xsl:if test="//tei:availability/tei:p"><dt>Disponibilità</dt><dd><xsl:value-of select="normalize-space(//tei:availability/tei:p)"/></dd></xsl:if>
                </dl>
                <xsl:if test="//tei:encodingDesc/tei:ab"><p class="abstract"><xsl:value-of select="normalize-space(//tei:encodingDesc/tei:ab)"/></p></xsl:if>
              </div>
            </details>

            <!-- 2 -->
            <xsl:if test="//tei:notesStmt/tei:noteGrp">
            <details class="acc" id="sec2" open="open">
              <summary><span class="secn">2</span>Note descrittive</summary>
              <div class="acc-body">
                <xsl:for-each select="//tei:notesStmt/tei:noteGrp">
                  <h3><xsl:value-of select="@type"/></h3>
                  <ul class="notes"><xsl:for-each select="tei:note"><li><xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
                </xsl:for-each>
              </div>
            </details>
            </xsl:if>

            <!-- 3 -->
            <xsl:if test="//tei:msDesc">
            <details class="acc" id="sec3" open="open">
              <summary><span class="secn">3</span>Il manoscritto</summary>
              <div class="acc-body">
                <dl class="meta">
                  <dt>Segnatura</dt><dd><xsl:value-of select="normalize-space(//tei:msIdentifier/tei:settlement)"/>, <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:repository)"/>, ms. <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno)"/></dd>
                  <xsl:if test="//tei:msContents"><dt>Contenuto</dt><dd><xsl:value-of select="normalize-space(//tei:msContents)"/></dd></xsl:if>
                  <xsl:if test="//tei:physDesc"><dt>Descrizione fisica</dt><dd><xsl:value-of select="normalize-space(//tei:physDesc)"/></dd></xsl:if>
                  <xsl:if test="//tei:history"><dt>Storia</dt><dd><xsl:value-of select="normalize-space(//tei:history)"/></dd></xsl:if>
                  <xsl:if test="//tei:additional"><dt>Altro</dt><dd><xsl:value-of select="normalize-space(//tei:additional)"/></dd></xsl:if>
                </dl>
              </div>
            </details>
            </xsl:if>

            <!-- 4 -->
            <xsl:if test="//tei:handNote">
            <details class="acc" id="sec4" open="open">
              <summary><span class="secn">4</span>Mani</summary>
              <div class="acc-body">
                <ul class="def"><xsl:for-each select="//tei:handNote"><li><span class="sig"><xsl:value-of select="@xml:id"/></span> <span class="tag"><xsl:value-of select="@medium"/></span> <xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
              </div>
            </details>
            </xsl:if>

            <!-- 5 -->
            <details class="acc" id="sec5" open="open">
              <summary><span class="secn">5</span>Stati genetici (testimoni)</summary>
              <div class="acc-body">
                <xsl:for-each select="//tei:listWit/tei:listWit">
                  <h3><xsl:value-of select="normalize-space(tei:head)"/></h3>
                  <ul class="def"><xsl:for-each select="tei:witness"><li><span class="sig"><xsl:value-of select="@xml:id"/></span> <xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
                </xsl:for-each>
                <xsl:if test="//tei:creation/tei:listChange">
                  <h3>Campagne scrittorie (genesi)</h3>
                  <ul class="def"><xsl:for-each select="//tei:creation/tei:listChange/tei:change"><li><xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
                </xsl:if>
              </div>
            </details>

            <!-- 6 -->
            <details class="acc" id="sec6" open="open">
              <summary><span class="secn">6</span>Fonti e bibliografia</summary>
              <div class="acc-body">
                <h3>Fonti dottrinali</h3>
                <ul class="bibl"><xsl:for-each select="//tei:listBibl[@type='fontes']/tei:bibl"><li><xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
                <xsl:if test="//tei:listBibl[@type='studi']">
                  <h3>Bibliografia critica</h3>
                  <ul class="bibl"><xsl:for-each select="//tei:listBibl[@type='studi']/tei:bibl"><li><xsl:apply-templates select="node()" mode="bibl"/></li></xsl:for-each></ul>
                </xsl:if>
              </div>
            </details>

            <!-- 7 -->
            <details class="acc" id="sec7" open="open">
              <summary><span class="secn">7</span>Criteri di codifica</summary>
              <div class="acc-body">
                <xsl:if test="//tei:projectDesc"><h3>Il progetto e il modello</h3><xsl:for-each select="//tei:projectDesc/tei:p"><p class="p"><xsl:value-of select="normalize-space(.)"/></p></xsl:for-each></xsl:if>
                <xsl:if test="//tei:refsDecl"><h3>Riferimenti interni</h3><xsl:for-each select="//tei:refsDecl/tei:p"><p class="p"><xsl:value-of select="normalize-space(.)"/></p></xsl:for-each></xsl:if>
                <xsl:if test="//tei:editorialDecl"><h3>Criteri editoriali</h3>
                  <xsl:for-each select="//tei:editorialDecl/tei:p"><p class="p"><xsl:value-of select="normalize-space(.)"/></p></xsl:for-each>
                  <ul class="def">
                    <xsl:if test="//tei:editorialDecl/tei:correction"><li><b>Correzione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:correction)"/></li></xsl:if>
                    <xsl:if test="//tei:editorialDecl/tei:hyphenation"><li><b>Sillabazione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:hyphenation)"/></li></xsl:if>
                    <xsl:if test="//tei:editorialDecl/tei:normalization"><li><b>Normalizzazione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:normalization)"/></li></xsl:if>
                  </ul>
                </xsl:if>
                <xsl:if test="//tei:variantEncoding"><p class="p"><b>Codifica delle varianti:</b> metodo <code><xsl:value-of select="//tei:variantEncoding/@method"/></code>, collocazione <code><xsl:value-of select="//tei:variantEncoding/@location"/></code>.</p></xsl:if>
                <xsl:if test="//tei:schemaRef"><p class="p"><b>Schema:</b> <code><xsl:value-of select="//tei:schemaRef/@url"/></code> (<xsl:value-of select="//tei:schemaRef/@type"/>).</p></xsl:if>
              </div>
            </details>

            <!-- 8 -->
            <details class="acc" id="sec8" open="open">
              <summary><span class="secn">8</span>Tassonomie</summary>
              <div class="acc-body">
                <h3>Stati mistici <span class="cnt"><xsl:value-of select="count(//tei:taxonomy[@xml:id='stati-mistici']/tei:category)"/></span></h3>
                <dl class="tax"><xsl:for-each select="//tei:taxonomy[@xml:id='stati-mistici']/tei:category"><dt><xsl:value-of select="@xml:id"/></dt><dd><xsl:value-of select="normalize-space(tei:catDesc)"/></dd></xsl:for-each></dl>
                <xsl:if test="//tei:taxonomy[@xml:id='fase']">
                  <h3>Fasi di lavoro</h3>
                  <dl class="tax"><xsl:for-each select="//tei:taxonomy[@xml:id='fase']/tei:category"><dt><xsl:value-of select="@xml:id"/></dt><dd><xsl:value-of select="normalize-space(tei:catDesc)"/></dd></xsl:for-each></dl>
                </xsl:if>
              </div>
            </details>

            <!-- 9 -->
            <details class="acc" id="sec9" open="open">
              <summary><span class="secn">9</span>Lingue, persone ed enti</summary>
              <div class="acc-body">
                <h3>Lingue</h3>
                <ul class="def"><xsl:for-each select="//tei:langUsage/tei:language"><li><span class="sig"><xsl:value-of select="@xml:id"/></span> <xsl:value-of select="normalize-space(.)"/></li></xsl:for-each></ul>
                <xsl:if test="//tei:particDesc//tei:person">
                  <h3>Persone</h3>
                  <ul class="def"><xsl:for-each select="//tei:particDesc//tei:person"><li><b><xsl:value-of select="normalize-space((.//tei:persName | .//tei:name)[1])"/></b><xsl:if test="tei:note"> — <xsl:value-of select="normalize-space((tei:note)[1])"/></xsl:if></li></xsl:for-each></ul>
                </xsl:if>
                <xsl:if test="//tei:particDesc//tei:org">
                  <h3>Enti</h3>
                  <ul class="def"><xsl:for-each select="//tei:particDesc//tei:org"><li><b><xsl:value-of select="normalize-space((.//tei:orgName | .//tei:name)[1])"/></b><xsl:if test="tei:note"> — <xsl:value-of select="normalize-space((tei:note)[1])"/></xsl:if></li></xsl:for-each></ul>
                </xsl:if>
              </div>
            </details>

            <footer class="foot">
              <p>Generata da <code>castello-anima-teiHeader.xsl</code>. Cronologia redazionale esclusa.
                 Fonte autorevole: i dati TEI in <code>data/</code>.</p>
            </footer>
          </main>
        </div>

        <script><xsl:call-template name="js"/></script>
      </body>
    </html>
  </xsl:template>

  <!-- bibl: titoli in corsivo -->
  <xsl:template match="tei:title" mode="bibl"><i><xsl:apply-templates/></i></xsl:template>
  <xsl:template match="tei:author|tei:pubPlace|tei:publisher|tei:date|tei:biblScope" mode="bibl"><xsl:apply-templates/></xsl:template>
  <xsl:template match="text()" mode="bibl"><xsl:value-of select="."/></xsl:template>

  <!-- ===================== CSS ===================== -->
  <xsl:template name="css">
:root{--bg:#faf8f4;--fg:#241f1a;--muted:#6f665b;--rule:#e4ddd0;--accent:#7a4f22;--accent2:#3f5f4b;--card:#fffdf9;--chip:#eef3ee}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){--bg:#15120d;--fg:#ece5d9;--muted:#a49a8b;--rule:#352d22;--accent:#d9b676;--accent2:#93bc9f;--card:#1d1913;--chip:#1d281f}}
:root[data-theme="dark"]{--bg:#15120d;--fg:#ece5d9;--muted:#a49a8b;--rule:#352d22;--accent:#d9b676;--accent2:#93bc9f;--card:#1d1913;--chip:#1d281f}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);font-family:"Iowan Old Style","Palatino Linotype",Palatino,Georgia,serif;line-height:1.65;font-size:17px}
.topbar{position:sticky;top:0;z-index:20;display:flex;flex-wrap:wrap;gap:.6rem;align-items:center;justify-content:space-between;
  padding:.55rem 1rem;background:var(--card);border-bottom:1px solid var(--rule)}
.tt{font-weight:600;color:var(--accent);font-size:.95rem}
.tools{display:flex;gap:.4rem;flex-wrap:wrap}
.btn{border:1px solid var(--rule);background:transparent;color:var(--muted);border-radius:8px;padding:.34rem .7rem;font:inherit;font-size:.8rem;cursor:pointer;text-decoration:none}
.btn:hover{color:var(--fg);border-color:var(--accent2)}
.btn.primary{background:var(--accent);color:#fff;border-color:var(--accent)}
.layout{display:grid;grid-template-columns:15rem 1fr;gap:1.5rem;max-width:66rem;margin:0 auto;padding:1.4rem 1.2rem 3rem}
.toc{position:sticky;top:3.6rem;align-self:start;display:flex;flex-direction:column;gap:.1rem;font-size:.82rem}
.toc a{color:var(--accent2);text-decoration:none;padding:.28rem .55rem;border-radius:7px;border-left:2px solid transparent}
.toc a:hover{background:var(--card);color:var(--accent);border-left-color:var(--accent)}
.content{min-width:0}
.doc-h1{font-size:1.7rem;color:var(--accent);margin:.2rem 0 .2rem}
.doc-sub{color:var(--fg);margin:0 0 1.2rem;font-size:.95rem}.doc-sub .muted{color:var(--muted)}
.acc{background:var(--card);border:1px solid var(--rule);border-radius:10px;margin:0 0 .9rem;overflow:hidden}
.acc>summary{cursor:pointer;padding:.7rem 1rem;font-size:1.05rem;font-weight:600;color:var(--accent);list-style:none;display:flex;align-items:center;gap:.6rem}
.acc>summary::-webkit-details-marker{display:none}
.acc>summary::after{content:"▾";margin-left:auto;color:var(--muted);font-size:.8em;transition:transform .15s}
.acc:not([open])>summary::after{transform:rotate(-90deg)}
.secn{display:inline-flex;align-items:center;justify-content:center;width:1.6rem;height:1.6rem;border-radius:50%;
  background:var(--accent2);color:#fff;font-size:.8rem;font-family:ui-monospace,monospace}
.acc-body{padding:.2rem 1.1rem 1rem;border-top:1px solid var(--rule)}
.acc-body h3{font-size:.92rem;color:var(--accent2);font-variant:small-caps;letter-spacing:.03em;margin:.9rem 0 .3rem}
.acc-body h3 .cnt,.tag,.cnt{display:inline-block;background:var(--chip);border-radius:10px;padding:0 .5rem;font-size:.72rem;font-weight:600;margin-left:.3rem;font-variant:normal}
.meta{display:grid;grid-template-columns:auto 1fr;gap:.3rem .9rem;margin:.4rem 0;font-size:.92rem}
.meta dt{font-weight:700;color:var(--accent2);white-space:nowrap} .meta dd{margin:0}
.abstract{font-style:italic;color:var(--muted);margin:.7rem 0 0}
.p{margin:.4rem 0;font-size:.92rem}
ul.def,ul.notes,ul.bibl{margin:.3rem 0;padding-left:1.1rem;font-size:.9rem}
ul.def li,ul.notes li,ul.bibl li{margin:.3rem 0}
.sig{font-family:ui-monospace,monospace;font-size:.82em;color:var(--accent);font-weight:700}
.tag{background:var(--chip);color:var(--muted);margin-right:.3rem}
.tax{display:grid;grid-template-columns:auto 1fr;gap:.25rem .9rem;font-size:.9rem}
.tax dt{font-family:ui-monospace,monospace;font-size:.82rem;color:var(--accent2);font-weight:700;white-space:nowrap}.tax dd{margin:0}
.foot{margin-top:1.4rem;padding-top:1rem;border-top:1px solid var(--rule);color:var(--muted);font-size:.78rem}
code{background:var(--card);border:1px solid var(--rule);padding:.02rem .3rem;border-radius:4px;font-size:.88em}
@media (max-width:820px){
  .layout{grid-template-columns:1fr}
  .toc{position:static;flex-direction:row;flex-wrap:wrap;border-bottom:1px solid var(--rule);padding-bottom:.6rem}
  .meta,.tax{grid-template-columns:1fr}
}
  </xsl:template>

  <!-- ===================== JS ===================== -->
  <xsl:template name="js">
<xsl:text disable-output-escaping="yes"><![CDATA[
(function(){
  var accs=[].slice.call(document.querySelectorAll('details.acc'));
  var exp=document.getElementById('exp'), col=document.getElementById('col');
  if(exp) exp.onclick=function(){accs.forEach(function(d){d.open=true;});};
  if(col) col.onclick=function(){accs.forEach(function(d){d.open=false;});};
  // apri la sezione bersaglio quando si clicca nell'indice o si arriva con #ancora
  function openHash(){ if(location.hash){ var el=document.querySelector(location.hash);
    if(el&&el.tagName&&el.tagName.toLowerCase()==='details'){el.open=true;el.scrollIntoView({block:'start'});} } }
  document.querySelectorAll('.toc a').forEach(function(a){a.addEventListener('click',function(){
    var el=document.querySelector(a.getAttribute('href')); if(el)el.open=true;});});
  window.addEventListener('load',openHash);
  window.addEventListener('hashchange',openHash);
})();
]]></xsl:text>
  </xsl:template>

</xsl:stylesheet>
