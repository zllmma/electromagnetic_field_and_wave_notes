#import "@preview/ilm:1.2.1": *

#set text(lang: "zh")

#show: ilm.with(
  title: [电磁场与电磁波笔记],
  author: "ZLL",
  date: datetime(year: 2024, month: 08, day: 06),
  paper-size: "a4",
)

#set text(
  font: ("New Computer Modern", "Noto Serif CJK SC"),
  size: 13pt,
)

#let bq = blockquote

= 矢量分析
#bq([
  笔者注: 严格的来讲, 矢量符号应该都是粗体, 但为了方便, 本文中部分矢量符号没有加粗
])
== 矢量表达

=== 三维直角坐标系
此坐标系中任一矢量 $bold(A)$ 可表示为:

#bq($
  bold(A) &= bold(e)_x A_x + bold(e)_y A_y + bold(e)_z A_z\
  &= sum_(i) A_i bold(e)_i quad (i = 1, 2, 3 "表示" x, y, z)\
  &= A_i bold(e)_i quad "(爱因斯坦求和约定)"
$)

单位矢量 $bold(e)_x, bold(e)_y, bold(e)_z$ 满足:
#bq([$
    e_i dot e_j = delta_(i j)
  $
  $
    e_i times e_j = epsilon_(i j k) e_k
  $])
其中 $delta_(i j)$ 叫做克罗内克 $delta$ 函数
#bq($
  delta_(i j) = cases(
    1 &", " i = j,
    0 &", " i != j
  )
$)
$epsilon_(i j k)$ 为列维-奇维塔符号

#bq($
  epsilon_(i j k) = cases(
  +1 quad& ("当" i, j, k "是偶排列", "即" (1, 2, 3) "的循环排列"),
  -1 &("当" i, j, k "是奇排列", "即" (1, 2, 3) "的反循环排列"),
  0 &(当 i = j, 或 i = k, 或 j = k)
)
$)

例: $e_z times e_y = epsilon_(z y x) e_x + epsilon_(z y y) e_y + epsilon_(z y z) e_z = -e_x$

- 矢量点乘
  #blockquote($
    bold(A) dot bold(B) = (A_i e_i) dot (B_j e_j) = A_i B_j (e_i dot e_j) = A_i B_i delta_(i j) = A_i B_i
  $)
- 矢量叉乘
  #blockquote($
    bold(A) times bold(B) = (A_i e_i) times (B_j e_j) = A_i B_j (e_i times e_j) = A_i B_j epsilon_(i j k) e_k
  $)

  例: 当 $k$ 为 $x$ 时, 上式为 $A_y B_z epsilon_(y z x) e_x + A_z B_y epsilon_(z y x) e_x = e_x (A_y B_z - A_z B_y)$, 此即为叉乘结果的 $x$ 分量

  叉乘结果也可写为
  #blockquote($
    bold(A) times bold(B) = mat(delim: "|", e_x, e_y, e_z; A_x, A_y, A_z; B_x, B_y, B_z)
  $)

一个列维-奇维塔符号的性质:
#blockquote($
  epsilon_(i j k) epsilon_(m n k) = delta_(i m) delta_(j n) - delta_(i n) delta_(j m)
$)

由此可证明 $A dot (B times C) = C dot (A times B) = B dot (C times A)$, 过程如下
#bq([$
    &underbrace(A, k) dot (underbrace(B, i) times underbrace(C, j))\
    &= A_k e_k dot (e_m B_i C_j epsilon_(i j m))\
    &= delta_(k m) epsilon_(i j m) A_k B_i C_j = epsilon_(i j k) A_k B_i C_j\
    &= epsilon_(j k i) A_k B_i C_j quad (B dot (C times A))\
    &= epsilon_(k i j) A_k B_i C_j quad (C dot (A times B))
  $])

== $nabla$ 算符运算
$nabla$算符 读作 "nabla" 或 "del", 其既有矢量性, 也有微分性

#bq([
  $
    nabla &= bold(e)_x (diff) / (diff x) + bold(e)_y (diff) / (diff y) + bold(e)_z (diff) / (diff z)\
    &= bold(e)_i diff_i
  $
])

- 标量场的梯度
#bq([
  $
    nabla U(bold(r)) = e_i diff_i U(bold(r))
  $
])

- 矢量场的散度
#bq([
  $
    gradient dot bold(A)(bold(r)) = e_i diff_i dot A_j e_j = delta_(i j) diff_i A_j = diff_i A_i
  $
])

- 矢量场的旋度
#bq([
  $
    gradient times bold(A)(bold(r)) &= e_i diff_i times e_j A_j = epsilon_(i j k) e_k diff_i A_j\
    &= mat(delim: "|", e_x, e_y, e_z; diff/diff_x, diff/diff_y, diff/diff_z; A_x, A_y, A_z)
  $
])

几个典型性质:

#bq([1. 假设$f, g$都是标量, 则 $ gradient(f g) = g(gradient f) + f(gradient g) $])

#bq([
  证明:
  $
    gradient(f g) &= e_i diff_i (f g) = e_i (g (diff_i f) + f (diff_i g)) = g(gradient f) + f(gradient g)
  $])

#bq([2. 假设$bold(A)$是矢量, 则 $ gradient times (gradient times bold(A)) = gradient(gradient dot bold(A)) - gradient^2 bold(A) $])

