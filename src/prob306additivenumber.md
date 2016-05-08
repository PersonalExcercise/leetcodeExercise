###problem 306. Additive Numbe

[link](https://leetcode.com/problems/additive-number/)

## 方法

首先是加法，所以满足任意加数位数小于等于和，且最多小1位，且此时和的最高位是1。

其次，每个数（如果长度大于1），就不能是0开头的。

有了上面两个总结，写起来就比较清晰了。

最后，考虑大加数的情况，于是就放弃用str转int再加，而是直接用`prob2-add 2 numbers`中逐位相加。当时做prob2，就是看到这个题才特意去做的。

总的来说，其实是不难的...

感觉自己写得很费劲... 感觉已经尽可能优化了，但是仍然耗时2ms，只打败了`10%`的用户。

看了DISCUSS，hot的方法，使用递归和字符串操作，竟然0ms。

不知道是不是inline请求失败的原因。

## 代码

```C++
class Solution {
public:
    bool isAdditiveNumber(string num) {
        // the key is to find the place , that the first 3 number satisfied the additive
        for(unsigned num1_len = 1 ; num1_len <= num.size() / 2 ; ++num1_len)
        {
            
            // num1 max lenth is floor(num.size() /2)
            for(unsigned num2_len = 1 ; num2_len <= (num.size() - num1_len) / 2 ; ++num2_len)
            {
                // num2 max length is floor( (num.size() - num1_len) / 2)
                unsigned num1_spos = 0 ,
                         num1_epos = num1_len , // [spos , epos )
                         num2_spos = num1_epos , 
                         num2_epos = num2_spos + num2_len ,
                         sum_spos = num2_epos ;
                // sum lenth has 2 possibilities
                // 1. len = max(num1_len , num2_len) (no carry)
                // 2. len = max(num1_len , num2_len) + 1 (with carry) (here , leading number must be '1')
                int sum_len = max(num1_len , num2_len) ;
                
                if(sum_spos + sum_len  > num.size()) continue ; // check length
                
                // case 1
                bool is_additive = is_additive_of_3num(num , num1_spos , num1_epos , num2_spos , num2_epos ,
                                                             sum_spos , sum_spos + sum_len) ;
                if(!is_additive && num[sum_spos] == '1' && sum_spos + sum_len + 1 <= num.size())
                {
                    ++sum_len ;
                    is_additive = is_additive_of_3num(num , num1_spos , num1_epos , num2_spos , num2_epos ,
                                                             sum_spos , sum_spos + sum_len) ;
                }
                if(is_additive)
                {
                    // successor additive test
                    bool test_rst = test_successor_num(num , num1_spos , num1_epos , num2_spos , num2_epos ,
                                                             sum_spos , sum_spos + sum_len) ;
                
                    if(test_rst == true) return true ;
                }
                
                
            }
            
        }
        return false ;
    }
private :
    inline
    bool is_additive_of_3num(const string &s , unsigned num1_spos , unsigned num1_epos , 
                                               unsigned num2_spos , unsigned num2_epos ,
                                               unsigned sum_spos , unsigned sum_epos)
        {
            // is valid number
            if( !is_valid_number(s , num1_spos , num1_epos) || !is_valid_number(s , num2_spos , num2_epos)
                || !is_valid_number(s , sum_spos , sum_epos))
            {
                return false ;
            }
           
            int carry = 0 ;
            while(num1_epos > num1_spos && num2_epos > num2_spos)
            {
                int bit_add_val = s[--num1_epos] - '0' + s[--num2_epos] - '0' + carry ;
                int bit_rst = bit_add_val % 10 ;
                carry = bit_add_val / 10 ;
                // check is ok
                if( s[--sum_epos] - '0' != bit_rst ) return false ; // not additive
            }
            while(num1_epos > num1_spos)
            {
                int bit_val = s[--num1_epos] - '0' + carry ;
                int bit_rst = bit_val % 10 ;
                carry = bit_val / 10 ;
                if(s[--sum_epos] - '0' != bit_rst) return false ;
            }
            while(num2_epos > num2_spos)
            {
                int bit_val = s[--num2_epos] - '0' + carry ;
                int bit_rst = bit_val % 10 ;
                carry = bit_val / 10 ;
                if(s[--sum_epos] - '0' != bit_rst) return false ;
            }
            if(1 == carry)
            {
                if(sum_epos == sum_spos + 1 && s[sum_spos] == '1') return true ; 
                else return false ;
            }
            else 
            {
                if(sum_epos == sum_epos) return true ;
                else return false ;
            }
        }
        
    inline
    bool is_valid_number(const string &s , unsigned spos , unsigned epos)
    {
        if(epos > spos + 1 && '0' == s[spos] ) return false ; // length > 1 && '0' is leading
        return true ;
    }
    
    inline
    bool test_successor_num(const string &num , unsigned num1_spos , unsigned num1_epos , 
                                                unsigned num2_spos , unsigned num2_epos ,
                                                unsigned sum_spos , unsigned sum_epos)
    {
        while(sum_epos < num.size())
        {
            num1_spos = num2_spos ;
            num1_epos = num2_epos ;
            num2_spos = sum_spos ;
            num2_epos = sum_epos ;
            sum_spos = sum_epos ;
            unsigned sum_len  = max(num1_epos - num1_spos , num2_epos - num2_spos) ;
            sum_epos = sum_spos + sum_len ;
            if(sum_epos > num.size()) return false ;
            bool is_additive = is_additive_of_3num(num , num1_spos , num1_epos , num2_spos , num2_epos , 
                                                         sum_spos , sum_epos) ;
            if(!is_additive && num[sum_spos] == '1' && sum_epos + 1 <= num.size() )
            {
                ++sum_epos ;
                is_additive = is_additive_of_3num(num , num1_spos , num1_epos , num2_spos , num2_epos ,
                                                        sum_spos , sum_epos) ;
            }
            if(!is_additive) return false ;
        }
        if(sum_epos == num.size()) return true ;
        return false ;
    }
};
```
