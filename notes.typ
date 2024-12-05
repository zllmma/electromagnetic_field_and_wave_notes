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
    integral_(V) (phi gradient^2 psi - psi gradient^2 phi) dif V = integral.cont_S ( phi (diff psi) / (diff n) - psi (diff phi) / (diff n) ) dif S
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
      bold(D)(bold(r)) &= epsilon_0 bold(E)(bold(r)) + bold(P)(bold(r)) = epsilon_0 bold(E)( bold(r) )+chi_e epsilon_0 bold(E)(bold(r))\
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

两种特殊情况：一边的媒质为导体，一边的媒质为理想介质；两边是不同的理想介质

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
    nabla dot bold(S) + diff / (diff t) ( 1 / 2 bold(H) dot bold(B) + 1 / 2 bold(E) dot bold(D) ) + bold(E) dot bold(J) = 0\
    "进入的电磁能量功率" + "电磁场能量增加功率" + "损耗功率" = 0
  $

#let Re = $"Re"$
#let jj = $upright(j)$

== 时谐电磁场
=== 复数表示
设 $u(bold(r), t)$ 是一个以角频率 $omega$ 变化的标量函数，表达式为：
$
  u(bold(r), t) = u_m (bold(r))cos[ omega t + phi.alt (bold(r)) ]
$
可以通过复数取实部的方式表示为
$
  u(bold(r), t) &= Re{u_m (bold(r)) e^(jj phi.alt (bold(r))) e^(jj omega t)}\
  &= Re{accent(u, .)(bold(r)) e^(jj omega t)}
$
其中 $accent(u, .)(bold(r)) = u_m (bold(r)) e^(jj phi.alt (bold(r)))$，称为 $u$ 的复数表示，复矢量只与空间有关，与时间无关，因为默认我们知道了角频率

=== 复电容率和复磁导率
电导率为有限值的导电媒质存在欧姆损耗；电介质、磁介质中存在极化损耗和磁化损耗

在时谐场中，有
$
  nabla times bold(H) = sigma bold(E) + jj omega epsilon bold(E) = jj omega ( epsilon - jj (sigma) / (omega) )bold(E) = jj omega epsilon_c bold(E)
$
其中 $epsilon_c$ 称为等效复电容率
$
  epsilon_c = epsilon - jj sigma / omega
$

=== 平均坡印廷矢量

$
  bold(S)_(a v) &= 1 / T integral_(0)^(T) bold(S) dif t = omega / (2 pi) integral_(0)^( (2 pi) / omega) bold(S) dif t\
  &= 1 / 2 Re[bold(E) times bold(H)^*]
$

= 均匀平面波的传播
*平面波*：等相位面为无穷大平面的电磁波

*均匀平面波*：等相位面上电场和磁场的方向、振幅都保持不变的平面波
== 理想介质中的的均匀平面波
假设在无限大的无源空间中，充满线性、各向同性的均匀介质。时谐电磁场满足亥姆霍兹方程（这里暂时仅研究电场）
$
  nabla^2 bold(E) + k^2 bold(E) = 0 quad (k = omega sqrt(mu epsilon))
$
假设沿 $z$ 轴传播，则 $bold(E)$ 不是 $x$ 或 $y$ 的函数，即
$
  (diff bold(E)) / (diff x) = (diff bold(E)) / (diff y) = 0
$
则原矢量方程可化为以下的分量式
$
  cases(
    frac(dif^2 E_x, dif z^2) + k^2 E_x = 0,
    frac(dif^2 E_y, dif z^2) + k^2 E_y = 0,
    frac(dif^2 E_z, dif z^2) + k^2 E_z = 0,
  )
$
由于
$
  nabla dot bold(E) = (diff E_x) / (diff x) + (diff E_y) / (diff y) + (diff E_z) / (diff z) = 0 \
  => (diff E_z) / (diff z) = 0\
  => E_z = 0
$
所以又可化为
$
  cases(
    frac(dif^2 E_x, dif z^2) + k^2 E_x = 0,
    frac(dif^2 E_y, dif z^2) + k^2 E_y = 0,
  )
$
类似的，磁场也可化简

结论：均匀平面波的电场强度和磁场强度都垂直于波的传播方向 —— 横电磁波（TEM波）

