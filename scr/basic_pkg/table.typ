// 添加了 webtable格式的表格

#let webtable(
  titleline : 1pt + black,
  linestroke: gray,
  columns: (),
  gutter: (),
  column-gutter : (),
  row-gutter : (),
  fill : none,
  align : auto,
  stroke : none,
  inset : 5pt,
  ..children
) = {
  set table(columns: columns,gutter: gutter,column-gutter: column-gutter,
          row-gutter: row-gutter,stroke: none,align: align,fill:fill,inset:inset)
  // 获取首行部分
  let _col = 0 
  if type(columns) == int {
    _col = columns
  } else {
    _col = columns.len()
  }
  let titles = children.pos().slice(0,_col)
  let content = children.pos().slice(_col)
  //----------------------------------------------------------------
  stack(
    table(..titles.map(it => strong(it))),
    line(length: 100%,stroke:linestroke),
    table(..content)
    )
}

