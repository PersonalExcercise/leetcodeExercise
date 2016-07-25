# problem 341. Flatten Nested List Iterator

[题目链接](https://leetcode.com/problems/flatten-nested-list-iterator/)

## 方法

啊，做得好别扭啊！

NestedInteger的API：

```C++
const vector<NestedInteger> &getList() const;
```

我感觉太不合理了啊！你分别定义一个const和非const版本才对啊！而且返回什么引用呢！自己之前用一个非const指针去接受返回值，结果编译竟然过了，但是结果莫名其妙错了！后来换成const的好了，但是怎个写起来真是别扭啊！！！

不吐槽了，自己思考的也不全面： 对一下两种情况分别均为考虑：

1. `[[]]` 

2. `[[], 3]`

也是服了。总之，这个题也不是那么简单吧。

最后，我有点不太清楚 hasNext 和 next操作分别应该做什么事情。我觉得hasNext应该保证const的，但是我的代码里没有这样做，因为如果这样做了，那么hasNext和next将会做同样的操作。因为觉得这道题API混乱，我就停止考虑给出一个合理的API了。


## 代码

```C++
class NestedIterator {
private:
    void move2AvailElement()
    {
        while(true)
        {
            if(curPos < curCont->size())
            {
                const NestedInteger *ptr = &curCont->at(curPos);
                if(ptr->isInteger()){ break; } // ptr point to an integer , ok
                else
                {
                    posStack.push(curPos + 1);
                    contStack.push(curCont);
                    curPos = 0;
                    curCont = &ptr->getList();
                }
            }
            else
            {
                if(posStack.empty()){ break; } // over , no available element
                else
                {
                    curPos = posStack.top(); posStack.pop();
                    curCont = contStack.top(); contStack.pop();
                }
            }
        }
    }
public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        curPos = 0;
        curCont = &nestedList;
    }

    int next() {
       move2AvailElement();
       ++curPos;
       return curCont->at(curPos - 1).getInteger();
    }

    bool hasNext() {
        move2AvailElement();
        return curPos < curCont->size();
    }
private:
    stack<size_t> posStack;
    stack<const vector<NestedInteger> *> contStack;
    size_t curPos;
    const vector<NestedInteger> *curCont;
};
```