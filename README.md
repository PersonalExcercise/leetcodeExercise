# leetcodeExercise

1. 找满足确定和的两个数

    [detail](src/prob1twosum.md)

    **HashTable**

2. 两数相加
    
    [detail](src/prob2add2numbers.md)

    **链表** *数学*

3. 最长不包含重复字符串的子串

    [detail](src/prob3longestsubstringwithoutrepeatingcharaters.md)

    **双指针** ； **hashTable** ； **快速匹配**

5. 最长回文子串

    [detail](src/prob5longestpalindromicsubstring.md)

    **回文**；**已有算法**；**Manacher's Algorithm**

7. 反转整数
    
    [detail](src/prob7reverseinteger.md)

    **数学**；**如果检查越界问题！——除以10是否等于原数**

9. 一个数是不是回文数

    [detail](src/prob9palindromenumber.md)

    **数学**；**回文**

12. 整数转罗马数字
    
    [detail](src/prob12integer2roman.md)

    **转换**

13. 罗马数字转整数

    [detail](src/prob13roman2integer.md)

15. 找3个数和为0的所有不重复组合

    [detail](src/prob15threesum.md)

    **三数和为特定值的所有可能**

18. 找4个数的和为特定值的所有不重复组合

    [detail](src/prob18foursum.md)

26. Unique操作

    **双指针** **unique**

    [detail](src/prob26removeduplicatesfromsortedarray.md)

27. 删除字符串中给定值（所有的）

    **双指针**

    [detail](src/prob27removeelement.md)

29. 不用乘法、除法、模运算做除法
    
    **位操作**； **二分查找？**； **除法就是被除数包含多少个除数**

    [detail](src/prob29dividetwointegers.md)

33. 在排序后旋转的数组中搜索

    [detail](src/prob33searchinrotatedsortedarray.md)

    **类·二分查找**；**旋转数组**

34. 确定排序数组中某个数的位置

    **二分查找**；

    **STL** ； **lower_bound** ； **upper_bound** ； **equal_range** ；

    [detail](src/prob34searchforarange.md)

35. 确定插入位置

    **二分查找** ； **插入**

    **二分查找违背条件而退出时，必然有`low=high+1`**

    **循环条件是小于等于**

    [detail](src/prob35searchinsertposition.md)

39. 从集合中找出一些数使得其和为某个值，找出的数集合彼此不能重复

    **递归** , **组合**

    **回溯**

    [detail](src/prob39combinationsum.md)

40. 从数组中找出一些数，每个数至多选中一次，找出的数集合彼此不能重复

    **递归** ， **组合**

    **回溯**

    [detail](src/prob40combinationsumII.md)

44. 通配符匹配

    [detail](src/prob44wildcardmatching.md)

    **动态规划** —> 慢

48. 顺时针旋转方阵

    [detail](src/prob48rotateimage.md)

    **顺时针旋转，等价于第一行放第二列；或者先沿/对角线交换，再按行反转**

50. 求x的n次方 , pow(double x , int n)

    [detail](src/prob50pow.md)

    **二分** ； **分治**

    一定要考虑n 为负的情况！ 一定要考虑n为0的情况。

53. 最大子数组和，Maximum Subarray

    [detail](src/prob53maxsubarray.md)
    
    一道比较有意思的题目。

    **分治** ； **动态规划** ；

55. Jump Game ，求能否到达数组的最后一个位置
    
    [detail](src/prob55jumpgame.md)

    **贪心** ； **动态规划**

    贪心不简单啊。  

57. 插入区间到一个区间序列中

    [detail](src/prob57insertinterval.md)

    **数组**

    **区间** ， **插入**

60. 找到第k个n位随机数（排列数）

    [detail](src/prob60permutationsequence.md)

    **数学**；**枚举**；**规律**

    **类·进制转换**

61. 旋转链表

    [detail](src/prob61rotatelist.md)

    **链表循环移位**；**改变指针指向**

62. 到达目标的不同路径

    [detail](src/prob62uniquepaths.md)
    
    **动态规划**

    **组合**

63. 有障碍情况下到达目标的不同路径
    
    **动态规划**

    [detail](src/prob63uniquepaths2.md)


