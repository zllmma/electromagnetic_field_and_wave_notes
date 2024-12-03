#import "@preview/ilm:1.4.0": *

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


== 无旋场与无散场

=== 无旋场

若一个矢量场的旋度处处为0, 即
#bq([
  $
    gradient times F eq.triple 0
  $
])

则称其为无旋场, 是由散度源产生的 (如静电场)

由斯托克斯定理, 无旋场的曲线积分与路径无关, 只与起点和终点有关

- 一个结论: 标量场的梯度的旋度恒等于0
  #bq([
    $
      gradient times (gradient u) eq.triple 0
    $
  ])

  由此得到: 一个无旋场总可以表示成某个标量场的梯度.

=== 无散场

类似的, 无散场满足任一点散度为0
#bq([
  $
    gradient dot F eq.triple 0
  $
])
它是由漩涡源产生的 (如静磁场)

由高斯定理, 无散场通过任何闭合曲面的通量恒等于0

- 一个结论: 矢量场的旋度的散度等于0
  #bq([
    $
      gradient dot (gradient times A) eq.triple 0
    $
  ])

  由此得到: 无散场总可以表示为一个矢量场的旋度


== 拉普拉斯运算与格林定理
=== 拉普拉斯运算
对标量的梯度再求散度, 称为对标量的拉普拉斯运算, 记作

#bq([
  $
    gradient dot (gradient u) &= gradient^2 u \
    &= (diff^2 u) / (diff x^2) + (diff^2 u) / (diff y^2) + (diff^2 u) / (diff z^2) \
    &= diff^2_i u
  $
])

对矢量场的拉普拉斯运算定义为
#bq([
  $
    gradient^2 F &= gradient (gradient dot F) - gradient times (gradient times F)\
    &= e_x gradient^2 F_x + e_y gradient^2 F_y + e_z gradient^2 F_z\
    &= e_i gradient^2 F_i = e_i (diff^2_j F_i)
  $
])

=== 格林定理
格林第二恒等式: $psi$, $phi$ 是两个任意标量函数, 则

#bq([
  $
    integral_(V) (phi gradient^2 psi - psi gradient^2 phi) dif V = integral.cont_S (
      phi (diff psi) / (diff n) - psi (diff phi) / (diff n)
    ) dif S
  $
])
== 亥姆霍兹定理
在有限的区域中, 任一矢量场由它的散度, 旋度和边界条件唯一地确定, 且可表示为一个无散场和一个无旋场的叠加

= 电磁场的基本规律

#let bE = $bold(E)$
#let bH = $bold(H)$
#let bB = $bold(B)$
#let bD = $bold(D)$

== 媒质的电磁特性
=== 电介质的极化 电位移矢量
+ 电介质内部的电场强度可视为自由电荷产生的外电场和极化电荷产生的附加电场的叠加
  #bq($
    bold(E) = bold(E)_0 + bold(E)'
  $)

+ 极化强度
  #bq($
    bold(P) = lim_(Delta V -> 0) (sum_(i) bold(p)_i) / (Delta V)
  $)

  - 对于线性和各向同性介质，极化强度和电解质中的合成电场强度成正比
    #bq($
      bold(P)(bold(r)) = chi_e epsilon_0 bE(bold(r))
    $)
    其中 $chi_e$ 为电极化密度

+ 极化电荷
  - 极化电荷体密度
    #blockquote($
      rho_P = - nabla dot bold(P)
    $)
  - 电介质表面极化电荷面密度
    #bq($
      rho_(S P) = bold(P) bold(dot) bold(e)_n
    $)
+ 电介质的本构关系
  - 电位移矢量
    #bq($
      bold(D)(bold(r)) &= epsilon_0 bold(E)(bold(r)) + bold(P)(bold(r)) = epsilon_0 bold(E)(
        bold(r)
      )+chi_e epsilon_0 bold(E)(bold(r))\
      &= (1 + chi_e) epsilon_0 bold(E)(bold(r))\
      &= epsilon_r epsilon_0 bold(E)(bold(r)) = epsilon bold(E)(bold(r))
    $)
    其中 $epsilon = epsilon_r epsilon_0$ 为介电常数，$epsilon_r = 1 + chi_e$ 为相对介电常数

=== 磁介质的磁化 磁场强度
+ 和电介质类似，磁介质中的磁感应强度是真空中传导电流产生的磁感应强度和磁化电流产生的磁感应强度的叠加，即
  #bq($
    bold(B) = bold(B)_0 + bold(B)'
  $)

+ 磁化强度
  #bq($
    bold(M) = lim_(Delta V->0) frac(sum_(i) bold(p)_(m i),Delta V)
  $)
  - 对于线性和各向同性介质，磁化强度和电介质中的磁场强度成正比，即
    #bq($
      bold(M) = chi_m bold(H)
    $)
    其中 $chi_m$ 称为磁化率，磁场强度的定义为
    #bq($
      bold(H) = bold(B) / mu_0 - bold(M)
    $)


