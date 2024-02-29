// 增加了摘要段落

#let abstact(title:[#text(14pt)[摘要]],fontsize:12pt,doc) = {
  set text(fontsize)
  set align(center)
  par(title)
  par[#h(2em)#doc]
}