解此方程（$x$ 分量），得
$
  E_x (z) &= A_1 e^(-jj k z) + A_2 e^(jj k z) \
  &= E_(1 m) e^(jj phi.alt_1) e^(-jj k z) + E_(2 m) e^(jj phi.alt_2) e^(jj k z)\
  => E_x (z, t) &= Re[E_x (t) e^(jj omega t)]\
  &= E_(1 m) cos(omega t - k z + phi.alt_1) + E_(2 m) cos(omega t + k z + phi.alt_2)
$
第一项表示沿 $+z$ 方向传播的均匀平面波，第二项表示沿 $-z$ 方向传播的均匀平面波，这里只讨论沿 $+z$ 方向传播的均匀平面波，即
$
  E_x (z) = E_(x m) e^(-jj k z) e^(jj phi.alt_x)
$

- 相伴的磁场

  由 $nabla times bold(E) = -jj omega mu bold(H)$，可得
  $
    bold(H) &= -frac(1, jj omega mu) nabla times bold(E)_x \
    &= - bold(e)_y (1) / (jj omega mu) (diff E_x) / (diff z) = -bold(e)_y (1) / (jj omega mu) ( -jj k E_x ) = bold(e)_y (k) / (omega mu) E_(x m) e^(-jj k z) e^(jj phi.alt_x)\
    &= bold(e)_y sqrt(epsilon / mu) E_(x m) e^(-jj(k z - phi.alt_x))\
    &= 1 / eta bold(e)_z times bold(E)_x
  $
  结论：均匀平面波的电场和磁场相互垂直且同相位。其中 $eta = sqrt(mu / epsilon)$ 为波阻抗，在真空中为 $eta_0 =sqrt(mu_0 / epsilon_0) = 377 Omega$

- 传播参数

  - 波长 $lambda$ ：空间相位差位 $2 pi$ 对应的两个波阵面的距离\
  - 相位常数（波数） $k$ ：传播单位距离的相位变化\
    $
      k lambda = 2 pi\
      => k = (2 pi) / lambda\
      => lambda = (2 pi) / k = (2 pi) / (omega sqrt(mu epsilon)) = 1 / (f sqrt(mu epsilon))
    $
  - 相速 $v_p$ ：等相位面传播的速度\
    $
      v_p = omega / k = 1 / sqrt(mu epsilon)
    $
    真空中的相速为
    $ c = 1 / sqrt(mu_0 epsilon_0) = 3 times 10^8 " " upright(m) \/ upright(s) $
  - 能量密度与能流密度

    电磁能量密度
    $
      w_e = 1 / 2 epsilon E_m^2 = w_m\
      w = w_e + w_m = epsilon E_m^2 = mu H_m^2\
    $
    坡印廷矢量
    $
      bold(S) = bold(E) times bold(H) = bold(e)_z 1 / eta E_m^2 cos^2(omega t - k z + phi.alt_x)
    $
    平均能量密度
    $
      w_(a v) = 1 / 2 epsilon E_m^2 = 1 / 2 mu H_m^2 = 1 / 2 eta E_m H_m
    $
    平均坡印廷矢量
    $
      bold(S)_(a v) &= 1 / 2 Re[bold(E)(z) times bold(H)^(*)(z)] = bold(e)_z 1 / (2 eta) E_m^2\
      &= bold(e)_z 1 / 2 epsilon E_m^2 1 / (sqrt(mu epsilon)) = bold(e)_z 1 / 2 epsilon E_m^2 v_p = w_(a v) bold(v)_p
    $

  - 综上，理想介质中的均匀平面波的传播特性为

    + 电场、磁场与传播方向之间相互垂直，是横电磁波（TEM波）
    + 无衰减，电场与磁场的振幅不变
    + 波阻抗为实数，电场与磁场同相位
    + 电磁波的相速与频率无关，无色散
    + 电场能量密度等于磁场能量密度，能量的传输速度等于相速

- 沿任意方向传播的均匀平面波

  设传播方向的单位矢量为 $bold(e)_n$，定义波矢量 $bold(k) = k bold(e)_n$，则电场矢量可表示为
  $
    bold(E)(bold(r)) = bold(E)_m e^(-jj bold(k) dot bold(r))
  $
  相应的磁场表示为
  $
    bold(H)(bold(r)) = 1 / eta bold(e)_n times bold(E)(bold(r)) = 1 / eta bold(e)_n times bold(E)_m e^(-jj bold(k) dot bold(r))
  $

== 导电媒质中的均匀平面波
导电媒质 $sigma != 0$，有传导电流存在，伴随着电磁能量的损耗

