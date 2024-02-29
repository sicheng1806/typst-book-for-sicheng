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

