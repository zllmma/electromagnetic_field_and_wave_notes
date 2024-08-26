#import "@preview/ilm:1.2.1": *

#set text(lang: "zh")

#show: ilm.with(
  title: [电磁场与电磁波笔记],
  author: "ZLL",
  date: datetime(year: 2024, month: 08, day: 06),
  paper-size: "a4",
)

= 矢量分析

== 矢量表达

=== 三维直角坐标系
此坐标系中任一矢量 $bold(A)$ 可表示为:

$
  bold(A) &= bold(e)_x A_x + bold(e)_y A_y + bold(e)_z A_z\
  &= sum_(i) A_i bold(e)_i quad (i = 1, 2, 3 "表示" x, y, z)\
  &= A_i bold(e)_i quad "(爱因斯坦求和约定)"
$

单位矢量 $bold(e)_x, bold(e)_y, bold(e)_z$ 满足:

$$