波动方程
$
  nabla^2 bold(E) + k_c^2 bold(E) = 0 quad (k_c = omega sqrt(mu epsilon_c), epsilon_c = epsilon' - jj epsilon^(''))
$
沿 $z$ 轴传播的均匀平面电磁波解为
$
  bold(E)(z) = bold(e)_x E_(x m) e^(-jj k_c z) = bold(e)_x E_(x m) e^(-gamma z)
$
令 $jj k_c = gamma$，$gamma = alpha + jj beta$（$gamma$ 称为传播常数），则
$
  bold(E)(z) = bold(e)_x E_(x m)e^(-alpha z) e^(-jj beta z)\
  => bold(E)(z, t) = bold(e)_x E_(x m) e^(-alpha z) cos(omega t - beta z)
$
$alpha$ 为衰减常数，$e^(-alpha z)$ 为衰减因子\
$beta$ 为相移常数，$e^(-jj beta z)$ 为相位因子\

- 相伴的磁场
  $
    bold(H)(z) = 1 / (eta_c) bold(e)_z times bold(E)(z) = bold(e)_y 1 / (abs(eta_c)) E_(x m) e^(-alpha z) e^(-jj (beta z + phi.alt))\
    => bold(H)(z, t) = bold(e)_y 1 / (abs(eta_c)) E_(x m) e^(-alpha z) cos(omega t - beta z -phi.alt)
  $
  本征阻抗 $eta_c = sqrt(mu/epsilon_c) = abs(eta_c) e^(jj phi.alt)$

- 传播参数
  $
    cases(
      gamma^2 = (jj k_c)^2 = -k_c^2 = -omega^2 mu (epsilon - jj sigma / omega),
      gamma^2 = (alpha + jj beta)^2 = alpha^2 - beta^2 + jj 2 alpha beta,
    ) => cases(
      alpha^2 - beta^2 = -omega^2 mu epsilon,
      2 alpha beta = omega mu sigma,
    )
  $
  解得 $alpha, beta$ 不仅与媒质有关，还与频率有关\
  又因为 $lambda = (2pi) / beta, v = omega / beta$，所以波长和相速也不仅与媒质有关，还与频率有关
- 平均坡印廷矢量
  $
    bold(S)_(a v) = 1 / 2 Re[bold(E)(z) times bold(H)^*(z)] = bold(e)_z 1 / (2 abs(eta_c)) E_(x m)^2 e^(-2 alpha z) cos phi.alt
  $

- 综上，导电媒质中的均匀平面波的传播特性为
  + 电场强度 $bold(E)$ 、磁场强度 $bold(H)$ 与波的传播方向相互垂直，是横电磁波（TEM波）；
  + 媒质的本征阻抗为复数，电场与磁场不同相位，磁场滞后于电场 $phi.alt$ 角；
  + 在波的传播过程中，电场与磁场的振幅呈指数衰减
  + 波的传播速度（相度）不仅与媒质参数有关，而且与频率有关（有色散）

- 弱导电媒质（$(sigma)/(omega epsilon) << 1$）
  $
    cases(
      alpha approx sigma / 2 sqrt(mu / epsilon),
      beta approx omega sqrt(mu epsilon),
    )\
    eta_c approx sqrt(mu/epsilon) (1 + jj sigma / (2 omega epsilon))\
  $
  特点：衰减小，相位常数与非导电媒质的大致相等，电场、磁场之间的相位差较小

- 良导体（$(sigma)/(omega epsilon) >> 1$）
  $
    alpha approx beta approx sqrt(omega mu sigma / 2) = sqrt(pi f mu sigma) prop sqrt(f)
  $
  相速
  $
    v = omega / beta approx sqrt((2 omega) / (mu sigma)) = sqrt(frac(4 pi f, mu sigma)) prop sqrt(f)
  $
  波长
  $
    lambda = (2pi) / (beta) = 2 sqrt(frac(pi, f mu sigma)) prop 1 / sqrt(f)
  $
  本征阻抗
  $
    eta_c = sqrt(mu/epsilon_c) approx sqrt(frac(jj omega mu, sigma)) = (1 + jj) sqrt(frac(pi f mu, sigma))
  $
  说明良导体中电磁波的*磁场强度的相位滞后于电场强度 $45^degree$*

  - 趋肤效应：$f arrow.t $，$alpha arrow.t$，高频电磁波只能存在于良导体的表面层内

  - 趋肤深度 $delta$ ：幅值衰减为表面的 $1/e$ 时传播的距离
  $
    - alpha delta = -1\
    => delta = 1 / alpha = 1 / (sqrt(pi f mu sigma)) prop 1 / sqrt(f)\
    => delta = 1 / beta = lambda / (2pi)
  $
- 群速

  由 $v_g = (dif omega) / (dif beta)$，可得（推导略）
  $
    v_g = frac(v_p,1 - omega / v_p (dif v_p) / (dif omega))
  $

== 电磁波的极化
一般情况下，沿 $+z$ 方向传播的均匀平面波 $bold(E) = bold(e)_x E_x + bold(e)_y E_y$
$
  E_x (z, t) = E_(x m) cos(omega t - k z + phi.alt_x)\
  E_y (z, t) = E_(y m) cos(omega t - k z + phi.alt_y)
$
极化的三种形式
#table(
  rows: auto,
  columns: 3,
  align: (center, center, center),
  [$Delta phi.alt = phi.alt_y - phi.alt_x$], [极化方式], [备注],
  [$0" 或 " plus.minus pi$],
  [线极化],
  [$Delta phi.alt = 0$，在1、3象限\ $Delta phi.alt = plus.minus pi$，在2、4象限
  ],

  [$plus.minus pi / 2$], [圆极化], [$Delta phi.alt = pi / 2$，左旋\ $Delta phi.alt = -pi/2$，右旋],
  [其他], [椭圆极化], [$0 < Delta phi.alt < pi $，左旋\ $-pi < Delta phi.alt < 0$，右旋],
)