64. 给定一个代价矩阵，从起点到终点（左右、上下只能取1个方向），求最小代价及相应的路径
    
    [detail](src/prob64minpathsum.md)

    **动态规划**

    到每个位置的最小代价，与其左（或右）和其上（下）的点有关。

66. 给vector表示的数加1
    
    [detail](src/prob66plusone.md)

67. 二进制字符串相加
    
    [detail](src/prob67addbinary.md)


69. 求一个整数的非精确平方根。 int sqrt(int x)

    [detail](src/prob69sqrt.md)

    **二分** ; **分治（剪枝）** 

70. 爬梯子的方法

    [detail](src/prob70climbingstairs.md)

    **动态规划** ； **类-斐波拉切**

71. 规范化路径表示

    [detail](src/prob71simplifypath.md)

    **栈**

72. 编辑距离

    [detail](src/prob72editdistance.md)

    **动态规划** ； 

    *经典*

73. 如果矩阵中某个位置含有0，则清空该行、该列
    
    [detail](src/prob73setmatrixzeroes.md)

    **逻辑**

77. 生成c(n,k)的所有可能

    [detail](src/prob77combinations.md)

    **组合**； **回溯** ； **递归与迭代**

78. 生成集合中所有子集

    [detail](src/prob78subsets.md)

    **所有子集**;**位操作——数的位对应集合元素取不取**；

    **迭代法**；**回溯与DFS**

79. 找字母表中是否有某个单词

    [detail](src/prob79wordsearch.md)

    **深搜DFS**；

    **迭代版因需要保持访问状态而超时，递归版因为能够恢复状态而通过**

80. uniq升级版——允许两次重复

    [detail](src/prob80removeduplicatesfromsortedarraysII.md)

    **双指针**

    **两种思维方式** ， **容器end()调用耗时显著性**

81. 在有重复的旋转排序数组中查找某个数是否存在

    [detail](src/prob81searchinrotatedsortedarrayII.md)

84. 直方图中最大矩形面积

    [detail](src/prob84largestrectangleinhistogram.md)

    **栈方法**

85. 最大全部为1的矩形面积

    [detail](src/prob85maximalrectangle.md)

    **动态规划**；

    *Hard*

    还有*栈方法*待完成。

86. 划分列表

    [detail](src/prob86partitionlist.md)

    **链表**； **边界条件注意！**

87. Scramble String

    [detail](src/prob87scramblestring.md)

    **暴力**；**递归**；**三阶动态规划**；**剪枝**；

    *Hard*；

89. Gray Code 生成n位格雷码

    [detail](src/prob89graycode.md)

    **递归**

    **格雷码**


91. 解码方法数

    [detail](src/prob91decodeways.md)

    **动态规划**；**递推**；

92. 反转链表的指定区间

    [detail](src/prob92reverselinkedlistII.md)

    **链表**

94. 树的中序（非递归）遍历
    
    [detail](src/prob94binarytreeinordertraversal.md)

    **中序遍历**； **非递归树遍历**

96. n个不同值构成的不同二叉搜索树数目

    [detail](src/prob96uniqbinarysearchtrees.md)

    **BST**; **动态规划**； **递归**；**二叉树**

97.  一个字符串是否有其他两个字符串交叉组合而成

     [detail](src/prob97interleavingstring.md)

     动态规划；

     *Hard*

98. 验证是否是二叉查找树

    [detail](src/prob98validBST.md)

    **二叉查找树，BST**

103. Z形层序遍历二叉树

    [detail](src/prob103binarytreezigzaglevelordertraversal.md)

    **层序遍历**； **Z形**

105. 从先序遍历序列和中序遍历序列重建二叉树

    [detail](src/prob105constructbinarytreefrompreorderandinordertraversal.md)

    **二叉树** ； **建树**； **先序遍历**； **中序遍历**； **遍历规律**

106. 从中序遍历序列和后续遍历序列重建二叉树

    [detail](src/prob106constructbinarytreefrominorderandpostordertraversal.md)

    **二叉树**；**建树**；**中序遍历**； **后序遍历**；

    **后序遍历反过来看不就跟中序遍历时一样的吗！**

108. 有序数组转为平衡的二叉查找树

    [detail](src/prob108convertsortedarray2bst.md)

    **二叉查找树，BST**

    **转换** ， **逆向** ， **数组**

