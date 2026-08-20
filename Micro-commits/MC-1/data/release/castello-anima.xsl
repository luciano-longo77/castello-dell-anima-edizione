<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" encoding="UTF-8" indent="no"
      doctype-system="about:legacy-compat"/>
  <xsl:strip-space elements="tei:choice tei:app tei:subst tei:listBibl tei:body tei:div"/>

  <xsl:key name="cat" match="tei:category" use="@xml:id"/>

  <xsl:template match="/">
    <html lang="it">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="//tei:titlePart[@type='main']"/> — edizione di lettura</title>
        <style><xsl:call-template name="css"/></style>
      </head>
      <body class="show-stati">
        <header class="toolbar">
          <div class="tb-title"><xsl:value-of select="//tei:titlePart[@type='main']"/></div>
          <div class="tb-controls">
            <button id="bDip" class="toggle on" type="button" title="Mostra/nascondi la colonna diplomatica">Diplomatico</button>
            <button id="bApp" class="toggle" type="button" title="Mostra/nascondi l'apparato genetico">Apparato</button>
            <button id="bStati" class="toggle on" type="button" title="Evidenzia gli stati mistici">Stati mistici</button>
          </div>
        </header>

    
        <nav class="chapnav" aria-label="Capitoli">
          <xsl:for-each select="//tei:body//tei:div[@type='preface' or @type='chapter']">
            <a href="#{generate-id()}"><xsl:value-of select="normalize-space(tei:head)"/></a>
          </xsl:for-each>
          <a href="#legenda" class="nav-leg">Stati mistici ▾</a>
        </nav>

        <main class="page">
          <xsl:apply-templates select="//tei:text"/>
        </main>

       
        <section class="legenda" id="legenda">
          <h2>Stati mistici — legenda</h2>
          <p class="leg-intro">Vocabolario controllato ancorato al testo tramite <code>term/@ref</code>;
             le definizioni provengono dal <code>catDesc</code> della tassonomia nel teiHeader.</p>
          <dl>
            <xsl:for-each select="//tei:taxonomy[@xml:id='stati-mistici']/tei:category">
              <xsl:variable name="id" select="@xml:id"/>
              <xsl:variable name="n"
                  select="count(//tei:body//tei:term[substring-after(@ref,'#')=$id])"/>
              <xsl:if test="$n &gt; 0">
                <dt id="stato-{$id}"><xsl:value-of select="$id"/>
                  <span class="cnt"><xsl:value-of select="$n"/></span></dt>
                <dd><xsl:value-of select="normalize-space(tei:catDesc)"/></dd>
              </xsl:if>
            </xsl:for-each>
          </dl>
        </section>

        
        <xsl:if test="//tei:text//tei:note[@place='foot']">
          <section class="footnotes">
            <h2>Note</h2>
            <ol>
              <xsl:for-each select="//tei:text//tei:note[@place='foot']">
                <li id="fn-{position()}"><xsl:apply-templates select="node()"/></li>
              </xsl:for-each>
            </ol>
          </section>
        </xsl:if>

        
        <footer class="colophon">
          <p><xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/>.
             Autografo: <xsl:value-of select="normalize-space((//tei:bibl[@xml:id='castello-anima']/tei:note)[1])"/>.</p>
          <p class="lic"><xsl:value-of select="normalize-space(//tei:availability/tei:licence)"/></p>
          <p class="gen">Pagina di lettura generata da <code>castello-anima.xsl</code> sul master
             risolto TEI. Fonte autorevole: i dati TEI in <code>data/</code>.</p>
        </footer>

        <div id="pop" class="popover" hidden="hidden"></div>
        <script><xsl:call-template name="js"/></script>
      </body>
    </html>
  </xsl:template>

  
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
      <div class="ch-d">Diplomatico</div>
      <div class="ch-i">Interpretativo</div>
      <div class="ch-a">Apparato · Tb0</div>
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
        <aside class="argument"><xsl:apply-templates select="tei:argument/node()"/></aside>
      </xsl:if>
      <xsl:apply-templates select="tei:p"/>
    </section>
  </xsl:template>

  
  <xsl:template match="tei:p">
    <div class="prow">
      <div class="pnum"><xsl:if test="@n">§<xsl:value-of select="@n"/></xsl:if></div>
      <div class="pcell dipl" data-lbl="Diplomatico"><xsl:apply-templates/></div>
      <div class="pcell interp" data-lbl="Interpretativo"><xsl:apply-templates/></div>
      <div class="pcell app" data-lbl="Apparato · Tb0">
        <xsl:choose>
          <xsl:when test=".//tei:app">
            <xsl:for-each select=".//tei:app">
              <div class="appentry">
                <span class="lem"><xsl:apply-templates select="tei:lem/node()"/></span>
                <span class="br"> ] </span>
                <span class="rdg"><xsl:apply-templates select="tei:rdg/node()"/></span>
                <span class="sig"> Tb0</span>
              </div>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise><span class="app-empty">—</span></xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

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
    <span class="ch corr"
      ><span class="lv-i"><xsl:apply-templates select="tei:corr/node()"/></span
      ><span class="lv-d"><xsl:apply-templates select="tei:sic/node()"/></span></span>
  </xsl:template>

 
  <xsl:template match="tei:app"><xsl:apply-templates select="tei:lem/node()"/></xsl:template>

 
  <xsl:template match="tei:del"><del class="del"><xsl:apply-templates/></del></xsl:template>
  <xsl:template match="tei:add"><span class="add" title="aggiunta"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:subst"><xsl:apply-templates/></xsl:template>
  <xsl:template match="tei:retrace"><span class="retrace"
      title="rivergatura: ripasso a inchiostro, testo invariato"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:gap"><span class="gap" title="guasto: illeggibile">⟨…⟩</span></xsl:template>
  <xsl:template match="tei:unclear"><span class="unclear" title="lettura incerta"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:supplied"><span class="supplied"
      title="integrazione editoriale (@cert={@cert})">[<xsl:apply-templates/>]</span></xsl:template>


  <xsl:template match="tei:term[@ref]">
    <xsl:variable name="id" select="substring-after(@ref,'#')"/>
    <span class="term" data-state="{$id}"
          data-desc="{normalize-space(key('cat',$id)/tei:catDesc)}"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="tei:term"><span class="term-plain"><xsl:apply-templates/></span></xsl:template>

  
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

  <xsl:template match="tei:note[@place='foot']">
    <sup class="fnref"><a href="#fn-{count(preceding::tei:note[@place='foot'])+1}"
        ><xsl:value-of select="count(preceding::tei:note[@place='foot'])+1"/></a></sup>
  </xsl:template>
  <xsl:template match="tei:note"/>

  <xsl:template match="tei:quote"><q class="quote"><xsl:apply-templates/></q></xsl:template>
  <xsl:template match="tei:cit"><span class="cit"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:ref"><span class="ref"><xsl:apply-templates/></span></xsl:template>
  <xsl:template match="tei:hi"><em><xsl:apply-templates/></em></xsl:template>
  <xsl:template match="tei:teiHeader"/>

  <xsl:template name="css">