== 均匀平面波的反射与透射
*现象*：电磁波从一介质传播到另一介质时，一部分反射，一部分透射\

*分析方法*：已知反射波和透射波的形式，通过边界条件确定具体参数

=== 媒质分界面的垂直入射
$
  cases(
    display(E_(i m) + E_(r m) = E_(t m)),
    display(1/(eta_(1 c)) (E_(i m) - E_(r m)) = 1/(eta_(2 c)) E_(t m))
  )
$
反射系数 $display(Gamma = E_(r m) / E_(i m) = frac(eta_(2 c) - eta_(1 c), eta_(2 c)+eta_(1 c)))$

透射系数 $display(tau = E_(t m) / E_(i m) = frac(2 eta_(2 c), eta_(2 c) + eta_(1 c)))$

性质：
- $1 + Gamma = tau$
- 若媒质2是理想导体，即 $sigma_2 = oo$，则 $eta_(2 c) = 0$，有 $Gamma = -1$，$tau = 0$
- 若两种媒质都是理想介质，即 $sigma_1 = sigma_2 = 0$，则 $Gamma = frac(eta_(2 ) - eta_(1 ), eta_(2 )+eta_(1 ))$，$tau = frac(2 eta_(2 ), eta_(2 ) + eta_(1 ))$

- 驻波系数
  $
    S = frac(1 + abs(Gamma), 1 - abs(Gamma))
  $
  $Gamma = 0$，$S = 1$，为行波\
  $Gamma = 1$，$S = oo$，为驻波

=== 多层介质平面的垂直入射
这里以三层为例\
等效波阻抗 $eta_(e f)$，媒质2和媒质3对 $z = 0$ 处的反射系数影响可用一种等效媒质来代替，此媒质的本征阻抗为 $eta_(e f)$
$
  eta_(e f) = eta_2 frac(eta_3 + jj eta_2 tan(beta_2 d), eta_2 + jj eta_3 tan(beta_2 d))
$
$
  Gamma_1 = frac(eta_(e f) - eta_1, eta_(e f) + eta_1)\
  tau_1 = frac(1 + Gamma_1, e^(jj beta_2 d)+Gamma_2 e^(-jj beta_2 d))
$

- 四分之一波长匹配层

  若媒质2厚度 $d = lambda_2 / 4$，$eta_2 = sqrt(eta_1 eta_3)$，就能消除媒质1表面的反射

- 半波长介质窗

  若 $eta_1 = eta_3$，当媒质2厚度 $d = lambda_2 / 2$ 时，就能消除反射，可以无损通过厚度为 $lambda_2 / 2$的媒质层

=== 理想介质分界面的斜入射
假设入射面在 $x z$ 平面上，入射角为 $theta_i$，折射角为 $theta_t$，反射角为 $theta_r$，则
$
  bold(e)_i = bold(e)_x sin(theta_i) + bold(e)_z cos(theta_i)\
  bold(e)_r = bold(e)_x sin(theta_r) - bold(e)_z cos(theta_r)\
  bold(e)_t = bold(e)_x sin(theta_t) + bold(e)_z cos(theta_t)
