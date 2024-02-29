/*
1. 笔记标题 : 居中 + 黑体 + 18pt 
2. 目录 : 
3. 章节编号 : 
4. 正文: 
5. 提供点击标题回到目录的功能
6. 提供添加术语表的函数 term-list
*/
#import "numbering.typ": notenumbering

#let weboutline() = {
  show outline : set par(leading: 1em)
  show outline : set text(blue)
  [#outline(title: text(black,strong[目录]),indent: 1em)]
}


#let conf(
  title:[标题],
  author: [],
  _numbering:false,
  doc
) = {
//设置页面为a4，页眉为标题，编号数字编号
set page(
  paper: "a4",
  header: align(right)[#text(8pt)[#title]#line(length: 100%)],
)
//设置字体为英文自由字体，中文宋体。字号14pt
set text(
  font: ("Linux Libertine","SimSun"),
  size: 14pt,
)
// 设置1级标题为中文大写数字，其余为编号

set heading(numbering: notenumbering) if _numbering

// 书写标题,作者
{
  set align(center)
  par(strong(text(18pt,title)))
  text(10pt,author)
}
// 设置段落标题字号为蓝色，为每个段落标题添加到目录的链接
show heading : set text(blue)
show heading : it => link(<content>,it)
// 给术语的每个项目添加标签用于查询
show terms.item : it => {
  [#it <term_item>]
}
// 设置目录的样式,添加目录
[#weboutline()<content>]
// 正文
set align(left)
set par(first-line-indent: 2em)
doc 
}
#let show-settings = (
  "笔记标题" : [居中+黑体+18pt],
  "作者" : [10pt+居中],
  "页眉" : [8pt+right+展示title],
  "正文" : [14pt+Simsun+Linux Libertine],
  "段落标号" : [1级标题为中文大写数字，其余为编号],
)
#let term-list() = {
  //设置术语表样式
  set par(first-line-indent: 0em)
  show terms.item : it => [#grid(columns: (1fr,1fr),it.term,it.description)]
  //呈现术语表
  block(fill:luma(80%),inset:2pt,block(fill:white,inset:2em,locate(loc => {
    for q in query(<term_item>,loc) {
      link(q.location())[#q]
    }
  })))
}