:root{
  --bg:#faf8f4; --fg:#241f1a; --muted:#7a7167; --rule:#e4ddd0;
  --accent:#7a5a2f; --accent2:#4a6a55; --card:#fffdf9;
  --term:#eef3ee; --term-b:#cfe0d3; --add:#e9f0f7; --supp:#f3eee2;
  --appbg:#f6f1e7; --del:#b23a3a; --dipbg:#f7f4ee;
}
@media (prefers-color-scheme: dark){
  :root:not([data-theme="light"]){
    --bg:#17140f; --fg:#e9e2d6; --muted:#9a9182; --rule:#332c22;
    --accent:#c9a86a; --accent2:#8fb89b; --card:#1e1a14;
    --term:#1c261e; --term-b:#31463a; --add:#182430; --supp:#2a2417;
    --appbg:#201b13; --del:#e07a7a; --dipbg:#1b1710;
  }
}
:root[data-theme="dark"]{
  --bg:#17140f; --fg:#e9e2d6; --muted:#9a9182; --rule:#332c22;
  --accent:#c9a86a; --accent2:#8fb89b; --card:#1e1a14;
  --term:#1c261e; --term-b:#31463a; --add:#182430; --supp:#2a2417;
  --appbg:#201b13; --del:#e07a7a; --dipbg:#1b1710;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);
  font-family:"Iowan Old Style","Palatino Linotype",Palatino,Georgia,serif;
  line-height:1.7;font-size:17px}
.toolbar{position:sticky;top:0;z-index:20;display:flex;flex-wrap:wrap;gap:.6rem;
  align-items:center;justify-content:space-between;padding:.55rem 1rem;
  background:var(--card);border-bottom:1px solid var(--rule)}
.tb-title{font-weight:600;font-size:.9rem;color:var(--accent)}
.tb-controls{display:flex;gap:.4rem;flex-wrap:wrap}
button.toggle{border:1px solid var(--rule);background:transparent;color:var(--muted);
  border-radius:8px;padding:.32rem .7rem;font:inherit;font-size:.8rem;cursor:pointer}
