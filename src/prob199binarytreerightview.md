# problem 199. Binary Tree Right Side View

[题目链接](https://leetcode.com/problems/binary-tree-right-side-view/)

## 方法

很简单的一道题，直观想法就是用层序遍历（队列中保留层次信息），每次保留每层最后一个元素即可。

发现运行时间不快。

后来看题解，发现他们用类先序的递归方法，维护一个当前的深度信息，如果结果列表的大小小于深度，那么就应该把当前值作为结果放入结果列表中；然后再先遍历右子树，再遍历左子树。由此右子树就会先访问到，因此看到的就是右侧视图。这算是一个很tricky的方法。

然后递归的时间竟然比循环短！注意，上述两种方法，时间复杂度是一样的！

## 代码

还是贴上我的层序遍历版。

```C++
class Solution {
public:
    vector<int> rightSideView(TreeNode* root) {
        if(root == nullptr){ return {};}
        queue<TreeNode *> levelNodeList;
        vector<int> rightView;
        levelNodeList.push(root);
        while(!levelNodeList.empty())
        {
            rightView.push_back(levelNodeList.back()->val);
            int curLevelSize = levelNodeList.size();
            for(int i = 0; i < curLevelSize; ++i)
            {
                TreeNode *node = levelNodeList.front();
                levelNodeList.pop();
                if(node->left){ levelNodeList.push(node->left); }
                if(node->right){ levelNodeList.push(node->right); }
            }
        }
        return rightView;
    }
};
```

## 后记

猜测可能是queue动态申请内存、空间扩增的额外开销导致了时间比递归的慢。然而，这这种粒度上，这点比时间也没什么意义。

只要时间复杂度是一样的就好了。

而且，用更直观的方法，当然是更加推荐的！