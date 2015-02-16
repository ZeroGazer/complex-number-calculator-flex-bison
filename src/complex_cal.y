/* Skeleton for complex_cal.y  */
/* before you have added the   */
/* proper grammar, this code   */
/*can't be compiled correctly! */
%{
#include <stdio.h>
#include <stdlib.h>
#include "complex_cal.h"

/*  prototypes of the provided functions */ 
complex complex_add(complex, complex);
complex complex_sub(complex, complex);
complex complex_mul(complex, complex);
complex complex_div(complex, complex);
/*  prototypes of the provided functions */ 

int yylex(void);
int yyerror(const char*);
%}

/* start: Add your Bison declarations here, one declaration has been provided to you*/
%token CNUMBER
%left '+' '-'
%left '*' '/'
%nonassoc '(' ')'
/* end: Add your Bison declarations here, one declaration has been provided to you*/

%%
/* start:  Add your grammar rules and actions here */
input: /* empty */ 
     | input line
     ;

line: '\n'
    | complexAddSub '\n' {
        if ($1.img != 0)
          printf("%f%+fi\n", $1.real, $1.img);
        else
          printf("%f\n", $1.real);
      }
    ;

complexAddSub: complexAddSub '+' complexMulDiv {$$ = complex_add($1, $3);}
             | complexAddSub '-' complexMulDiv {$$ = complex_sub($1, $3);}
             | complexMulDiv {$$ = $1;}
             ;
             
complexMulDiv: complexMulDiv '*' complexParenthesis {$$ = complex_mul($1, $3);}
             | complexMulDiv '/' complexParenthesis {$$ = complex_div($1, $3);}
             | complexParenthesis {$$ = $1;}
             ;
             
complexParenthesis: '(' complexAddSub ')' {$$ = $2;}
                  | CNUMBER {$$ = $1;}
                  ;
/* end:  Add your grammar rules and actions here */
%%

int main() {
  return yyparse();
}

int yyerror(const char* s) { 
  printf("%s\n", s); 
  return 0; 
}

/* function provided to do complex addition      */
/* input : complex numbers c1, c2                */
/* output: nothing                               */
/* side effect : none                            */
/* return value: result of addition in c3        */ 
complex complex_add (complex c1, complex c2) {
  /* c1 + c2 */
  complex c3;
  c3.real = c1.real + c2.real;
  c3.img = c1.img + c2.img;
  return c3;
}

/* function provided to do complex subtraction   */
/* input : complex numbers c1, c2                */
/* output: nothing                               */
/* side effect : none                            */
/* return value: result of subtraction in c3     */ 
complex complex_sub (complex c1, complex c2) {
  /* c1 - c2 */
  complex c3;
  c3.real = c1.real - c2.real;
  c3.img = c1.img - c2.img;
  return c3;
}

/* function provided to do complex multiplication */
/* input : complex numbers c1, c2                 */
/* output: nothing                                */
/* side effect : none                             */
/* return value: result of multiplication in c3   */ 
complex complex_mul (complex c1, complex c2) {
  /* c1 * c2 */
  complex c3;
  c3.real = c1.real*c2.real - c1.img*c2.img;
  c3.img = c1.img*c2.real + c1.real*c2.img;
  return c3;
}

/* function provided to do complex division       */
/* input : complex numbers c1, c2                 */
/* output: nothing                                */
/* side effect : none                             */
/* return value: result of c1/c2 in c3            */ 
complex complex_div (complex c1, complex c2) { 
  /* c1 / c2 (i.e. c1 divided by c2 ) */
  complex c3;
  double d;

  /* divisor calculation using the conjugate of c2*/
  d = c2.real*c2.real + c2.img*c2.img;

  c3.real = (c1.real*c2.real + c1.img*c2.img) / d;
  c3.img = (c1.img*c2.real - c1.real*c2.img) / d;
  return c3;
}
