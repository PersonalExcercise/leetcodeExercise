# problem 77. Combinations

[题目链接](https://leetcode.com/problems/combinations/)

## 方法

与[求和为n的所有组合](prob39combinationsum.md)完全类似——如果使用递归版本的话。

当时一连做了3个相似的题，记住了递归的方法，非常直观，可是也非常不错。这次看着题还是非常有印象的，迅速做完，只是时间上似乎不是很好。

于是看了DISSCUSS上的迭代版，[Short Iterative C++ Answer 8ms](https://leetcode.com/discuss/63109/short-iterative-c-answer-8ms)。所谓8ms的方法，的确非常不错。

主要是这样的思想：

依次从后往前构建所有可能的组合：

1. 初始指针为0 ， 初始指针指向位置值为0；

2. 递增指针指向位置的值。

3. 判断指针指向的值是否超过了最大值，如果是，则指针回退（表示当前位置已经产生了所有可能，需要改变前面的值）；如果回退后的指针值小于0，则退出；否则回到2

4. 互斥判断指针位置是否已经是最后一个位置，如果是，则将当前值序列存储到结果中。回到2。

3. 互斥判断指针未到末尾，则指针移动到下一个位置，且赋值下一个位置为前一个位置的值；回到2

非常的巧妙。


## 代码

贴上我的递归代码，迭代版简直就是抄的。

```C++
class Solution {
public:
    vector<vector<int>> combine(int n, int k) {
        if(n <1 || k < 1){ return { {} } ;}
        vector<vector<int>> result;
        vector<int> currentSet;
        generateCombinationRecursively(currentSet, 1, n, k, result);
        return result;
    }
private:
    void generateCombinationRecursively(vector<int> &currentSet, int startNum, int n, 
                                        int nrLeftNum, vector<vector<int>> &result)
    {
        for(int i = startNum; i <= n - nrLeftNum + 1 ; ++i)
        {
            currentSet.push_back(i);
            if(nrLeftNum == 1)
            {
                result.push_back(currentSet);
            }
            else
            {
                generateCombinationRecursively(currentSet, i+1, n, nrLeftNum-1, result);
            }
            currentSet.pop_back();
        }
    }
};
```

## 后记

递归版上午完成，时间时`100ms`,发现当前状态vector传递时忘了传引用，改过来后变为`88ms`.

下午完成迭代版，然后写出来时间到了188ms , 把`at`换成下标访问，时间变为`117ms`！怎么都与8ms差太多了啊...于是我只好copy 帖子的代码，贴到框里，结果是`128ms`.

所以，不好说是不是递归的快，但是反正——时代变迁，以前的记录可能是在不同的硬件条件、不同的测试用例下得到的。不可重现啊。

然后牛逼的方法却绝不会过时！递归更加通用，迭代的确更加省空间。