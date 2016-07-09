# problem 232. Implement Queue using Stacks

[题目链接](https://leetcode.com/problems/implement-queue-using-stacks/)

## 方法

双栈实现队列，这是一个对用队列实现栈稍微巧妙一些的问题。

我们用两个栈来实现队列，但不需要再每次push、pop之前把一个栈内容全部腾空到另一个栈中。具体的，用一个栈来存储push的内容，用一个栈来放pop的内容。每次push，我们都直接把内容push到push栈里；每次pop，如果pop栈不空，那么直接从pop栈中弹出，如果为空，那么把push栈中的元素一次性全部倒进pop里。

关键就是，每次往pop栈中放时，pop栈是空的，且把push栈里的内容全部都倒了进去。这样下次push时，push不会乱序；pop时，也不会乱序。其中“全部”非常关键，如果只能倒部分，就可能不可行了。

## 代码

```C++
class Queue {
public:
    // Push element x to the back of queue.
    void push(int x) {
        s4store.push(x);
    }

    // Removes the element from in front of queue.
    void pop(void) {
        peek();
        // assert (!s4out.empty());
        s4out.pop();
    }

    // Get the front element.
    int peek(void) {
        if(s4out.empty())
        {
            while(!s4store.empty())
            {
                s4out.push(s4store.top());
                s4store.pop();
            }
        }
        // assert( !s4out.empty());
        return s4out.top(); 
    }

    // Return whether the queue is empty.
    bool empty(void) {
        return s4store.empty() && s4out.empty();
    }
private:
    stack<int> s4store;
    stack<int> s4out;
};
```