109. 有序链表转为平衡二叉查找树

    [detail](src/prob109convertsortedlist2bst.md)

    **二叉查找树**

    **转换** ， **逆向** ， **中序遍历** ， **链表**

112. 找一条从二叉树根到叶节点的路径，其和等于某数

    [detail](src/prob112pathsum.md)

    **二叉树**；**迭代版后序遍历**

113. 找到所有的满足和为某数的从根到某一叶节点的路径

    [detail](src/prob113pathsumII.md)

    **二叉树**；**迭代版后后序遍历**；

114. 把一棵二叉树转为一个先序遍历结果的链表

    **先序遍历**+记录前一个节点 ； **后序遍历** 右左根 = r(根左右)

    [detail](src/prob114flattenbinarytree2linkedlist.md)


115. 计数：与一个串相同的不同子串数量

    [detail](src/prob115distinctsubsequences.md)

    **动态规划** ； 

    **题目不清**；

116. 给完全二叉树每个节点找到每层右边的节点

    [detail](src/prob116populatingnextrightpointersineachnode.md)

    **树**

    **类·层序遍历** ； **常量空间**

117. 给任意一颗二叉树每个节点找到每层右边的节点

    [detail](src/prob117populatingnextrightpointersineachnodeII.md)
    
    **树**

    **类·层序遍历** ； **常量空间**

120. 一个三角形从顶到底的最小和。

    [detail](src/prob120triangle.md)

    **动态规划**

    直观上肯定是自顶向下的做动态规划；但是*如果反过来，从底往上做，一下子就变得清晰简单多了*!

121. 买卖股票赚大钱I

    [detail](src/prob121besttimetobuyandsellstock.md)

    **动态规划**

122. 买卖股票赚大钱II

    [detail](src/prob122besttimetobuyandsellstockII.md)

    **贪心**

123. 买卖股票赚大钱III

    [detail](src/prob123besttimetobuyandsellstockIII.md)

    **动态规划**（非典型）

    想错了的题！！

124. 二叉树最大路径和

    [detail](src/prob124binarytreemaximumpathsum.md)

    **动态规划**；**后序遍历**；

129. 从根到叶节点构成的数字之和
    
    [detail](src/prob129sumroottoleafnumbers.md)

    **二叉树**；**非迭代后序遍历**；

132. 回文字符串最小分割

    [detail](src/prob132palindromep.md)

    **动态规划**

    与矩阵链乘类似。如果使用二维的动态规划，则超时，换为一维的终于通过了。一维的优化子结构是，定义从该位置到末尾位置的最小分割数。

133. 克隆无向图

    [detail](src/prob133clonegraph.md)

    **图遍历**

136. 在一堆都出现两次的数中找唯一只出现一次的数

    [detail](src/prob136singlenumber.md)

    **位操作**；**A异或A等于0**；**异或运算满足交换律**；**0异或A等于A**

137. 在一堆都出现三次的数中找唯一一个只出现一次的数

    [detail](src/prob137singlenumberII.md)

    **位操作**；**使用异或来计数**；**巧妙**

138. 复制待随机指针的链表

    [detail](src/prob138copylistwithrandompointer.md)

    **利用已有的指针！**；**HashTable**

139. 句子是否可由词典中的词构成

    [detail](src/prob139wordbreak.md)

    **动态规划**

140. 句子的所有划分结果

    [detail](src/prob140wordbreak2.md)

    **动态规划**

    **深度搜索**

    **生成所有可能结果**

145. 二叉树的后序非递归遍历

    [detail](src/prob145BSTpostorder.md)

    **树的后序遍历**

    *判断上一个访问的节点是否是其右孩子，如果是则说明是从右回溯

148. 排序链表

    [detail](src/prob148sortlist.md)

    **归并排序**；**链表**；**非递归归并排序**

151. 反转句子中的单词顺序

    [detail](src/prob151reversewordsinastring.md)

    **双重反转**

    **块反转**


152. 最大乘积的子数组

    [detail](src/prob152maximumproductsubarray.md)

    **最大XX子数组**

    **动态规划** （模式：以该位置结尾的子序列）

153. 找旋转数组中的最小值

    [detail](src/prob153findminimuminrotatedsortedarray.md)

    **旋转数组**；**二分查找-变体**

