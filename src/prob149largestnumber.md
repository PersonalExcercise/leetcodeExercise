###problem 179. Largest Number 

[link](https://leetcode.com/problems/largest-number/)

## 方法

又被完爆的题。

竟然通过排序就达到了目的！

对于字符串`x` 和`y` ， 如果 `xy`构成的字符串比 `yx`大，那么`x`就应该在`y`的前面。这样，排序整个数组，将得到的结果从前往后拼接在一起，就是一个最大的数！

因为——对任意两个部分`x` , `y` （`x`在前，`y`在后），总有`xy` > `yx` 。

奇妙！

之前想了半天，确定了一种基于状态转移的方法，感觉可行：

1. 结果总长度为N

2. 从高位往低位排，最高位下标为0。

3. 处理第0个位置，从所有数字（字符串）中选出高位最大的。得到一个可能的集合，设为{a , b , c} 。

4. 准备处理下一个位置1，对状态集合中，新加入串长度大于1的，看次高位，选出最大的，其余长度大于1但次高位小的全部丢弃，假设得到{b , c} 。

5. 扩展长度为1的状态，选择高位大于等于状态集合中次高位最大的数字，与c组合成为新串加入到状态集合。

6. 重复4，直到完毕。

感觉上面描述很不清晰啊。而且的确非常麻烦，不过的确是自己想来最清晰的方法了。

然而还是排序好！

## 方法

```C++
class Solution {
public:
    string largestNumber(vector<int>& nums) {
        vector<string> nums_str ;
        transform(nums.cbegin() , nums.cend() , back_inserter(nums_str) , [](int i){ return to_string(i) ; }) ;
        
        sort(nums_str.begin() , nums_str.end() , LargestNumberCompare() ) ;
        string rst = accumulate(nums_str.begin() , nums_str.end() , string("")) ;
        // lstrip 0
        size_t first_not_zero_pos = 0 ;
        while(first_not_zero_pos < rst.length() && rst[first_not_zero_pos] == '0') ++first_not_zero_pos  ;
        return  (first_not_zero_pos == rst.length()) ?  "0" : rst.substr(first_not_zero_pos) ;
    }
private :
    struct LargestNumberCompare
    {
        bool operator() (const string &x , const string &y)
        {
            string xy = x + y ;
            string yx = y + x ;
            if(xy > yx)  // x should be ahead of y
                return true ; 
            else 
                return false ;
        }
    } ;
};
```