<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="about:legacy-compat"/>
  <xsl:strip-space elements="tei:choice tei:app tei:subst tei:listBibl tei:body tei:div tei:listWit"/>
  <xsl:key name="cat" match="tei:category" use="@xml:id"/>

  <!-- ===================== SCHELETRO ===================== -->
  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="//tei:titlePart[@type='main']"/> — edizione di lettura</title>
        <style><xsl:call-template name="css"/></style>
      </head>
      <body class="mode-i show-app show-stati show-enc">
        <header class="toolbar">
          <div class="tb-title"><xsl:value-of select="//tei:titlePart[@type='main']"/></div>
          <div class="tb-controls">
            <div class="seg" role="group" aria-label="Vista">
              <button id="mI" class="on" type="button">Interpretativo</button>
              <button id="mF" type="button">A fronte</button>
              <button id="mD" type="button">Diplomatico</button>
            </div>
            <button id="bApp" class="toggle on" type="button" title="Marcatori d'apparato genetico">Apparato</button>
            <button id="bStati" class="toggle on" type="button" title="Evidenzia gli stati mistici">Stati mistici</button>
            <button id="bEnc" class="toggle on" type="button" title="Evidenzia i punti di codifica (diplomatico↔interpretativo)">Codifica</button>
            <span class="search-wrap"><input id="q" class="search" type="search" placeholder="Cerca nel testo…" aria-label="Cerca nel testo"/><span id="qcount" class="qcount"></span></span>
          </div>
        </header>

        <nav class="chapnav" aria-label="Capitoli">
          <a href="#scheda" class="nav-sch">Scheda ▾</a>
          <a href="castello-anima-teiHeader.html" class="nav-hdr">🗂 teiHeader ↗</a>
          <xsl:for-each select="//tei:body//tei:div[@type='preface' or @type='chapter']">
            <a href="#{generate-id()}"><xsl:value-of select="normalize-space(tei:head)"/></a>
          </xsl:for-each>
          <a href="#legenda" class="nav-leg">Stati mistici ▾</a>
        </nav>

        <main class="page">
          <xsl:call-template name="scheda"/>
          <xsl:apply-templates select="//tei:text"/>
        </main>

        <section class="legenda" id="legenda">
          <h2>Stati mistici — legenda</h2>
          <p class="leg-intro">Vocabolario controllato ancorato al testo con <code>term/@ref</code>;
             definizioni dal <code>catDesc</code> della tassonomia.</p>
          <dl>
            <xsl:for-each select="//tei:taxonomy[@xml:id='stati-mistici']/tei:category">
              <xsl:variable name="id" select="@xml:id"/>
              <xsl:variable name="n" select="count(//tei:body//tei:term[substring-after(@ref,'#')=$id])"/>
              <xsl:if test="$n &gt; 0">
                <dt id="stato-{$id}"><xsl:value-of select="$id"/><span class="cnt"><xsl:value-of select="$n"/></span></dt>
                <dd><xsl:value-of select="normalize-space(tei:catDesc)"/></dd>
              </xsl:if>
            </xsl:for-each>
          </dl>
          <p class="leg-na">Dichiarati nel vocabolario ma non ancora attestati in MC-1:
            <xsl:for-each select="//tei:taxonomy[@xml:id='stati-mistici']/tei:category">
              <xsl:variable name="id" select="@xml:id"/>
              <xsl:if test="count(//tei:body//tei:term[substring-after(@ref,'#')=$id])=0">
                <code><xsl:value-of select="$id"/></code><xsl:text> </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </p>
        </section>

        <footer class="colophon">
          <p class="gen">Pagina di lettura generata da <code>castello-anima.xsl</code> sul master
             risolto TEI. Fonte autorevole: i dati TEI in <code>data/</code>.</p>
        </footer>

        <div id="pop" class="popover" hidden="hidden"></div>
        <script><xsl:call-template name="js"/></script>
      </body>
    </html>
  </xsl:template>

  <!-- ===================== SCHEDA DELL'EDIZIONE (teiHeader) ===================== -->
  <xsl:template name="scheda">
    <details class="scheda" id="scheda">
      <summary>Scheda dell'edizione <span class="sch-hint">— clic per aprire/chiudere</span></summary>
      <div class="scheda-body">
        <button type="button" class="sch-close" id="schClose" title="Chiudi la scheda">Chiudi ✕</button>

        <xsl:if test="//tei:encodingDesc/tei:ab">
          <p class="abstract"><xsl:value-of select="normalize-space(//tei:encodingDesc/tei:ab)"/></p>
        </xsl:if>

        <dl class="meta">
          <dt>Opera</dt><dd><xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/></dd>
          <dt>Autrice</dt>
          <dd><xsl:value-of select="normalize-space((//tei:titleStmt/tei:author)[1])"/></dd>
          <dt>Testimone</dt>
          <dd>Autografo unico —
            <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:settlement)"/>,
            <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:repository)"/>,
            ms. <xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno)"/>
            (<xsl:value-of select="normalize-space(//tei:bibl[@xml:id='castello-anima']/tei:date)"/>).</dd>
          <dt>Pubblicazione</dt>
          <dd><xsl:value-of select="normalize-space(//tei:publicationStmt/tei:publisher)"/>
            <xsl:if test="//tei:publicationStmt/tei:date/@when">, <xsl:value-of select="//tei:publicationStmt/tei:date/@when"/></xsl:if>
            <xsl:if test="//tei:publicationStmt/tei:idno"> · <xsl:value-of select="normalize-space(//tei:publicationStmt/tei:idno)"/></xsl:if></dd>
          <dt>Responsabilità</dt>
          <dd><xsl:value-of select="normalize-space(//tei:respStmt/tei:resp)"/> —
              <xsl:value-of select="normalize-space(//tei:respStmt/tei:name)"/></dd>
          <dt>Licenza</dt>
          <dd><xsl:value-of select="normalize-space(//tei:availability/tei:licence)"/></dd>
        </dl>

        <xsl:if test="//tei:projectDesc/tei:p">
          <h3>Il progetto e il modello</h3>
          <xsl:for-each select="//tei:projectDesc/tei:p"><p class="sch-p"><xsl:value-of select="normalize-space(.)"/></p></xsl:for-each>
        </xsl:if>

        <xsl:if test="//tei:editorialDecl">
          <h3>Criteri editoriali</h3>
          <xsl:for-each select="//tei:editorialDecl/tei:p"><p class="sch-p"><xsl:value-of select="normalize-space(.)"/></p></xsl:for-each>
          <ul class="crit">
            <xsl:if test="//tei:editorialDecl/tei:correction"><li><b>Correzione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:correction)"/></li></xsl:if>
            <xsl:if test="//tei:editorialDecl/tei:hyphenation"><li><b>Sillabazione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:hyphenation)"/></li></xsl:if>
            <xsl:if test="//tei:editorialDecl/tei:normalization"><li><b>Normalizzazione</b> — <xsl:value-of select="normalize-space(//tei:editorialDecl/tei:normalization)"/></li></xsl:if>
          </ul>
        </xsl:if>

        <h3>Stati genetici dell'autografo <span class="att-note">— in grigio: dichiarati nel modello, non attestati in MC-1</span></h3>
        <xsl:for-each select="//tei:listWit/tei:listWit">
          <p class="wit-grp"><b><xsl:value-of select="normalize-space(tei:head)"/></b></p>
          <ul class="wit">
            <xsl:for-each select="tei:witness">
              <xsl:variable name="wid" select="@xml:id"/>
              <li>
                <xsl:if test="count(//tei:body//*[@wit=concat('#',$wid)])=0"><xsl:attribute name="class">na</xsl:attribute></xsl:if>
                <span class="sig"><xsl:value-of select="$wid"/></span>
                <xsl:if test="count(//tei:body//*[@wit=concat('#',$wid)])=0"><span class="badge-na">non attestato in MC-1</span></xsl:if>
                <xsl:text> — </xsl:text><xsl:value-of select="normalize-space(.)"/></li>
            </xsl:for-each>
          </ul>
        </xsl:for-each>

        <h3>Mani <span class="att-note">— in grigio: dichiarate, non attestate in MC-1</span></h3>
        <ul class="hands">
          <xsl:for-each select="//tei:handNote">
            <xsl:variable name="hid" select="@xml:id"/>
            <li>
              <xsl:if test="count(//tei:body//*[@hand=concat('#',$hid)])=0"><xsl:attribute name="class">na</xsl:attribute></xsl:if>
              <span class="sig"><xsl:value-of select="$hid"/></span>
              <span class="med"> (<xsl:value-of select="@medium"/>)</span>
              <xsl:if test="count(//tei:body//*[@hand=concat('#',$hid)])=0"><span class="badge-na">non attestata in MC-1</span></xsl:if>
              <xsl:text>: </xsl:text><xsl:value-of select="normalize-space(.)"/></li>
          </xsl:for-each>
        </ul>

        <h3>Fonti dottrinali</h3>
        <ul class="bibl">
          <xsl:for-each select="//tei:listBibl[@type='fontes']/tei:bibl">
            <li><xsl:value-of select="normalize-space(.)"/></li>
          </xsl:for-each>
        </ul>

        <xsl:if test="//tei:listBibl[@type='studi']">
          <h3>Bibliografia critica</h3>
          <ul class="bibl">
            <xsl:for-each select="//tei:listBibl[@type='studi']/tei:bibl">
              <li><xsl:apply-templates select="node()" mode="bibl"/></li>
            </xsl:for-each>
          </ul>
        </xsl:if>

        <xsl:if test="//tei:langUsage/tei:language">
          <h3>Lingue</h3>
          <ul class="langs">
            <xsl:for-each select="//tei:langUsage/tei:language">
              <li><span class="sig"><xsl:value-of select="@xml:id"/></span>: <xsl:value-of select="normalize-space(.)"/></li>
            </xsl:for-each>
          </ul>
        </xsl:if>

        <xsl:if test="//tei:particDesc//tei:person or //tei:particDesc//tei:org">
          <h3>Persone ed enti citati</h3>
          <ul class="persons">
            <xsl:for-each select="//tei:particDesc//tei:person">
              <li><b><xsl:value-of select="normalize-space((.//tei:persName | .//tei:name)[1])"/></b><xsl:if test="tei:note"> — <xsl:value-of select="normalize-space((tei:note)[1])"/></xsl:if></li>
            </xsl:for-each>
            <xsl:for-each select="//tei:particDesc//tei:org">
              <li><b><xsl:value-of select="normalize-space((.//tei:orgName | .//tei:name)[1])"/></b><xsl:if test="tei:note"> — <xsl:value-of select="normalize-space((tei:note)[1])"/></xsl:if></li>
            </xsl:for-each>
          </ul>
        </xsl:if>

        <xsl:if test="//tei:revisionDesc/tei:change">
          <h3>Storia redazionale</h3>
          <ul class="hist">
            <xsl:for-each select="//tei:revisionDesc/tei:change">
              <li><xsl:if test="@when"><span class="when"><xsl:value-of select="@when"/></span><xsl:text> </xsl:text></xsl:if><xsl:value-of select="normalize-space(.)"/></li>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </div>
    </details>
  </xsl:template>

  <!-- resa dei bibl (title in corsivo) -->
  <xsl:template match="tei:title" mode="bibl"><i><xsl:apply-templates/></i></xsl:template>
  <xsl:template match="tei:author|tei:pubPlace|tei:publisher|tei:date|tei:biblScope" mode="bibl"><xsl:apply-templates/></xsl:template>
  <xsl:template match="text()" mode="bibl"><xsl:value-of select="."/></xsl:template>

  <!-- ===================== STRUTTURA DEL TESTO ===================== -->
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
    <div class="colhead">
      <div class="ch-num"></div>
      <div class="ch-d">Diplomatico (ms.)</div>
      <div class="ch-i">Interpretativo</div>
    </div>
  </xsl:template>

  <xsl:template match="tei:body"><xsl:apply-templates/></xsl:template>

  <xsl:template match="tei:div[@type='book']">
    <div class="book">
      <p class="incipit"><xsl:value-of select="normalize-space(tei:head)"/></p>
      <xsl:apply-templates select="*[not(self::tei:head)]"/>
    </div>
  </xsl:template>

  <xsl:template match="tei:div[@type='preface'] | tei:div[@type='chapter']">
    <section class="chapter" id="{generate-id()}">
      <h2 class="chap-title"><xsl:value-of select="normalize-space(tei:head)"/></h2>
      <xsl:if test="tei:argument">
        <aside class="argument"><xsl:apply-templates select="tei:argument/tei:p/node() | tei:argument/text()[normalize-space()]"/></aside>
      </xsl:if>
      <xsl:apply-templates select="tei:p"/>
    </section>
  </xsl:template>

  <xsl:template match="tei:p">
    <div class="prow">
      <xsl:if test="@n"><xsl:attribute name="id">p<xsl:value-of select="@n"/></xsl:attribute></xsl:if>
      <div class="pnum"><xsl:if test="@n"><a class="pnlink" href="#p{@n}" title="Collegamento a questo paragrafo">§<xsl:value-of select="@n"/></a></xsl:if></div>
      <div class="pcell dipl" data-lbl="Diplomatico"><xsl:apply-templates/></div>
      <div class="pcell interp" data-lbl="Interpretativo"><xsl:apply-templates/></div>
    </div>
  </xsl:template>

  <!-- ===================== TRASCRIZIONE A DUE LIVELLI ===================== -->
  <xsl:template match="tei:choice[tei:orig and tei:reg]">
    <xsl:choose>
      <xsl:when test="normalize-space(tei:orig) != normalize-space(tei:reg)">
        <span class="ch vdiff trg" tabindex="0"
          ><span class="lv-i"><xsl:apply-templates select="tei:reg/node()"/></span
          ><span class="lv-d"><xsl:apply-templates select="tei:orig/node()"/></span
          ><span class="pc" hidden="hidden"><b>Regolarizzazione grafica</b>Ms. (diplomatico): «<xsl:value-of select="normalize-space(tei:orig)"/>» → Testo (interpretativo): «<xsl:value-of select="normalize-space(tei:reg)"/>»</span></span>
      </xsl:when>
      <xsl:otherwise>
        <span class="ch"
          ><span class="lv-i"><xsl:apply-templates select="tei:reg/node()"/></span
          ><span class="lv-d"><xsl:apply-templates select="tei:orig/node()"/></span></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- scioglimento di abbreviazione: intervento, evidenziato + spiegazione -->
  <xsl:template match="tei:choice[tei:abbr and tei:expan]">
    <span class="ch exp trg" tabindex="0"
      ><span class="lv-i"><xsl:apply-templates select="tei:expan/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:abbr/node()"/></span
      ><span class="pc" hidden="hidden"><b>Scioglimento d'abbreviazione</b
        >Ms.: «<xsl:value-of select="normalize-space(tei:abbr)"/>» → Testo: «<xsl:value-of select="normalize-space(tei:expan)"/>»</span></span>
  </xsl:template>

  <!-- correzione editoriale (sic/corr): intervento, evidenziato + spiegazione -->
  <xsl:template match="tei:choice[tei:sic and tei:corr]">
    <span class="ch corr trg" tabindex="0"
      ><span class="lv-i"><xsl:apply-templates select="tei:corr/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:sic/node()"/></span
      ><span class="pc" hidden="hidden"><b>Correzione editoriale (emendatio)</b
        >Ms.: «<xsl:value-of select="normalize-space(tei:sic)"/>» → Testo: «<xsl:value-of select="normalize-space(tei:corr)"/>»</span></span>
  </xsl:template>

  <!-- ===================== APPARATO GENETICO: marcatore in-testo ===================== -->
  <xsl:template match="tei:app">
    <span class="lemwrap"><xsl:apply-templates select="tei:lem/node()"/><xsl:if test="tei:rdg"
      ><sup class="appmark trg" tabindex="0"><xsl:value-of select="count(preceding::tei:app)+1"/><span
          class="pc" hidden="hidden"><b>Apparato genetico · §<xsl:value-of
              select="ancestor::tei:p/@n"/></b>Testo (Tc): <i><xsl:apply-templates
              select="tei:lem/node()" mode="plain"/></i><br/>Stato genetico (Tb0): <span
              class="gen-state"><xsl:apply-templates select="tei:rdg/node()"/></span></span></sup></xsl:if></span>
  </xsl:template>
  <!-- versione "piana" del lemma per il popover (senza marcatore annidato) -->
  <xsl:template match="tei:app" mode="plain"><xsl:apply-templates select="tei:lem/node()" mode="plain"/></xsl:template>
  <xsl:template match="tei:choice" mode="plain"><xsl:apply-templates select="tei:reg/node()|tei:expan/node()|tei:corr/node()" mode="plain"/></xsl:template>
  <xsl:template match="tei:lb|tei:pb|tei:fw|tei:note" mode="plain"/>
  <xsl:template match="tei:term" mode="plain"><xsl:apply-templates mode="plain"/></xsl:template>
  <xsl:template match="text()" mode="plain"><xsl:value-of select="."/></xsl:template>

  <!-- ===================== FENOMENI (nell'apparato / rdg) ===================== -->
  <xsl:template match="tei:del"><del class="del"><xsl:apply-templates/></del></xsl:template>
  <xsl:template match="tei:add"><span class="add" title="aggiunta"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:subst"><xsl:apply-templates/></xsl:template>
  <xsl:template match="tei:retrace"><span class="retrace"
      title="rivergatura: ripasso a inchiostro, testo invariato"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:gap"><span class="gap" title="guasto: illeggibile">⟨…⟩</span></xsl:template>
  <xsl:template match="tei:unclear"><span class="unclear" title="lettura incerta"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:supplied"><span class="supplied"
      title="integrazione editoriale (@cert={@cert})">[<xsl:apply-templates/>]</span></xsl:template>

  <!-- ===================== STATI MISTICI ===================== -->
  <xsl:template match="tei:term[@ref]">
    <xsl:variable name="id" select="substring-after(@ref,'#')"/>
    <span class="term trg" data-state="{$id}" tabindex="0"><xsl:apply-templates/><span
        class="pc" hidden="hidden"><b>Stato mistico · <xsl:value-of select="$id"/></b
        ><xsl:value-of select="normalize-space(key('cat',$id)/tei:catDesc)"/></span></span>
  </xsl:template>
  <xsl:template match="tei:term"><span class="term-plain"><xsl:apply-templates/></span></xsl:template>

  <!-- ===================== SEGNALETICA ===================== -->
  <xsl:template match="tei:pb">
    <span class="pb" title="carta {@n}"><span class="pb-lbl"><xsl:value-of select="@n"/></span></span>
  </xsl:template>
  <xsl:template match="tei:lb">
    <xsl:choose>
      <xsl:when test="@break='no'"><span class="lb nobreak"></span></xsl:when>
      <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:fw">
    <span class="fw" title="richiamo / segnaletica di pagina"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Note materiali come richiami cliccabili -->
  <xsl:template match="tei:note[@place='foot']">
    <sup class="fnref trg" tabindex="0">*<span class="pc" hidden="hidden"><b>Nota materiale</b><xsl:apply-templates select="node()"/></span></sup>
  </xsl:template>
  <xsl:template match="tei:note"/>

  <xsl:template match="tei:quote"><q class="quote"><xsl:apply-templates/></q></xsl:template>
  <xsl:template match="tei:cit"><span class="cit"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:ref"><span class="ref"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:hi"><em><xsl:apply-templates/></em></xsl:template>
  <xsl:template match="tei:teiHeader"/>

  <!-- ===================== CSS ===================== -->
  <xsl:template name="css">
:root{
  --bg:#faf8f4; --fg:#241f1a; --muted:#6f665b; --rule:#e4ddd0;
  --accent:#7a4f22; --accent2:#3f5f4b; --card:#fffdf9;
  --term:#e7efe8; --term-b:#b9d2bf; --add:#e3edf7; --supp:#efe6d2;
  --appbg:#f3ecdd; --del:#a83232; --dipbg:#f4efe6; --mark:#8a5a1f;
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#15120d; --fg:#ece5d9; --muted:#a49a8b; --rule:#352d22;
    --accent:#d9b676; --accent2:#93bc9f; --card:#1d1913; --term:#1d281f;
    --term-b:#37503f; --add:#172633; --supp:#2b2416; --appbg:#241d13;
    --del:#e88686; --dipbg:#1a1610; --mark:#e0b878;
  }
}
:root[data-theme="dark"]{
  --bg:#15120d; --fg:#ece5d9; --muted:#a49a8b; --rule:#352d22;
  --accent:#d9b676; --accent2:#93bc9f; --card:#1d1913; --term:#1d281f;
  --term-b:#37503f; --add:#172633; --supp:#2b2416; --appbg:#241d13;
  --del:#e88686; --dipbg:#1a1610; --mark:#e0b878;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);
  font-family:"Iowan Old Style","Palatino Linotype",Palatino,Georgia,serif;line-height:1.75;font-size:18px}
