#import "../basic_pkg/note_CN.typ"
#show : doc => note_CN.conf(
  title: "typst速览笔记",
  author: text(blue)[sicheng1806],
  doc
)
#let abstact(title:[#text(14pt)[摘要]],fontsize:12pt,doc) = {
  set text(fontsize)
  set align(center)
  par(title)
  par[#box(width: 2em)#doc]
}
#let webtable(
  columns: (),
  gutter: (),
  column-gutter : (),
  row-gutter : (),
  fill : none,
  align : auto,
  titleline : 1pt + black,
  inset : 5pt,
  linestroke: gray,
  ..children
) = {
  set table(columns: columns,gutter: gutter,column-gutter: column-gutter,
          row-gutter: row-gutter,stroke: none,align: align,fill:fill,inset:inset)
  let _col = 0 
  if type(columns) == int {
    _col = columns
  } else {
    _col = columns.len()
  }
  let titles = children.pos().slice(0,_col)
  let content = children.pos().slice(_col)
  stack(
    table(..titles.map(it => strong(it))),
    line(length: 100%,stroke:linestroke),
    table(..content)
    )
}

// ---------------------正文------------------------------------
#abstact()[
  typst具有代码模式和文本模式
]

= 文本模式速览

== 常用结构化文本方法

下面用表格列出，注意标签需要是可引用的，如标题，公式，图表等。

#align(center,block(width: 90%,
webtable(
  columns: (1fr,2fr,2fr),
  row-gutter: 1em,
  fill: luma(90%),
  linestroke: luma(0%),
  align: left,
  "名称", "用法" ,"示例", 
  "划分章节", "=若干" , `== 二级标题`, 
  "段落中断", "空行 或 parbreak", `parbreak()`,
  "行中断" , "linebreak 或 \ " , `你好\ 世界` , 
  "无序列表" , "-" , `- item` ,
  "有序列表" , "+" , `+ item` , 
  "术语列表" , "/ ITEM: 解释" , `/ ITEM: 解释`,
  "注释" , `// line  或 /* block */` , `// 注释`,
  "源码段" , "`", "`print(1)`",
  "链接" , "link 或 直接输入链接" , `link(https://www.bilibili.com)`,
  "数学公式", `$` , `$e = mc^2$`,
  "标签" , "<>" , `<a>`,
  "引用" , "@" , "@a",
  "加重" , "strong() 或 *" , `*hello*`,
  "斜体" , "_hello_ 或 emph()", `_hello_` ,
  "下划线" , "underline()" , `underline(hello)`
)
))



