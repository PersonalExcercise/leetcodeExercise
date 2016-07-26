# problem 187. Repeated DNA Sequences

[题目链接](https://leetcode.com/problems/repeated-dna-sequences/)

## 方法

总的想法依然是hashTable地找，但是很关键的一点，就是可以把长度为10的DNA序列编码为1个整数，且邻接的下一个字符串与当前的整数关系也很紧密，仅一个位置的不同。

有了这点认知，就很容易了。所以，关键是出现这点想法吧——将DNA字符串编码为数字。长度为10的确不是瞎说的。当然，最大能编码长度16的DNA。

## 代码

```C++
class Solution {
    const size_t DNAEncodingLimit = 10;
public:
    vector<string> findRepeatedDnaSequences(string s) {
        size_t sz = s.size();
        if(sz < 10){ return {}; }
        unordered_set<int> searchedSet,
                           repeatedSet;
        int val = dna2int(s);
        searchedSet.insert(val);
        for(size_t i = 10; i < sz; ++i)
        {
            val = generateNextInt(val, s[i]);
            if(searchedSet.count(val) > 0)
            {
                repeatedSet.insert(val);
            }
            else { searchedSet.insert(val); }
        }
        vector<string> result;
        for(auto iter = repeatedSet.begin(); iter != repeatedSet.end(); ++iter)
        {
            result.push_back(int2dna(*iter));
        }
        return result;
    }
private:
    int dnachar2bitval(char dnaChar)
    {
        switch(dnaChar)
        {
            case 'A' :
                return 0;
            case 'C' :
                return 1;
            case 'G' :
                return 2;
            case 'T' :
                return 3;
        }
        throw runtime_error("invalid dna char" + dnaChar);
        return 0;
    }
    char bitval2dnachar(int bitval)
    {
        switch(bitval)
        {
            case 0 :
                return 'A';
            case 1 :
                return 'C';
            case 2:
                return 'G';
            case 3:
                return 'T';
        }
        throw runtime_error("invalid bit val " + to_string(bitval));
        return 0;
    }
    int dna2int(const string &dnaStr)
    {
        // encoding , `reverse order`
        // assert(dnaStr.length() >= 10)
        int startPos = DNAEncodingLimit - 1;
        int encodeVal = 0;
        while(startPos >= 0)
        {
            encodeVal <<= 2;
            encodeVal |= dnachar2bitval(dnaStr[startPos]);
            --startPos;
        }
        return encodeVal;
    }
    string int2dna(int encodeVal)
    {
        string dnaStr = "";
        int leftCnt = DNAEncodingLimit - 1;
        while(leftCnt >= 0)
        {
            int bitVal = encodeVal & 0x3;
            dnaStr += bitval2dnachar(bitVal);
            --leftCnt;
            encodeVal >>= 2;
        }
        return dnaStr;
    }
    int generateNextInt(int val, char nextDNAChar)
    {
        val >>= 2;
        val |= (dnachar2bitval(nextDNAChar) << 18) ;
        return val;
    }
};
```


## 后记

写错了好多次... 中间吃了个饭，回来心情有点沮丧，感觉不太好... 可以更集中的！