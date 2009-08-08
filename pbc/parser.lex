%{
#include <stdarg.h>
#include <stdio.h>
#include <gmp.h>
#include "pbc_utils.h"
#include "pbc_field.h"

#include "pbc_tree.h"
#define YYSTYPE tree_ptr
#include "parser.tab.h"

extern int option_easy;
%}

%option noyywrap

%%
[0-9]+                  yylval = tree_new_z(yytext);  return NUM;
[a-zA-Z_][a-zA-Z0-9_]*  yylval = tree_new_id(yytext); return ID;
:=                      return ASSIGN;
\+                      return PLUS;
-                       return MINUS;
\/                      return DIVIDE;
\*                      return TIMES;
\^                      return POW;
;                       return TERMINATOR;
,                       return COMMA;
\(                      return LPAR;
\)                      return RPAR;
\[                      return LSQU;
\]                      return RSQU;
#[^\n]*\n   // Comment.
[ \t\r]*    // Whitespace.
\n                      if (option_easy) return TERMINATOR;
.                       return UNKNOWN;
%%
