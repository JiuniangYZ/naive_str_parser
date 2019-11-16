let pas = require("./three.js").parser

pas.yy = {
  a: 1,
  b: 2,
  aasd: "123",
  fu: (aa) => {
    return aa * 2
  }
}

let a = "simple_add=>{{1+3+4}}ternery=>{{1>0?\"true\":\"false\"}}func_call=>{{fu(b)}}"
k = /(?<=\{\{)(.*?)(?=\}\})/g
console.log(a.replace(k, (str) => { return pas.parse(str) }))
