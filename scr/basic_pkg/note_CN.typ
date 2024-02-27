/*
1. 笔记标题 : 居中 + 黑体 + 18pt 
2. 目录 : 
3. 章节编号 : 
4. 正文: 
*/
#import "numbering.typ": notenumbering
#let conf(
  title:[标题],
  author: [],
  doc
) = {
//设置页面为a4，页眉为标题，编号数字编号
set page(
  paper: "a4",
  header: align(right)[#text(8pt)[#title]#line(length: 100%)],
  numbering: "1"
)
//设置字体为英文自由字体，中文宋体。字号10pt
set text(
  font: ("Linux Libertine","SimSun"),
  size: 14pt,
)
// 设置1级标题为中文大写数字，其余为编号
set heading(numbering: notenumbering)
// 书写标题,作者
{
  set align(center)
  par(strong(text(18pt,title)))
  text(10pt,author)
}
show heading : it => {
  set text(fill: blue )
  underline(it) 
}
outline(title: strong[目录],indent: 1em)
// 正文
set align(left)
doc 
}