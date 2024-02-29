#import "../basic_pkg/table.typ" : webtable 

#webtable(
  columns: (1fr,2fr,2fr),
  row-gutter: 1em,
  fill: luma(95%),
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