160. 找两个无环链表第一个相交节点

    [detail](src/prob160intersectionoftwolinkedlists.md)

    **两个无环链表第一个相交节点**

162. 找局部最大值

    [detail](src/prob162findpeekelement.md)

    **二分搜索**

164. 线性时间找到未排序数组的排序位置下最大相邻间隔

    [detail](src/prob164maximumgap.md)

    **线性时间排序**

    **桶排序** ； **浮点数不精确**

165. 比较版本号的大小

    [detail](src/prob165compareversionnumber.md)

    **边界条件！**；**不要想当然觉得输入就是合法、归一化的！**

166. （循环小数）除法
    
    [detail](src/prob166fractiontorecurringdecimal.md)

    **循环小数除法** ； **Hash记录位置**；

    **最小负数的绝对值无法表示！只能提升到更大的类型**

168. 数字转为Excel列字母的表示

    [detail](src/prob168excelsheetcolumntitle.md)

    **进制转换**

171. Excel列字母转为数字

    [detail](src/prob171excelsheetcolumnnumber.md)

    **进制转换**


173. 二叉查找树迭代器

    [detail](src/prob173binarysearchtreeiterator.md)

    **二叉查找树**； **迭代器实现**

    **中序遍历二叉查找树得到递增序列**

174. 地牢游戏

    [detail](src/prob174dungeongame.md)

    **动态规划**

179. 拼成一个最大数

    [detail](src/prob179largestnumber.md)

    **排序**！！

188. 买卖股票赚大钱IV

    [detail](src/prob188besttimetobuyandsellstockIV.md)

    **动态规划**

190. 反转二进制位

    [detail](src/prob190reversebits.md)

    **位操作**

191. 二进制数中1的个数/ 汉明重量(Hamming Weight) / popcount

    
    [detail](src/prob191numberof1bits.md)

    **位操作**

    **有背景的题** **__builtin_popcount/std::bitset<32>**

198. 房屋偷盗
    
    [detail](src/prob198houserobber.md)

    **受限DP**; **两个状态序列**；

199. 二叉树的右侧视图

    [detail](src/prob199binarytreerightview.md)

    **层序遍历**；**保持递归访问顺序**

200. 海中岛的数量

    [detail](src/prob200numbersofislands.md)
    
    **连通路径**

    **遍历**

202. 快乐数
    
    [detail](src/prob202happynumber.md)

    **循环判断**； **Floyd Cycle Detection 或者 HashTable判重**； 

205. 字符串是否同构

    [detail](src/prob205isomorphicstrings.md)

    **双射模式匹配**； ***HashTable*

207. 课表是否可排

    [detail](src/prob207courseschedule.md)

    **拓扑排序(topological sort)**

213. 环形房屋偷盗

    [detail](src/prob213houserobberII.md)

    **受限DP**

216. 从1-9中找出k个不同的数，使得其和为n

    **递归**

    **回溯**

    [detail](src/prob216combinationsumIII.md)

217. 数组中是否包含重复

    **HashTable**

    [detail](src/prob217containsduplicate.md)

219. 数组中在K距离内是否包含重复

    [detail](src/prob219containsduplicateII.md)

221. 0，1矩阵全为1的最大正方形面积

    
    **动态规划**

    [detail](src/prob221maximalsquare.md)

223. 两个矩形的总面积

    [detail](src/prob223rectanglearea.md)

    **数学**

    **相交矩形的面积： X = min(右上角X1， 右上角X2) - max（左下角X1，左下角X2）， Y同理**


226. 反转二叉树

    **Homebrew作者挂掉的题**

    [detail](src/prob226invertbinarytree.md)

228. 从递增数字序列中合并区间表示

    [detail](src/prob228summaryranges.md)

    **数组**

231. 是否是2的平方

    [detail](src/prob231poweroftwo.md)

    **数学**；**位操作**

232. 使用栈实现队列

    **双栈实现队列，push O(1), pop 分摊O(1)**

    [detail](src/prob232implementqueueusingstacks.md)

234. 判断链表中的数字是否是回文关系
    
    **反转部分链表**；**一次遍历找链表的后半部分头指针**
    
    [detail](src/prob234palindromlinkedlist.md)

241. 加括号的不同方法
    
    **分治** **DP<未完成>**

    [detail](src/prob241differentwaystoaddparentheses.md)