button.toggle.on{color:var(--fg);border-color:var(--accent2);box-shadow:inset 0 0 0 1px var(--accent2)}
.chapnav{position:sticky;top:2.9rem;z-index:19;display:flex;flex-wrap:wrap;gap:.1rem .2rem;
  padding:.4rem 1rem;background:var(--bg);border-bottom:1px solid var(--rule);font-size:.78rem}
.chapnav a{color:var(--accent2);text-decoration:none;padding:.15rem .5rem;border-radius:6px}
.chapnav a:hover{background:var(--card);color:var(--accent)}
.chapnav .nav-leg{margin-left:auto;color:var(--accent)}
.page{max-width:70rem;margin:0 auto;padding:1.6rem 1.2rem 3rem}
.titlepage{text-align:center;margin:1rem 0 2rem;padding-bottom:1.4rem;border-bottom:1px solid var(--rule)}
.titlepage h1{font-size:1.9rem;margin:.2rem 0;color:var(--accent)}
.subtitle{color:var(--muted);font-size:.95rem;font-style:italic}
.author{margin-top:.8rem;font-variant:small-caps;letter-spacing:.03em}
.incipit{font-style:italic;color:var(--muted);text-align:center;margin:1rem auto 1.6rem;max-width:40rem}
.chapter{margin:2rem 0}
.chap-title{font-size:1.25rem;color:var(--accent);border-bottom:1px solid var(--rule);
  padding-bottom:.3rem;margin-bottom:.5rem}
.argument{font-style:italic;color:var(--muted);background:var(--card);
  border-left:3px solid var(--accent2);padding:.55rem .9rem;border-radius:0 6px 6px 0;margin:.3rem 0 1.1rem;font-size:.92rem}
/* GRIGLIA A FRONTE */
.colhead,.prow{display:grid;gap:1.1rem;grid-template-columns:2.2rem 1fr 1fr}
body.show-app .colhead,body.show-app .prow{grid-template-columns:2.2rem 1fr 1fr 1.15fr}
body.hide-dip .colhead,body.hide-dip .prow{grid-template-columns:2.2rem 1fr}
body.hide-dip.show-app .colhead,body.hide-dip.show-app .prow{grid-template-columns:2.2rem 1fr 1.15fr}
.colhead{position:sticky;top:5.4rem;z-index:12;background:var(--bg);
  padding:.3rem 0;border-bottom:1px solid var(--rule);margin-bottom:.8rem;
  font-size:.7rem;font-variant:small-caps;letter-spacing:.05em;color:var(--muted)}
.colhead .ch-d{color:var(--muted)} .colhead .ch-i{color:var(--accent)} .colhead .ch-a{color:var(--accent2)}
.prow{margin-bottom:.5rem;padding-bottom:.5rem;border-bottom:1px dotted var(--rule);align-items:start}
.pnum{color:var(--accent2);font-size:.7rem;font-weight:700;font-family:ui-monospace,monospace;
  padding-top:.15rem;user-select:none}
.pcell{text-align:justify;hyphens:auto}
.pcell.dipl{color:var(--muted);background:var(--dipbg);border-radius:6px;padding:.3rem .6rem;font-size:.96em}
.pcell.app{display:none;font-size:.82rem;background:var(--appbg);border-radius:6px;padding:.3rem .6rem}
body.show-app .pcell.app{display:block}
body.hide-dip .pcell.dipl,body.hide-dip .colhead .ch-d{display:none}
.colhead .ch-a{display:none} body.show-app .colhead .ch-a{display:block}
/* livelli per colonna */
.pcell.dipl .lv-i,.appentry .lem .lv-d{display:none}
.pcell.interp .lv-d,.appentry .rdg .lv-d{display:none}
.pcell.interp .fw{display:none}
.pcell.dipl .fnref{display:none}
.ch.corr .lv-i{border-bottom:1px dotted var(--accent)}
/* apparato (3ª colonna) */
.appentry{margin-bottom:.35rem;line-height:1.5}
.appentry .lem{color:var(--accent)}
.appentry .br{color:var(--muted)}
.appentry .sig{font-variant:small-caps;color:var(--accent2);font-size:.85em}
.app-empty{color:var(--rule)}
.del{color:var(--del);text-decoration:line-through}
.add{background:var(--add);border-radius:3px;padding:0 .1em}
/* fenomeni */
.gap{color:var(--muted)} .unclear{border-bottom:1px dotted var(--muted)}
.supplied{color:var(--accent2)} .retrace{border-bottom:1px solid var(--accent)}
/* stati mistici */
.term{border-radius:3px;padding:0 .12em;cursor:pointer}
body.show-stati .pcell.interp .term{background:var(--term);border-bottom:1px solid var(--term-b)}
/* segnaletica */
.pb{display:inline-block;vertical-align:middle;margin:0 .2rem;user-select:none}
.pb-lbl{font-family:ui-monospace,monospace;font-size:.6rem;color:#fff;background:var(--accent2);
  border-radius:4px;padding:.02rem .3rem}
