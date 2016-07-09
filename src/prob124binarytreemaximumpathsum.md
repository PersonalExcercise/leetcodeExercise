# problem 124. Binary Tree Maximum Path Sum

[题目链接](https://leetcode.com/problems/binary-tree-maximum-path-sum/)

## 方法

里面应该包含了动态规划的思想： 设 L(N)表示以此根节点N结尾的序列的最大和，那么有 

```XML
L(N) = max( L(N->left) , L(N->right), VAL(N)) , VAL(N)表示节点N的值
```

然后，序列的最大和就是 

```XML
maxSum = max(maxSum, L(N) , L(N->left) + VAL(N) + L(N->right));
```

由上公式，比较明显看出需要后序遍历。

然后一个问题就是，如果处理空节点。我的处理是返回INT_MIN ， 但是遇到了问题，如果节点也是负数，那么`INT_MIN`加上该负数就越界乘成正数了，导致求最大值的函数出错！（这个CASE没有想到啊！还是提交出错才发现的）于是我尝试加判断，写了一会儿总觉得写不清楚！同时开始怀疑加判断有何意义？如果是防止负数相加越界，那么两个正数相加也可能越界啊！于是，我就把int变为了long long，这样即使两个`INT_MIN`相加，也不会有问题了。

然而始终是很UGLY的写法。看了下DISCUSS [Accepted short solution in Java](https://discuss.leetcode.com/topic/4407/accepted-short-solution-in-java)，原来可以这样：

```C++
lval = max(0, L(n->left));
rval = max(0, L(n->right));
maxVal = max(maxVal, lval + rval + n->val);
return max(lval, rval) + n->val;
```

真的，看到这里，我才决定，这个才是HARD的来源。

## 代码

这是仿造了DICUSS的版本，我觉得这才是正确的吧。

```C++
class Solution {
public:
    int maxPathSum(TreeNode* root) {
        int globalMax = numeric_limits<int>::lowest();
        getEndWithNodeMaxSumAndSetGlobalMaxSum(root, globalMax);
        return globalMax;
    }
private:
    int getEndWithNodeMaxSumAndSetGlobalMaxSum(TreeNode *node, int &globalMax)
    {
        if(nullptr == node){ return numeric_limits<int>::lowest(); }
        int endWithLeftChildMaxSum = max(0, getEndWithNodeMaxSumAndSetGlobalMaxSum(node->left, globalMax));
        int endWithRightChildMaxSum = max(0, getEndWithNodeMaxSumAndSetGlobalMaxSum(node->right, globalMax));
        int endWithNodeMaxSum = max(endWithLeftChildMaxSum, endWithRightChildMaxSum) + node->val;
        globalMax = max(globalMax, endWithLeftChildMaxSum + endWithRightChildMaxSum + node->val);
        return endWithNodeMaxSum;
    }
};
```

## 后记

变量名长了真的让人没有编码动力了！以后不再定义这么长的变量名！