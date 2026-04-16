graph TD
  TEI --> teiHeader
  teiHeader --> fileDesc
  teiHeader --> encodingDesc
  teiHeader --> profileDesc
  teiHeader --> xenoData_1[xenoData]
  teiHeader --> xenoData_2[xenoData[@type=mets]]
  teiHeader --> revisionDesc[revisionDesc[@status=consolidated]]

  fileDesc --> titleStmt
  fileDesc --> publicationStmt
  fileDesc --> notesStmt
  fileDesc --> sourceDesc

  notesStmt --> ng1[noteGrp[@type=critical]]
  notesStmt --> ng2[noteGrp[@type=biographical]]
  notesStmt --> ng3[noteGrp[@type=contextual]]

  sourceDesc --> listPlace
  sourceDesc --> bibl_ms[bibl[@type=ms]]
  sourceDesc --> msDesc
  sourceDesc --> lb1[listBibl[@type=fontes]]
  sourceDesc --> lb2[listBibl]
  sourceDesc --> listWit

  msDesc --> msIdentifier
  msDesc --> msContents
  msDesc --> physDesc
  msDesc --> history
  msDesc --> additional

  msContents --> mi1[msItem[@n=I]]
  msContents --> mi2[msItem[@n=II]]
  msContents --> mi3[msItem[@n=III]]

  physDesc --> obj[objectDesc[@form=autografo]]
  physDesc --> handDesc

  obj --> sup[supportDesc[@material=paper]]
  obj --> layout

  handDesc --> hn1[handNote[@xml:id=ink_1]]
  handDesc --> hn2[handNote[@xml:id=ink_2]]
  handDesc --> hn3[handNote[@xml:id=ink_3-dark]]
  handDesc --> hn4[handNote[@xml:id=ink_4-external]]

  history --> origin
  additional --> surrogates

  encodingDesc --> ab[ab[@xml:base=abstract]]
  encodingDesc --> projectDesc
  encodingDesc --> refsDecl
  encodingDesc --> editorialDecl
  encodingDesc --> tagsDecl
  encodingDesc --> var[variantEncoding[@method=parallel-segmentation]]
  encodingDesc --> classDecl
  encodingDesc --> schema[schemaRef[@type=odd]]

  classDecl --> tax[12 × taxonomy:\nfunc, impact, risk, mystic_state,\noperation, exposition, phase,\nrelation, certainty, position,\nfase, workflow]

  profileDesc --> lang[langUsage ×2]
  profileDesc --> particDesc
  particDesc --> listPerson
  particDesc --> listOrg

  sourceDoc --> note
