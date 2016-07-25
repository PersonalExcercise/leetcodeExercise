# problem 315. Count of Smaller Numbers After Self

[题目链接](https://leetcode.com/problems/count-of-smaller-numbers-after-self/)

## 方法

一开始就瞎写一个，用 `dp[i] = dp[j] + 1, where j is the first index where num[j] < num[i]` , 后来测了一个实例发现真是错得离谱啊。

自己总是会想出一些错得很离谱的答案，也说明自己还是不够仔细、认真。应该把想法先写出来，把case都考虑到。

后来也想到了使用BST来做，但是又觉得稍微麻烦。看了题解，发现做法是在BST中维护一个小于当前值的节点数、等于当前节点值的数。通过从后往前构建BST完成计数。很完美。自己倒是觉得很沮丧。总觉得少了点什么啊。

## 代码

```c++
class Solution {
private:
    struct Node
    {
        int val;
        int lessCnt;
        int equalCnt;
        Node *left;
        Node *right;
        Node(int val): val(val), lessCnt(0), equalCnt(1), left(nullptr), right(nullptr){}
    };
public:
    vector<int> countSmaller(vector<int>& nums) {
        int nrNum = nums.size();
        if(nrNum == 0){ return {}; }
        Node *root = new Node(nums.back());
        vector<int> cntList(nrNum);
        for(int i = nrNum - 2; i >= 0; --i)
        {
            cntList[i] = buildBSTAndCount(root,nums[i]);
        }
        deleteBST(root);
        return cntList;
    }
private:
    int buildBSTAndCount(Node *root, int val)
    {
        //assert(root != nullptr);
        int cnt = 0;
        while(true)
        {
            if(val > root->val)
            {
                cnt += root->lessCnt + root->equalCnt;
                if(root->right){ root = root->right; }
                else
                {
                    root->right = new Node(val);
                    break;
                }
            }
            else if(val < root->val)
            {
                ++root->lessCnt;
                if(root->left){ root = root->left;}
                else
                { 
                    root->left = new Node(val); 
                    break;
                }
            }
            else
            { 
                ++root->equalCnt;
                cnt += root->lessCnt;
                break;
            }
        }
        return cnt;
    }
    void deleteBST(Node *root)
    {
        if(root == nullptr){ return; }
        deleteBST(root->left);
        deleteBST(root->right);
        delete root;
    }
};
```