242. 判断一个单词是否是另一个单词的易位构词(anagram)

    **hash_table**计数

    **排序** ！！

    [detail](src/prob242validanagram.md)

258. 求数根

    [detail](src/prob258adddigits.md)

    **数学**；

260. 从一堆出现两次的数中找到只出现一次的不同的两个数

    [detail](src/prob260singlenumberIII.md)

    **位运算**；**分组**；**num & (-num)得到位中右起第一个为1的值**；**(num-1) & num 去掉右起第一个为1的位**；

    **~(num-1) & num得到位中右起第一个为1的值**

263. 判断是不是丑数

    [detail](src/prob263uglynumber.md)

264. 找第N个丑数

    [detail](src/prob264uglynumberII.md)
    
    **多指针**; **有序**

268. 找到0到n中缺失的数

    [detail](src/prob268missingnumber.md)

279. 一个数有几个完全平方数加和得到

    **动态规划**；**广度优先搜索**；**深度优先搜索**；

    **数论**；**四平方和定理**；**三平方和定理**

    [detail](src/prob279perfectsquares.md)

290. 判断两个字符串模式是否相同

    **HashTable**

    [detail](src/prob290wordpattern.md)

300. 最长递增子序列 LIS

    **经典**

    **最长递增子序列**
    
    [detail](https://leetcode.com/problems/longest-increasing-subsequence/)

306. 是否是加数字符串

    **逻辑**

    **数学** ， **加法** ， *大数*
    
    [detail](src/prob306additivenumber.md)

315. 计算数组中每个位置的右边区域中小于该位置的数的个数

    [detail](src/prob315countofsmallernumberafterself.md)

    **二叉查找树；BST**

319. 灯泡最后是不是还亮着

    **智力题**；**数学**

    [detail](src/prob319bulbswitcher.md)

324. 摆动排序

    [detail](src/prob324wigglesortII.md)

    **找中位数median**； **3色排序（荷兰旗问题）**

    **没有弄懂**

328. 将链表奇数位置和偶数位置的数连到一起

    [detail](src/prob328oddevenlinkedlist.md)

    **链表**

329. 求矩阵中最长递增序列的长度

    [detail](src/prob329longestincreasingpathinmatrix.md)

    **拓扑排序**

    **DFS**

    **Memoization**

331. 验证一棵树的先序遍历得到的序列化串是否合法

    [detail](src/prob331verifypreorderserializationofabinarytree.md)

    **先序遍历满足的性质**

    **入度与出度** **巧妙**

    **栈**

334. 是否有 三数递增

    **三数递增**

    [detail](sec/prob334increasingtriplesubsequence.md)

337. 二叉房间偷盗者

    [detail](src/prob337houserobberIII.md)

    **受限DP**

338. 算0到num中每个数的二进制表示中1的个数 

    [detail](src/prob338countingbits.md)

    **非前一个位置的DP**；**位操作**

341. 实现NestedInteger的迭代器操作

    [detail](src/prob341flattennestedlistiterator.md)

    **实现**

343. 分解整数

    **怎么分解整数n使得其和为n而其乘积最大**——数学推导！

    [detail](src/prob343integerbreak.md)

345. 反序句子中的元音字母

    [detail](src/prob345reversevowel.md)

    **双指针**

347. 找序列中出现Top K次的元素

    [detail](src/prob347topkfrequentelements.md)

    **Top K**; **Min-Heap**

354. 俄罗斯套娃，能套多少个

    [detail](src/prob354russiandolldollenvelope.md)

    **二维元素的排序+LIS**

    **最长递增序列问题**

365. 水桶倒水问题

    [detail](src/prob365waterandjugproblem.md)

    **最大公约数**； **裴蜀定理**；

    **数论**； **深搜失败**

367. 验证一个数是否是完全平方数

    [detail](src/prob367validperfectsquare.md)

    **完全平方**；**数学**；**开方**；**二分查找**

371. 使用位运算做加法

    [detail](src/prob371sumoftwointegers.md)

    **位操作**

374. 猜数

    [detail](src/prob374guessnumberhigherorlower.md)

    **二分查找**

375. 猜数问题下的MinMax
    
    [detail](src/prob375guessnumberhigherorlowerII.md)

    **MinMax**