#bq([
  证明:
  $
    gradient times (gradient times A) &= gradient times (e_k epsilon_(m n k) diff_m A_n)\
    &= (e_j diff_j) times (e_k epsilon_(m n k) diff_m A_n)\
    &= e_i epsilon_(i j k) epsilon_(m n k) diff_j diff_m A_n\
    &= e_i (delta_(i m) delta_(j n) - delta_(i n) delta_(j m)) diff_j diff_m A_n\
    &= e_i diff_j diff_i A_j - e_i diff_j diff_j A_i\
    &= e_i diff_i (diff_j A_j) - diff^2_j e_i A_i\
    &= gradient(gradient dot bold(A)) - gradient^2 bold(A)
  $])

#bq([
  $
    gradient times (gradient u) &= gradient times (e_i diff_i u)\
    &= e_k epsilon_(j i k) diff_j diff_i u\
    &= -e_k epsilon_(i j k) diff_i diff_j u\
    &= -gradient times (diff_j e_j u)\
    &= -gradient times (gradient u) = 0
  $
])

#bq([
  $
    gradient times (bold(F) times bold(G)) &= (bold(F) dot gradient) bold(G) - bold(G) (gradient dot bold(F))
  $
])

== 矢量分析意义

=== 微元
- 线元
  $
    bold(r) = x e_x + y e_y + z e_z = u_i e_i\
    bold(r)'= (u_i + dif u_i) e_i\
  $
  #bq($
    dif bold(r) &= bold(r)' - bold(r) \
    &= e_x dif x + e_y dif y +e_z dif z = e_i dif u_i
  $)

- 面元
  + 一定是一个平面
  + 有方向(法向方向)

  #bq($
    dif bold(S) &= e_x dif S_x + e_y dif S_y + e_z dif S_z\
    dif S_x &= dif y dif z e_x\
    dif S_y &= dif x dif z e_y\
    dif S_z &= dif x dif y e_z\
  $)

- 体积元
  #bq($
    dif V = dif x dif y dif z
  $)

=== 标量函数 (场) 的方向导数及梯度

标量场 $T(x, y z)$

等值面 $T(x, y, z) = C$

方向导数:
#bq([
  $
    (diff T(M_0)) / (diff l)|_(e_l) = lim_(Delta l -> 0) (T(M) - T(M_0)) / (Delta l)
  $
])

$
  dif bold(l) = dif l e_l = e_i dif u_i\
  => e_l = e_i (dif u_i) / (dif l)
$

#bq([
  $
    (diff T) / (diff l) &= (diff T) / (diff x) (dif x) / (dif l)+(diff T) / (diff y) (dif y) / (dif l)+(diff T) / (diff z) (dif z) / (dif l)\
    &= ((diff T) / (diff u_j) e_j) dot ((dif u_i) / (dif l) e_i)\
    &= gradient T dot bold(e)_l
  $
])
这说明:
+ 标量场沿任意方向的方向导数等于其梯度在该方向上的投影
+ 标量场的梯度是一个矢量, 方向是标量场变化最快的方向, 垂直于等值面
=== 矢量场的通量和散度

- 矢量线

  矢量线上任一点的切线方向与矢量场的在该点的方向相同, 即 $dif bold(r) "平行" bold(F)$
  #bq($
    (dif x) / F_x = (dif y) / F_y = (dif z) / F_z
  $)

- 通量
  #bq([
    $
      Psi = integral_S bold(F) dot dif bold(S)
    $
  ])

- 散度

  #bq([$
      "div" bold(F) = lim_(Delta V -> 0) (integral.cont_S bold(F) dot dif bold(S)) / (Delta V) = gradient dot bold(F)
    $])

- 散度定理

  将散度的定义式稍作变换即得散度定理: *矢量场的散度在体积上的积分等于矢量场在该体积的闭合面上的面积分*
  #bq([
    $
      integral_V gradient dot F dif V = integral.cont_S F dot dif S
    $
  ])


=== 矢量场的环流与旋度

- 环流

  矢量场沿一条*闭合*路径的线积分
  #bq([
    $
      Gamma = integral.cont_C bold(F) dot dif bold(l)
    $
  ])

  - 环流面密度

    #bq([
      $
        "rot"_upright(n) bold(F) = lim_(Delta S->0) (integral.cont_C bold(F) dot dif bold(l)) / (Delta S)
      $
    ])

- 旋度

  取不同的面元 $Delta S$, 环流面密度的值不同, 但是在某个特定方向下, 环流密度有最大值, 为解决这个问题, 引入旋度的概念

  旋度定义为一个矢量, 方向是使环流密度取得最大值的面元法线方向, 大小为该最大环流密度的值

  #bq([
    $
      "rot" bold(F) = bold(n) lim_(Delta S->0) lr((integral.cont_C bold(F) dot dif bold(l))/(Delta S)|)_max = gradient times bold(F)
    $
  ])

- 斯托克斯定理

  *矢量场的旋度在曲面上的积分等于矢量场在限定曲面的闭合曲线上的线积分*

  #bq([
    $
      integral_S gradient times bold(F) dot dif bold(S) = integral.cont_C bold(F) dot dif bold(l)
    $
  ])