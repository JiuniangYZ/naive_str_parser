//require("jison")
let pas = require("./three.js").parser
args_slicer = function (_args){
  let out = []  
  let go = function(tree){
    if(tree.left) go(tree.left);
    out.push(tree.right)
  }
  go(_args)
  return out
}
pas.yy = {
  a: 1,
  b: 2,
  c:3,
  f:4,
  aasd: "123",
  slicer: args_slicer,
  fu: (aa) => {
    return aa * 2
  },
  fu2 :(a,b)=>{
    return a+b
  }
}

let sc = `fu2(a,b,c,f)`;
console.log(pas.parse(sc));
let sc1 = `fu(12345)`;
console.log(pas.parse(sc1));
