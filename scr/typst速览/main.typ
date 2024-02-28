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
#let ind2 = box(width: 2em)

#let background-board(width:auto,out-fill:luma(90%),in-fill:white,radius: 0pt,out-inset: 0pt,_align: center,in-inset:10pt,body) = {
  set align(_align)
  block(
    radius: radius,width: width,fill:out-fill,inset: out-inset,
    block(width: 100%,fill:in-fill,inset:in-inset,body)
    )
}
#let result-board(width:auto,body) = {
  background-board(width:width,radius:4pt,out-inset:6pt,_align:center,body)
}
#let code-board(width: auto,body) = {
  set align(left)
  background-board(width: width,radius: 1pt ,out-inset: 1pt,out-fill:luma(80%),_align:left,body)
}

// ---------------------正文------------------------------------
#abstact()[
  typst具有代码模式和文本模式
]

= 文本模式符号速览

== 常用结构化标记

#ind2 下面用表格列出，注意标签需要是可引用的，如标题，公式，图表等。

#align(center,block(width: 90%,
webtable(
  columns: (1fr,2fr,2fr),
  row-gutter: 1em,
  fill: luma(95%),
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

== 文本修饰命令

#for ( func, mean ) in (
  "strong" : "加粗文本",
  "emph" : "斜体文本",
  "hightlight" : "高亮文本",
  "raw" : "具有可选语法突出显示的原始文本",
  "strike" : "在文本中画一条线",
  "sub" : "以下标的形式呈现文本",
  "super" : "以上标的形式呈现文本",
  "underline" : "给文本加下划线",
  "linebreak" : "断行不产生新的段落",
  "overline" : "在文本头顶画线"
  ) {
    set terms(
      separator: "——",
    )
    show terms : it => {
      stack(dir:ltr,box(width:2em),emoji.face.lick,it)
    }
    [/ #func : #mean]
    }

=== raw 命令的解释

#ind2 使用符号 #"`" 时具有两种模式，一种时没有语法高亮的 #"``" 一般用于不分行的显示原文，一种是通过参数确定语法高亮或者不高亮的模式 #"```" , 例如：
```` ```python print("hello world")``` ````
参数为空时为不高亮，参数可选 `python` , `rust` 等。当需要显示上文的示例时，需要使用 #"````"，才不会导致识别错误。

raw函数可进一步设置文本显示情况,也可以通过 `show-set规则` 管理样式。

=== 断行与段落中断的用法

#ind2 断行可以通过 `\` 或者 `linebreak()` 来设置，段落中断可以通过连续两个换行符来设置,断行和新行的区别是显著的，需要注意区别。 

== 常用符号命令

#ind2 一些特殊的符号除了转义表达还有其自己的命令函数，也可以自定义相关符号。
#for (_func , mean) in (
  "linebreak":"断行",
  "parbreak" : "段落中断",
  "colbreak" : "列中断",
  "pagebreak" : "分页符"
) {
  set terms(
    separator: "  "+emoji.bubble.speech+"——",
  )
  [/ #_func: #mean]
}

== sym符号族和emoji符号族

#ind2 sym符号族存储了大量的一般符号(非emoji)，而emoji则储存了大量表情符号。

== 用symbol函数创建新的符号族

#ind2 使用 `symbol函数` 可以快速构建和 `sym符号族` 和 `emoji符号族` 一样调用方法的符号族。用法见示例:
#code-board()[
```typst 
#let car = symbol(
  "\u{1F697}",
  ("front","\u{1F698}"),
  ("pickup","\u{1F6FB}"),
)
// 使用符号
#car 
#car.front
#car.pickup
```
]
// 使用符号

#result-board()[
#let car = symbol(
  "\u{1F697}",
  ("front","\u{1F698}"),
  ("pickup","\u{1F6FB}"),
)
#car 
#car.front
#car.pickup
]

= 文本模式布局速览

#ind2 如果要细分typst用于布局的工具的话，可以分为以下几类:

- 布局符号 --- 使用添加类似符号的内容用于布局，例如内联式容器中的 `h`、 `v` 或者 非内联式的 `line`、 `rect` 等。 
- 内容容器 --- 使用各种性质的容器来组织内容，如 `list` 、 `grild` 等。
- 变换工具 --- 此类工具有平移、旋转、放缩等。
- 绘图工具 --- 此类工具提供绘画的基础功能，使用 `ctez` 库，可以轻松绘制更加复杂的图形。如 `circle` 、 `line` 等。
- 布局参数调节工具和容器 --- 此类工具用于设置内容的布局参数，也可以作为内容容器，是内容容器的一种类型。如 `align` 、 `text` 等。 

== 使用布局符号布局


#for ele in (
  ("h","在段落中插入水平空白",result-board[First #h(1fr) Second #h(1fr) Third]),
  ("v", "在一系列块中插入垂直空白", result-board[A #v(2em) B #v(1em) C] ),
  ("box", "指定大小的内联式容器", result-board[Refer to the docs
#box(height: 9pt,width: 9pt) for more information.]),
  ("place" , "在当前页面的指定位置放置内容，不会影响其他内容布局,示例请在当前页面各方位查找", place(top + right,dy:1em,square(width: 20pt,stroke: 2pt + blue,),))
) {
  set par(first-line-indent: 0pt)
  set terms(
      separator: "——",
    )
  show terms : it => {
    stack(dir:ltr,emoji.face.diagonal,it)
  }
  par[
  / #ele.at(0): #ele.at(1) \
  *示例* : \
  #ele.at(2)
 ]
}

=== place 说明 

#ind2 由于place具有浮动布局的效果，因而可以视为一个单独的布局元素，这与其他元素都不同，包括字符形式的布局工具。

== 使用内容容器布局

这一类既包括列表、表格之类的有特定表示形式的容器，也包括网格、块这类通用的布局容器，同时也包括在文字排版中就使用的可以设置布局参数的内容容器。

=== 特殊形式类

#for ele in (
  ("list","无序列表",result-board[略]),
  ("enum","有序列表",result-board[略]),
  (
    "table","表格",result-board[#table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: horizon,
  [],[*Area*],[*Parameter*],
  "圆柱",[$ pi h (D^2 - d^2) / 4 $],[
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
    ])]
  ),
  ("figure","带有可选描述的图表",result-board[略]),
  ("terms","术语列表",result-board[略])
) {
  set par(first-line-indent: 0pt)
  set terms(
      separator: "——",
    )
  show terms : it => {
    stack(dir:ltr,emoji.face.explode,it)
  }
  par[
  / #ele.at(0): #ele.at(1) \
  *示例* : \
  #ele.at(2)
 ]
}

=== 基础布局类
