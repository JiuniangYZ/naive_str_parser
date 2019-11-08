%lex
%%

\s+         /*skip*/
[A-Za-z][A-Za-z_0-9]*       return 'NAME'
[0-9]+("."[0-9]+)?\b        return 'NUMBER';
\"+[a-zA-Z_]+\"           return 'STRING'
"+"                         return '+'; 
"-"                         return '-'; 
">"                         return '>'; 
"<"                         return '<'; 
"*"                         return '*'; 
"/"                         return '/'; 
"?"                         return '?'; 
":"                         return ':';
"("                         return '(';
")"                         return ')';
"=="                        return 'EQUAL';
<<EOF>>                     return 'EOF';
.                           return 'INVALID';


/lex


%left '+' '-'
%left '*' '/'
%left '>' '<'
%left EQUAL
%start all

%%

all:
  stmt EOF
  %{
      $$ = $1;
      return $1;
  %}
  ;

stmt  
  : bexp
    {$$ = $1;}
  | exp
    {$$ = $1;}
  ;
bexp
  : exp '?' exp ':' exp
    {$$ = $1?$3:$5;}
  ;


exp
  : '(' exp ')'
    {$$ = $2;}
  | '(' bexp ')'
    {$$ = $2;}
  | exp '+' exp
    {$$ = $1+$3;}
  | exp '-' exp
    {$$ = $1-$3;}
  | exp '*' exp
    {$$ = $1*$3;}
  | exp '/' exp
    {$$ = $1/$3;}
  | exp '>' exp
    {$$ = !!($1>$3);}
  | exp '<' exp
    {$$ = !!($1<$3);}
  | exp EQUAL exp
    {$$ = ($1 == $3);}
  | STRING
    { $$ = yytext.slice(1,yytext.length-1);}
  | NAME '(' exp ')'
    { $$ = yy[$1]($3); }
  | NUMBER
    {$$ = Number(yytext);}
  | NAME
    {$$ = yy[yytext] || "null";}
  ;
  
  