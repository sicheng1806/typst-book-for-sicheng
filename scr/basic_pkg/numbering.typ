#let chinesenumber(num, standalone: false) = if num < 11 {
  ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(num)
  } else if num < 100 {
    if calc.rem(num, 10) == 0 {
      chinesenumber(calc.floor(num / 10)) + "十"
    } else if num < 20 and standalone {
      "十" + chinesenumber(calc.rem(num, 10))
    } else {
      chinesenumber(calc.floor(num / 10)) + "十" + chinesenumber(calc.rem(num, 10))
    }
  } else if num < 1000 {
    let left = chinesenumber(calc.floor(num / 100)) + "百"
    if calc.rem(num, 100) == 0 {
      left
    } else if calc.rem(num, 100) < 10 {
      left + "零" + chinesenumber(calc.rem(num, 100))
    } else {
      left + chinesenumber(calc.rem(num, 100))
    }
  } else {
    let left = chinesenumber(calc.floor(num / 1000)) + "千"
    if calc.rem(num, 1000) == 0 {
      left
    } else if calc.rem(num, 1000) < 10 {
      left + "零" + chinesenumber(calc.rem(num, 1000))
    } else if calc.rem(num, 1000) < 100 {
      left + "零" + chinesenumber(calc.rem(num, 1000))
    } else {
      left + chinesenumber(calc.rem(num, 1000))
    }
}

#let notenumbering(..nums,location:none) = locate(
  loc => {
    if nums.pos().len() == 1 {
      chinesenumber(nums.pos().first(),standalone:true) + "、"
    } else {
      numbering("1.1",..nums.pos())
    }
  }
)