$

由边界条件得到结论为
$
  theta_r = theta_i\
  k_1 sin(theta_i) = k_2 sin(theta_t)
$
其中 $k_1 = omega sqrt(epsilon_1 mu_1), " " k_2 = omega sqrt(epsilon_2 mu_2)$

- 全反射与全透射

  全反射临界角 $theta_c = display(arcsin(sqrt(epsilon_2/epsilon_1)))$

  全透射临界角 $theta_c = display(arctan(sqrt(epsilon_2/epsilon_1)))$



= 导行电磁波

做以下假设：
- 波导内部是理想导体，即 $sigma = oo$
- 波导内填充无损耗介质
- 波导内无源，即 $rho = 0," "bold(J) = 0$
- 波导内的电磁场为时谐场

导波分类
- $E_z = 0, " "H_z = 0$，TEM波
- $E_z != 0, " "H_z = 0$，TM波
- $E_z = 0, " "H_z != 0$，TE波

== 矩形波导
可以传播TM波和TE波，不能传播TEM波

=== 场分布
矩形波导中的TE波和TM波的特点：
- $m, n$ 有不同的取值，对于每一种组合都有相应的截止波数 $k_(c m n) = [((m pi) / a)^2+((n pi)/b)^2]^(1/2)$ 和场分布，称为 $"TM"_(m n)$ 模或 $"TE"_(m n)$ 模

- 由于对相同的 $m$ 和 $n$，$"TM"_(m n)$ 模和 $"TE"_(m n)$ 模的截止波数 $k_(c m n)$ 相同，这种情况称为模式的简并；

- 不存在 $"TM"_(m 0)$ 和 $"TE"_(0 n)$ 模

=== 传播特性
相位常数
$
  beta_( m n) &= sqrt(omega^2 mu epsilon - ((m pi)/a)^2 - ((n pi)/b)^2)\
  &= k sqrt(1 - ((k_(c m n))/(k))^2)\
  &= k sqrt(1 - ((f_(c m n))/(f))^2)
$
波速
$
  v_(p m n) = omega / (beta_(m n)) = omega / (k sqrt(1-((f_(c m n))/(f))^2)) > omega / k
$
波导波长
$
  lambda_(g m n) = (2 pi) / (beta_(m n))
$
结论：当 $f > f_(c m n) = frac(k_(c m n),2 pi sqrt(mu epsilon))$ 时，矩形波导才能传播相应模式的电磁波

=== 主模
主模：截止频率最低的模式\
高次模：除主模以外的模式\

模式分布：
- 截止区：$lambda > 2 a$
- 单模区：$a<lambda<2a => lambda / 2 < a < lambda$
- 多模区：$lambda<a$

== 圆柱形波导
截止波数 $k_(c m n) = (P'_(m n)) / (a)$

截止频率 $f_(c m n) = (k_(c m n)) / (2 pi sqrt(mu epsilon))$

其余的一些参数和矩形波导基本一致

== 同轴波导

同轴波导传播TEM波

截止波数 $k_c = 0$，所以 $lambda_c = 0$，TEM模为主模\
传播常数 $gamma = jj k = jj omega sqrt(mu epsilon) = jj beta$\
相位常数 $beta = omega sqrt(mu epsilon)$\
相速 $v_p = omega / beta$\
波阻抗 $Z_(T E M) = E_(rho) / H_(phi.alt) = gamma / (jj omega epsilon) = sqrt(mu/epsilon) = eta$

== 谐振腔
=== 矩形谐振腔
可将一段矩形波导两端封闭而成

尺寸：$a times b times l$

不同的 $m,n,p$ 对应不同振荡模式，$"TE"_(m n p)$ 模或 $"TM"_(m n p)$ 模

- 谐振频率
$
  f_(m n p) = 1 / (2 sqrt(mu epsilon)) sqrt((m/a)^2+(n/b)^2+(p/l)^2)
$

== 传输线
- 传输TEM波的双导体传输线，例如平行双线、同轴线等
- 采用“路”的分析方法，把传输线作为分布参数电路处理
- 由基尔霍夫定律导出传输线方程，进而讨论波沿线的传播特性

=== 传输线方程及其解

= 电磁辐射