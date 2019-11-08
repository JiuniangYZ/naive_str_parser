

%lex
%%

\s+                         /*skip*/
[0-9]+("."[0-9]+)?\b        return 'NUMBER';
"+"                         return '+'; 
<<EOF>>                     return 'EOF';
.                           return 'INVALID';



/lex


%start allll

%%
allll
  : exps EOF
    {return $1;}
  ;

exps 
  : exps '+' exp
    { $$ = $3+$1;}
  | exp
    { $$ = $1;} 
  ;

exp
  : NUMBER 
    { $$ = Number(yytext);}
  ;