+ 磁化电流
  - 磁介质内磁化电流体密度
    #bq($
      bold(J)_M = nabla times bold(M)
    $)
  - 表面
    #bq($
      bold(J)_(S M) = bold(M) times bold(e)_n
    $)


+ 磁介质的本构关系
  #bq($
    bold(B) = (1+chi_m) mu_0 bold(H) = mu_r mu_0 bold(H) = mu bold(H)
  $)
  $mu_r$ --- 相对磁导率，$mu$ --- 磁导率

== 媒质的传导特性
+ 欧姆定理的微分形式
  #bq($
    bold(J) = sigma bold(E)
  $)

+ 电场在导电媒质做功为
  #bq($
    dif W &= dif bold(F) dot dif bold(l) = rho dif V bold(E) dot bold(v) dif t \
    &= bold(E) dot (rho bold(v)) dif V dif t \
    &= bold(E) dot bold(J) dif V dif t
  $)
可以看出，电场对单位体积提供的功率为 $p = bold(J) dot bold(E)$

== 麦克斯韦方程组
=== 积分形式
#bq($
  integral.cont_C bold(H) dot dif bold(l) &= integral_(S) bold(J) dot dif bold(S) + integral_S frac(diff bold(D), diff t) dot dif bold(S)\
  integral.cont_C bold(E) dot dif bold(l) &= - integral_S frac(diff bold(B), diff t) dot dif bold(S)\
  integral.cont_S bold(B) dot dif bold(S) &= 0\
  integral.cont_S bold(D) dot dif bold(S) &= integral_V rho dif V
$)

=== 微分形式
#bq($
  nabla times bold(H) &= bold(J) + (diff bold(D)) / (diff t)\
  nabla times bold(E) &= -(diff bold(B)) / (diff t)\
  nabla dot bold(B) &= 0\
  nabla dot bold(D) &= rho
$)

对于线性，各向同性媒质，代入媒质本构关系 $bold(D) = epsilon bold(E), bold(B) = mu bold(H), bold(J) = sigma bold(E)$，得到关于$bold(E), bold(H)$ 的方程
#bq($
  nabla times bold(H) &= sigma bold(E) + epsilon (diff bold(E)) / (diff t)\
  nabla times bold(E) &= - mu (diff bold(H)) / (diff t)\
  nabla dot bold(H) &= 0\
  nabla dot bold(E) &= rho / epsilon
$)

如果是*时谐电磁场*，则可将方程组改写为复数形式
#bq($
  nabla times bold(H) &= bold(J) + upright(j) omega bold(D)\
  nabla times bold(E) &= - upright(j)omega bold(B)\
  nabla times bold(B) &= 0\
  nabla times bold(D) &= rho
$)

=== 电磁场的边界条件
- $bE$ 的切向分量一定连续
- $bD$ 的法向分量可能不连续，其不连续分量由自由面电荷密度决定，具体为
  $ bold(e)_n dot (bold(D)_1 - bold(D)_2) = rho_S $
- $bB$ 的法向分量一定连续
- $bH$ 的切向分量可能不连续，其不连续分量由自由面电流密度决定，具体为
  $ bold(e)_n times (bold(H)_1 - bold(H)_2) = bold(J)_S $

其中，单位矢量 $bold(e)_n$ 由媒质2指向媒质1

== 电磁场的位函数
- 矢量位与标量位

  令 $bold(B) = nabla times bold(A)$ ，称 $bold(A)$ 为电磁场的矢量位，则
  $
    gradient times bold(E) = -diff / (diff t) (nabla times bold(A))\
    => nabla times (bold(E) + (diff bold(A)) / (diff t)) = 0
  $
  这说明 $bold(E) + frac(diff bold(A), diff t)$ 可以用一个标量函数的梯度来表示（将该标量函数称为电磁场的标量位），即
  $
    bold(E) + (diff bold(A)) / (diff t) = -nabla phi
  $
  通过规定 $bold(A)$ 的散度，可以得到唯一的 $bold(A)$ 和 $phi$，一般规定（洛仑兹条件）
  $
    nabla dot A = -mu epsilon (diff phi) / (diff t)
  $

== 电磁场的能量
- 在线性、各向同性的媒质中，电场能量密度，磁场能量密度，电磁场能量密度为
  $
    w_e = 1 / 2 bold(E) dot bold(D)\
    w_m = 1 / 2 bold(H) dot bold(B)\
    w = w_e + w_m
  $
- 坡印廷矢量（能流密度矢量）

  表示穿过与能量流动方向相垂直的单位面积的功率
  $
    bold(S) = bold(E) times bold(H)
  $

- 坡印廷定理
  $
    nabla dot bold(S) + diff / (diff t) (
      1 / 2 bold(H) dot bold(B) + 1 / 2 bold(E) dot bold(D)
    ) + bold(E) dot bold(J) = 0\
    "进入的电磁能量功率" + "电磁场能量增加功率" + "损耗功率" = 0
  $