.toolbar{position:sticky;top:0;z-index:20;display:flex;flex-wrap:wrap;gap:.6rem;align-items:center;
  justify-content:space-between;padding:.55rem 1rem;background:var(--card);border-bottom:1px solid var(--rule)}
.tb-title{font-weight:600;font-size:.9rem;color:var(--accent)}
.tb-controls{display:flex;gap:.4rem;flex-wrap:wrap;align-items:center}
.seg{display:inline-flex;border:1px solid var(--rule);border-radius:8px;overflow:hidden}
.seg button{border:0;background:transparent;color:var(--muted);padding:.34rem .7rem;font:inherit;font-size:.8rem;cursor:pointer}
.seg button.on{background:var(--accent);color:#fff}
button.toggle{border:1px solid var(--rule);background:transparent;color:var(--muted);border-radius:8px;
  padding:.34rem .7rem;font:inherit;font-size:.8rem;cursor:pointer}
button.toggle.on{color:#fff;background:var(--accent2);border-color:var(--accent2)}
.chapnav{position:sticky;top:2.9rem;z-index:19;display:flex;flex-wrap:wrap;gap:.1rem .2rem;padding:.4rem 1rem;
  background:var(--bg);border-bottom:1px solid var(--rule);font-size:.78rem}
.chapnav a{color:var(--accent2);text-decoration:none;padding:.15rem .5rem;border-radius:6px}
.chapnav a:hover{background:var(--card);color:var(--accent)}
.chapnav .nav-sch{color:var(--accent);font-weight:600} .chapnav .nav-leg{margin-left:auto;color:var(--accent)}
.page{max-width:50rem;margin:0 auto;padding:1.4rem 1.2rem 3rem}
/* SCHEDA */
.scheda{background:var(--card);border:1px solid var(--rule);border-radius:10px;margin:1rem 0 1.4rem}
.scheda>summary{cursor:pointer;padding:.7rem 1rem;font-variant:small-caps;letter-spacing:.04em;
  color:var(--accent);font-weight:600}
.scheda-body{padding:.2rem 1.2rem 1rem;font-size:.92rem}
.scheda h3{font-size:.95rem;color:var(--accent2);font-variant:small-caps;margin:1rem 0 .3rem;
  border-bottom:1px solid var(--rule);padding-bottom:.2rem}
.meta{display:grid;grid-template-columns:auto 1fr;gap:.25rem .9rem;margin:.4rem 0}
.meta dt{font-weight:700;color:var(--accent2)} .meta dd{margin:0}
.scheda ul{margin:.2rem 0;padding-left:1.1rem} .scheda li{margin:.2rem 0}
.scheda .sig{font-family:ui-monospace,monospace;font-size:.82em;color:var(--accent);font-weight:700}
.scheda .med{color:var(--muted);font-size:.85em} .scheda .lic{margin-top:1rem;color:var(--muted)}
.wit-grp{margin:.6rem 0 .1rem;color:var(--fg)}
.scheda .abstract{font-style:italic;color:var(--muted);margin:.2rem 0 .7rem;padding-right:5rem}
.scheda .sch-p{margin:.35rem 0} .scheda .crit li{margin:.25rem 0}
.scheda .when{font-family:ui-monospace,monospace;font-size:.8em;color:var(--accent2);margin-right:.3rem}
.sch-hint{font-variant:normal;font-weight:400;font-size:.76rem;color:var(--muted);letter-spacing:0}
.sch-close{float:right;border:1px solid var(--rule);background:var(--bg);color:var(--muted);
  border-radius:8px;padding:.22rem .6rem;font:inherit;font-size:.78rem;cursor:pointer;margin:.2rem 0 .4rem}
.sch-close:hover{color:var(--fg);border-color:var(--accent2)}
/* TITLEPAGE */
.titlepage{text-align:center;margin:1rem 0 1.8rem;padding-bottom:1.2rem;border-bottom:2px solid var(--rule)}
.titlepage h1{font-size:2rem;margin:.2rem 0;color:var(--accent)}
.subtitle{color:var(--muted);font-size:.95rem;font-style:italic}
.author{margin-top:.7rem;font-variant:small-caps;letter-spacing:.03em}
.incipit{font-style:italic;color:var(--muted);text-align:center;margin:1rem auto 1.6rem;max-width:40rem}
/* CAPITOLI — titoli ben leggibili */
.chapter{margin:2.2rem 0}
.chap-title{font-size:1.6rem;font-weight:700;color:var(--fg);text-align:center;letter-spacing:.01em;
  margin:1.6rem 0 .2rem;padding:.3rem 0}
.chap-title:after{content:"";display:block;width:3rem;height:3px;background:var(--accent);
  margin:.5rem auto 0;border-radius:2px}
.argument{font-style:italic;color:var(--muted);background:var(--card);border-left:3px solid var(--accent2);
  padding:.55rem .9rem;border-radius:0 6px 6px 0;margin:.9rem 0 1.2rem;font-size:.93rem}
/* GRIGLIA / VISTE */
.colhead,.prow{display:grid;gap:1.2rem;align-items:start}
body.mode-i .colhead,body.mode-i .prow,body.mode-d .colhead,body.mode-d .prow{grid-template-columns:2.2rem 1fr}
body.mode-f .colhead,body.mode-f .prow{grid-template-columns:2.2rem 1fr 1fr}
.colhead{position:sticky;top:5.4rem;z-index:12;background:var(--bg);padding:.3rem 0;
  border-bottom:1px solid var(--rule);margin-bottom:.8rem;font-size:.68rem;font-variant:small-caps;
  letter-spacing:.05em;color:var(--muted)}
body:not(.mode-f) .colhead{display:none}
.colhead .ch-d{color:var(--muted)} .colhead .ch-i{color:var(--accent)}
.prow{margin-bottom:.4rem}
body.mode-f .prow{padding-bottom:.5rem;border-bottom:1px dotted var(--rule)}
.pnum{color:var(--accent2);font-size:.7rem;font-weight:700;font-family:ui-monospace,monospace;padding-top:.28rem;user-select:none}
.pcell{text-align:justify;hyphens:auto}
body.mode-i .pcell.dipl,body.mode-d .pcell.interp{display:none}
body.mode-f .pcell.dipl{color:var(--muted);background:var(--dipbg);border-radius:6px;padding:.3rem .6rem;font-size:.96em}
/* livelli mostrati per colonna */
.pcell.dipl .lv-i{display:none} .pcell.interp .lv-d{display:none}
.pcell.interp .fw{display:none}
/* in vista diplomatica singola, mostra orig e nascondi reg dentro la colonna interp? no: usiamo la cella dipl */
/* punti di codifica diplomatico↔interpretativo (toggle "Codifica") */
.ch.corr,.ch.exp,.ch.vdiff{cursor:pointer}
body.show-enc .ch.corr>.lv-i,body.show-enc .ch.corr>.lv-d{border-bottom:2px dotted var(--del)}
body.show-enc .ch.exp>.lv-i,body.show-enc .ch.exp>.lv-d{border-bottom:2px dotted var(--accent)}
body.show-enc .ch.vdiff>.lv-i,body.show-enc .ch.vdiff>.lv-d{border-bottom:1px dashed var(--accent2)}
.ch.corr .pc,.ch.exp .pc,.ch.vdiff .pc{display:none}
/* apparato: marcatore in-testo */
.appmark{color:#fff;background:var(--mark);border-radius:4px;padding:0 .28em;margin-left:.1em;
  font-size:.6em;font-family:ui-monospace,monospace;cursor:pointer;vertical-align:super;line-height:1;user-select:none}
body:not(.show-app) .appmark{display:none}
.pcell.dipl .appmark{display:none}
.gen-state{}
.del{color:var(--del);text-decoration:line-through}
.add{background:var(--add);border-radius:3px;padding:0 .1em}
.gap{color:var(--muted)} .unclear{border-bottom:1px dotted var(--muted)}
.supplied{color:var(--accent2)} .retrace{border-bottom:1px solid var(--accent)}
/* stati mistici (evidenziati in entrambe le colonne) */
.term{border-radius:3px;padding:0 .12em;cursor:pointer}
body.show-stati .term{background:var(--term);border-bottom:1.5px solid var(--term-b)}
body.show-stati .term:hover{background:var(--term-b)}
.term .pc{display:none}
.argument .lv-d,.argument .fw,.argument .appmark,.argument .pc{display:none}
/* segnaletica */
.pb{display:inline-block;vertical-align:middle;margin:0 .2rem;user-select:none}
.pb-lbl{font-family:ui-monospace,monospace;font-size:.6rem;color:#fff;background:var(--accent2);border-radius:4px;padding:.02rem .3rem}
.fw{font-size:.72rem;color:var(--muted);font-style:italic}
.fnref{color:var(--accent2);cursor:pointer;font-size:.8em;vertical-align:super}
.pcell.dipl .fnref{display:none}
.fnref .pc{display:none}
/* legenda */
.legenda{max-width:52rem;margin:2rem auto 0;padding:1.4rem 1.2rem;border-top:1px solid var(--rule)}
.legenda h2{font-size:1.05rem;color:var(--accent);font-variant:small-caps}
.leg-intro{font-size:.82rem;color:var(--muted)}
.legenda dl{display:grid;grid-template-columns:auto 1fr;gap:.3rem .9rem;font-size:.9rem}
.legenda dt{font-weight:700;color:var(--accent2);font-family:ui-monospace,monospace;font-size:.85rem;white-space:nowrap}
.legenda dt .cnt{display:inline-block;margin-left:.3rem;background:var(--term);border-radius:10px;padding:0 .45rem;font-size:.72rem}
.legenda dd{margin:0}
.colophon{max-width:52rem;margin:1rem auto 3rem;padding:1.2rem;color:var(--muted);font-size:.78rem;text-align:center;border-top:1px solid var(--rule)}
.colophon code{background:var(--card);padding:.05rem .3rem;border-radius:4px}
/* popover */
.popover{position:fixed;z-index:40;max-width:23rem;background:var(--card);color:var(--fg);
  border:1px solid var(--accent2);border-radius:10px;padding:.7rem .9rem;font-size:.88rem;
  box-shadow:0 12px 34px rgba(0,0,0,.28);line-height:1.55}
.popover b{color:var(--accent2);font-size:.82em;font-variant:small-caps;letter-spacing:.03em;
  display:block;margin-bottom:.3rem}
.popover i{color:var(--accent)}
.popover .del{color:var(--del)} .popover .add{background:var(--add)}
/* ricerca */
.search-wrap{display:inline-flex;align-items:center;gap:.3rem}
.search{border:1px solid var(--rule);background:var(--bg);color:var(--fg);border-radius:8px;
  padding:.3rem .6rem;font:inherit;font-size:.8rem;width:11rem;max-width:40vw}
.qcount{font-size:.72rem;color:var(--muted);min-width:3.4rem}
mark.hit{background:#ffd54a;color:#111;border-radius:2px;padding:0 .05em}
/* deep-link ai § */
.pnlink{color:var(--accent2);text-decoration:none}
.pnlink:hover{text-decoration:underline}
.prow,.chapter{scroll-margin-top:6.6rem}
/* attestazione nella scheda */
.att-note{font-variant:normal;font-weight:400;color:var(--muted);font-size:.78em;letter-spacing:0}
.scheda li.na{color:var(--muted);opacity:.7}
.scheda li.na .sig{color:var(--muted)}
.badge-na{display:inline-block;font-size:.66rem;font-variant:small-caps;letter-spacing:.03em;
  color:var(--muted);border:1px solid var(--rule);border-radius:8px;padding:0 .4rem;margin:0 .3rem}
.leg-na{font-size:.82rem;color:var(--muted);margin-top:.8rem}
.leg-na code{background:var(--card);padding:.05rem .35rem;border-radius:4px;margin-right:.2rem}
/* pagina teiHeader */
.linkbtn{text-decoration:none;color:#fff;background:var(--accent);border-radius:8px;padding:.34rem .8rem;font-size:.82rem}
.linkbtn:hover{background:var(--accent2)}
.page.hdr{max-width:56rem}
.hdr-h1{font-size:1.7rem;color:var(--accent);text-align:center;margin:.6rem 0 .2rem}
.hdr-h1 code{font-size:.8em;background:var(--card);padding:.05rem .35rem;border-radius:5px}
.hdr-sub{text-align:center;color:var(--muted);font-style:italic;margin-bottom:1.4rem}
.hdr-doc .abstract{font-style:italic;color:var(--muted)}
.hsec{margin:1.5rem 0;padding-top:.7rem;border-top:2px solid var(--rule)}
.hsec>h2{font-size:1.2rem;color:var(--accent);margin:.2rem 0 .6rem}
.hsec h3{font-size:.95rem;color:var(--accent2);font-variant:small-caps;letter-spacing:.03em;margin:.9rem 0 .25rem}
.hsec .meta dt{white-space:nowrap}
.notes{padding-left:1.1rem} .notes li{margin:.35rem 0}
.tax{display:grid;grid-template-columns:auto 1fr;gap:.25rem .9rem;font-size:.9rem}
.tax dt{font-family:ui-monospace,monospace;font-size:.82rem;color:var(--accent2);font-weight:700;white-space:nowrap}
.tax dd{margin:0}
@media(max-width:640px){.tax{grid-template-columns:1fr}}
@media (max-width:780px){
  .colhead{display:none!important}
  body.mode-f .prow{grid-template-columns:1fr!important;gap:.3rem}
  body.mode-f .pnum{padding-top:0}
  body.mode-f .pcell{padding:.4rem .6rem;border-radius:6px}
  body.mode-f .pcell::before{content:attr(data-lbl);display:block;font-size:.62rem;
    font-variant:small-caps;color:var(--accent2);margin-bottom:.15rem}
  .meta,.legenda dl{grid-template-columns:1fr}
}
  </xsl:template>

  <!-- ===================== JS ===================== -->
  <xsl:template name="js">
<xsl:text disable-output-escaping="yes"><![CDATA[
(function(){
  var b=document.body;
  // viste (segmented)
  var modes={mI:'mode-i',mF:'mode-f',mD:'mode-d'};
  function setMode(on){
    for(var k in modes){b.classList.remove(modes[k]);document.getElementById(k).classList.remove('on');}
    b.classList.add(modes[on]);document.getElementById(on).classList.add('on');
  }
  for(var k in modes)(function(id){document.getElementById(id).onclick=function(){setMode(id);};})(k);
  // toggles
  function tog(id,cls){var el=document.getElementById(id);el.onclick=function(){
    b.classList.toggle(cls);el.classList.toggle('on',b.classList.contains(cls));};}
  tog('bApp','show-app'); tog('bStati','show-stati'); tog('bEnc','show-enc');
  // chiusura scheda
  var sc=document.getElementById('schClose'), sch=document.getElementById('scheda');
  if(sc&&sch) sc.onclick=function(){sch.open=false;sch.scrollIntoView&&sch.scrollIntoView({block:'start'});};
  // popover unico
  var pop=document.getElementById('pop');
  function hide(){pop.hidden=true;}
  document.addEventListener('click',function(e){
    var t=e.target.closest?e.target.closest('.trg'):null;
    if(!t){ if(!e.target.closest||!e.target.closest('#pop')) hide(); return; }
    var pc=t.querySelector(':scope > .pc') || t.querySelector('.pc');
    if(!pc){hide();return;}
    e.stopPropagation();
    pop.innerHTML=pc.innerHTML;
    pop.hidden=false;
    var r=t.getBoundingClientRect(), pw=Math.min(window.innerWidth*0.92,368);
    var x=Math.min(r.left, window.innerWidth-pw-12);
    var y=r.bottom+8; if(y+150>window.innerHeight) y=Math.max(8,r.top-8-150);
    pop.style.left=Math.max(8,x)+'px'; pop.style.top=y+'px'; pop.style.maxWidth=pw+'px';
  });
  document.addEventListener('keydown',function(e){if(e.key==='Escape')hide();});
  window.addEventListener('scroll',hide,{passive:true});

  // ricerca interna nel testo (colonna interpretativa)
  var q=document.getElementById('q'), qc=document.getElementById('qcount'), page=document.querySelector('.page');
  function clearMarks(){var ms=page.querySelectorAll('mark.hit');
    for(var i=0;i<ms.length;i++){var m=ms[i],p=m.parentNode;p.replaceChild(document.createTextNode(m.textContent),m);p.normalize();}}
  function esc(s){return s.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');}
  function doSearch(){
    clearMarks(); var s=q.value.trim();
    if(s.length<2){qc.textContent='';return;}
    var rx=new RegExp(esc(s),'gi'), n=0;
    var w=document.createTreeWalker(page,NodeFilter.SHOW_TEXT,{acceptNode:function(t){
      if(!t.nodeValue.trim())return NodeFilter.FILTER_REJECT;
      var p=t.parentNode;
      if(p.closest('.pc')||p.closest('.pnum')||p.closest('.pcell.dipl')||p.closest('.scheda'))return NodeFilter.FILTER_REJECT;
      return NodeFilter.FILTER_ACCEPT;}});
    var arr=[],t; while(t=w.nextNode())arr.push(t);
    for(var i=0;i<arr.length;i++){var node=arr[i]; rx.lastIndex=0; if(!rx.test(node.nodeValue))continue; rx.lastIndex=0;
      var frag=document.createDocumentFragment(),last=0,m;
      while(m=rx.exec(node.nodeValue)){frag.appendChild(document.createTextNode(node.nodeValue.slice(last,m.index)));
        var mk=document.createElement('mark');mk.className='hit';mk.textContent=m[0];frag.appendChild(mk);last=m.index+m[0].length;n++;}
      frag.appendChild(document.createTextNode(node.nodeValue.slice(last)));
      node.parentNode.replaceChild(frag,node);}
    qc.textContent=n?(n+' occ.'):'0';
    var f=page.querySelector('mark.hit'); if(f)f.scrollIntoView({block:'center'});
  }
  var td; if(q) q.addEventListener('input',function(){clearTimeout(td);td=setTimeout(doSearch,200);});

  // deep-link: scroll all'ancora (#p<n> o capitolo) al caricamento
  function goHash(){ if(location.hash){ try{var el=document.querySelector(location.hash); if(el)el.scrollIntoView({block:'start'});}catch(e){} } }
  window.addEventListener('load',goHash);
})();
]]></xsl:text>
  </xsl:template>

</xsl:stylesheet>
