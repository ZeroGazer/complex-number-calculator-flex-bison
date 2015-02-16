bison -d -v complex_cal.y 
flex -ocomplex_cal.lex.yy.c complex_cal.lex 
gcc -o complex_cal complex_cal.lex.yy.c complex_cal.tab.c 
./complex_cal

