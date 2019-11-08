## 简单的js模版引擎 
1.全局安装jison 
```
npm npm install jison -g 
```
2.编写jison文件,写法类似lex/yacc语法,可参见github的例子,然后生成js文件
```
jison three.jison //得到three.js 
```
3.在入口文件里面引入parser并使用
```
require("jison")
let pas = require("./three.js").parser

pas.yy = { //可以通过给yy属性赋值来注入环境
  a: 1,
  b: 2,
  aasd: "123",
  fu: (aa) => {
    return aa * 2
  }
}
let a = "simple_add=>{{1+3+4}}ternery=>{{1>0?\"true\":\"false\"}}func_call=>{{fu(b)}}"
k = /(?<=\{\{)(.*?)(?=\}\})/g
console.log(a.replace(k, (str) => { return pas.parse(str) })
//simple_add=>{{8}}ternery=>{{true}}func_call=>{{4}}
```
### 支持的表达式种类 
1. 数字,字符串字面量
2. 简单的四则运算,判断(+-*/><)
3. 三元表达式,可以使用()进行嵌套
4. 变量名引用
5. 函数调用引用 
