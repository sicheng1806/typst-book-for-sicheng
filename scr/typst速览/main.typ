#import "../basic_pkg/note_CN.typ"
#import "../basic_pkg/par.typ" : abstact
#import "../basic_pkg/table.typ" : webtable 
#import "../basic_pkg/board.typ" : code-board,result-board,background-board
#show : doc => note_CN.conf(
  title: "typst速览笔记",
  author: text(blue)[sicheng1806],
  _numbering: true,
  doc
)
// 设置一些小函数
#let ind2 = h(2em)
// 给术语每一项加标签用于索引

// ---------------------正文------------------------------------

#abstact()[
  typst具有代码模式和文本模式
] 
= 术语表
#note_CN.term-list()
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
  ("terms","术语列表",result-board[略]),
  ("image","图形的加载接口",result-board[略]),
  ("bibliography","一份参考文献",result-board[略]),
  ("outline","目录、图表或其他元素的大纲",result-board[略])
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

#for ele in (
  ("block","自适应给定宽度或高度圆角方形外联容器",result-board(width:100%)[#block(width: 2em,height: 2em,fill: blue)]),
  ("rect","更适合几何控制的外联容器",result-board[#rect(height: 2em,fill: blue)[#rect(height: 2em,width: 1em,fill:red)#rect(height: 2em,width: 1em,fill:red)]]),
  ("box","一个内联级容器，可调整内容的大小",result-board[略]),
  ("grid","将内容排列成网格",result-board[略]),
  ("pad","在内容周围添加间距",result-board[#pad(bottom: 2em,rect(fill:blue)[bottom:2em])_Typing speeds can be
 measured in words per minute._]),
  ("stack","实现内容按指定方向的快速堆叠",result-board[#stack(box(fill: blue,width: 1em,height: 1em),"你好" ,box(fill: blue,width: 1em,height: 1em))])
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

==== rect 和 block的区别

#ind2 block是个自适应极强的容器，如果在block进行多重嵌套，且只有block，会发现其width或者height参数失效，而rect不会发生这样的情况。

所以如果希望目标容器可以根据内容自适应排版选择block，如果希望其的大小可以严格控制，选择rect。

=== 可调全局布局的容器

#ind2 这一类容器按照一定的逻辑结构将文本和其他内容排列成整个文档。

#for ele in (
  (
    "document",
    "这个文档的根元素同时包含着其元数据，一般用于设置元数据",
    code-board[
  ```typst
    #set document(title: [Hello])
    This has no visible output, but
    embeds metadata into the PDF!
  ```]
  ),
  ("page","将其中的内容布局进一个或多个页面,可以用来设置页面的样式",code-board[
  ```typst
    #set page("us-letter")
    There you go, US friends!
  ```]),
  ("par","管理一个段落中的文档、间距和行内元素，可以用来设置段落样式",code-board[
    ```typst 
      #show par : set block(spacing: 2em) // 段落垂直间距
      #set par(
            first-line-indent: 1em, // 首行缩进
            justify: true, // 对齐
          )
    ```]),
  ("text","以各种方式自定义文本的外观和布局。一般用来设置",result-board[#text(fill: red)[红色字体]]),
  ("columns","将区域分割为多个大小相等的列。",result-board[
    #columns(2,gutter: 11pt)[
    #set par(justify: true)
    This research was funded by the
    National Academy of Sciences.
    NAoS provided support for field
    tests and interviews with a
    grant of up to USD 40.000 for a
    period of 6 months.
   ]]),
   ("align","将内容垂直和水平对齐",result-board[
    #set align(center)

    Centered text, a sight to see \
    In perfect balance, visually \
    Not left nor right, it stands alone \
    A work of art, a visual throne
   ])
  
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

=== 变换工具

#for (_func , mean) in (
  "rotate" : "旋转内容而不影响布局",
  "move" : "移动内容而不影响布局",
  "hide" : "隐藏内容而不影响布局",
  "scale" : "缩放内容而不影响布局"
) {
  set terms(
    separator: "  "+emoji.bubble.speech+"——",
  )
  [/ #_func: #mean]
}

=== 获取内容的布局元素大小

#[
#set par(first-line-indent: 0em)
/ measure: 和 style函数结合使用来获取指定内容的大小
/ layout: 提供对当前外部容器大小的访问
]