.fw{font-size:.72rem;color:var(--muted);font-style:italic}
.fnref a{color:var(--accent2);text-decoration:none;font-size:.72em;padding:0 .1em}
/* legenda */
.legenda{max-width:52rem;margin:2rem auto 0;padding:1.4rem 1.2rem;border-top:1px solid var(--rule)}
.legenda h2{font-size:1.05rem;color:var(--accent);font-variant:small-caps}
.leg-intro{font-size:.82rem;color:var(--muted)}
.legenda dl{display:grid;grid-template-columns:auto 1fr;gap:.3rem .9rem;font-size:.9rem}
.legenda dt{font-weight:700;color:var(--accent2);font-family:ui-monospace,monospace;font-size:.85rem;white-space:nowrap}
.legenda dt .cnt{display:inline-block;margin-left:.3rem;background:var(--term);color:var(--fg);
  border-radius:10px;padding:0 .45rem;font-size:.72rem;font-weight:600}
.legenda dd{margin:0;color:var(--fg)}
.footnotes,.colophon{max-width:52rem;margin-left:auto;margin-right:auto}
.footnotes{margin-top:2rem;padding:1.2rem;border-top:1px solid var(--rule)}
.footnotes h2{font-size:1rem;color:var(--accent);font-variant:small-caps}
.footnotes ol{font-size:.85rem;color:var(--muted)}
.colophon{margin:1rem auto 3rem;padding:1.2rem;color:var(--muted);font-size:.78rem;
  text-align:center;border-top:1px solid var(--rule)}
.colophon code{background:var(--card);padding:.05rem .3rem;border-radius:4px}
.colophon .lic{font-style:italic}
/* popover definizione stato */
.popover{position:fixed;z-index:40;max-width:22rem;background:var(--card);color:var(--fg);
  border:1px solid var(--accent2);border-radius:10px;padding:.7rem .9rem;font-size:.86rem;
  box-shadow:0 10px 30px rgba(0,0,0,.25);line-height:1.5}
.popover b{color:var(--accent2);font-family:ui-monospace,monospace;font-size:.9em;
  display:block;margin-bottom:.25rem;text-transform:none}
@media (max-width:820px){
  .colhead{display:none}
  .prow,body.show-app .prow,body.hide-dip .prow{grid-template-columns:1fr;gap:.3rem}
  .pnum{padding-top:0}
  .pcell{padding:.4rem .6rem;border-radius:6px}
  .pcell::before{content:attr(data-lbl);display:block;font-size:.62rem;font-variant:small-caps;
    letter-spacing:.05em;color:var(--accent2);margin-bottom:.15rem}
  .pcell.interp{background:var(--card)}
  .legenda dl{grid-template-columns:1fr}
}
  </xsl:template>

  <xsl:template name="js">
<xsl:text disable-output-escaping="yes"><![CDATA[
(function(){
  var b=document.body;
  function bind(id,cls,invert){
    var el=document.getElementById(id);
    el.onclick=function(){
      b.classList.toggle(cls);
      var active=b.classList.contains(cls);
      el.classList.toggle('on', invert ? !active : active);
    };
  }
  bind('bDip','hide-dip',true);   // "Diplomatico" acceso = colonna visibile
  bind('bApp','show-app',false);
  bind('bStati','show-stati',false);

  // popover con la definizione dello stato mistico (dal catDesc)
  var pop=document.getElementById('pop');
  function hide(){pop.hidden=true;}
  document.addEventListener('click',function(e){
    var t=e.target.closest ? e.target.closest('.term') : null;
    if(!t){ if(!e.target.closest || !e.target.closest('#pop')) hide(); return; }
    e.stopPropagation();
    pop.innerHTML='<b>'+(t.getAttribute('data-state')||'')+'</b>'+
                  (t.getAttribute('data-desc')||'—');
    pop.hidden=false;
    var r=t.getBoundingClientRect(), pw=Math.min(window.innerWidth*0.9,352);
    var x=Math.min(r.left, window.innerWidth-pw-12);
    var y=r.bottom+8; if(y+140>window.innerHeight) y=r.top-8-140;
    pop.style.left=Math.max(8,x)+'px'; pop.style.top=Math.max(8,y)+'px'; pop.style.maxWidth=pw+'px';
  });
  window.addEventListener('scroll',hide,{passive:true});
})();
]]></xsl:text>
  </xsl:template>

</xsl:stylesheet>
