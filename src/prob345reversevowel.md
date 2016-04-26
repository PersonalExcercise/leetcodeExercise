###problem 345. Reverse Vowels of a String

[link](https://leetcode.com/problems/reverse-vowels-of-a-string/)


## 方法

嗯，还是很简单的一个题。

同样使用了快排中双指针的思想。

## 代码

class Solution {
public:
    string reverseVowels(string s) {
        string::iterator f = s.begin() ,
                         r= s.end() -1 ;
        while( f < r)
        {
            while(f < r && !isVowelChar(*f) ) ++f ;
            while(f < r && !isVowelChar(*r) ) --r ;
            swap(*f , *r) ;
            ++f ; // 在快排中，没有这步；那是因为快排交换后，上面的两个while循环机肯定会满足，则两指针会改变。
            --r ; // 但是在这里，交换后while循环还是不满足，必须手动更新一位。
        }
        
        return s ;
    }
private:
    bool isVowelChar(char c)
    {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' 
            || c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }
};


## 其他

刚开始用迭代器出错了，后来又好了，估计是之前写错了。

不过还是了解了两个地方：

1. 迭代器不能输出

        cout << ite  ；

    上述代码将报错！ 
    ```
    cannot bind ‘std::ostream {aka std::basic_ostream<char>}’ lvalue to ‘std::basic_ostream<char>&&’
    ```

    没有看懂为何会错误！

2. 运算符优先级！

        cout << ite1 == ite2 ;

    上述代码是错误的，编译不过，因为实际解释时如下：

        ( cout << ite ) == ite 

    `<<` 的优先级是高于`比较运算符`的，如`<` , `>` , `==`等 

    所以括号需要加上！

        cout << (ite1 == ite2) ;