/* Vouklis Marios 2115021
Katounis Emmanouil Ioannis 2115067
Kozanis Konstantinos 2115075


/* Lexical Analysis of PASC500 */

%{	
#include "compiler.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <string.h>
#include <sys/types.h>


/* To strbuf to xrisimopoioume gia ola ta str tou programmatos*/									
char strbuf[MAX_STR_CONST];					
char *strbufptr;

/* To yyin1 einai enas pointer gia ta errors. Apoktoume diladi prosvasi
sto arxeio kai apothikeuoume thn seira pou exei to error*/
FILE *yyin1;
/* Ena flag gia to EOF*/		
int flag = 1;
int errors=0;
/* Synarthsh gia error printing */
void yyerror(char *str);
/* */
int linenum = 1; /* Synolikes seires sto programma */
char line [MAX_LINE];

/* Synarthseis metatropwn */
int decimalIntegerFunc(char *str); // string se integer me atoi
int HexadecimalIntFunc(char *str); // string se hex me strtol
int BinaryIntegerFunc (char *str); //  string to binary me atoi. 										


double RealDecimalFunc (char *str); // string se real me atof
double RealHexFunc (char *str); 
double RealBinFunc (char *str);
/* Synarhthsh apothikeushs grammis tou error */
void errorstr(void);
void yyerror(char *msg); // Synarthsh pou kanei print osa error vrethikan ston kwdika
%}

/*  OPTIONS  */

/* Peza kefalaia option */
%option case-insensitive
/* Anagnwsh enos kai mono arxeiou */
%option noyywrap

/* STATES */

/* Comments */
%x COMMENT
/* Comment String */
%x STRING
/* BLOCK STATEMENTS */

WHITESPACE					[ \t]*
NEWLINE					[\n]
LETTER						[A-Za-z]
DIGIT						[0-9]
LETTERDIGIT					({LETTER}|{DIGIT})
HEXDIGIT 					[0-9A-F]
EXPONENT            				E[+-]?(0|[1-9]{DIGIT}*)
ASCII						[ !"#$%&')(*,-./:;<=>}{?@\^_`|~\[\]] 
UNSINT						{DIGIT}+
ID 						(\_)?[a-zA-Z]({LETTERDIGIT}*[a-zA-Z0-9])*


%%


"PROGRAM"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_PROGRAM,linenum);
												return T_PROGRAM;}
												
"CONST"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CONST,linenum);
												return T_CONST;}
												
"TYPE"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_TYPE,linenum);
												return T_TYPE;}

"ARRAY"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_ARRAY,linenum);
												return T_ARRAY;}

"SET"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_SET,linenum);
												return T_SET;}
												
"OF"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_OF,linenum);
												return T_OF;}

"RECORD"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_RECORD,linenum);
												return T_RECORD;}

"VAR"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_VAR,linenum);
												return T_VAR;}
												
"FORWARD"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_FORWARD,linenum);
												return T_FORWARD;}	
												
"FUNCTION"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_FUNCTION,linenum);
												return T_FUNCTION;}
												
"PROCECURE"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_PROCEDURE,linenum);
												return T_PROCEDURE;}
												
"INTEGER"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_INTEGER,linenum);
												return T_INTEGER;}

"REAL"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_REAL,linenum);
												return T_REAL;}

"BOOLEAN"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_BOOLEAN,linenum);
												return T_BOOLEAN;}

"CHAR"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CHAR,linenum);
												return T_CHAR;}

"BEGIN"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_BEGIN,linenum);
												return T_BEGIN;}

"END"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_END,linenum);
												return T_END;}

"IF"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_IF,linenum);
												return T_IF;}

"THEN"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_THEN,linenum);
												return T_THEN;}

"ELSE"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_ELSE,linenum);
												return T_ELSE;}

"WHILE"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_WHILE,linenum);
												return T_WHILE;}

"DO"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_DO,linenum);
												return T_DO;}

"FOR"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_FOR,linenum);
												return T_FOR;}

"DOWNTO"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_DOWNTO,linenum);
												return T_DOWNTO;}

"TO"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_TO,linenum);
												return T_TO;}

"WITH"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_WITH,linenum);
												return T_WITH;}

"READ"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_PROGRAM,linenum);
												return T_READ;}

"WRITE"								{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_PROGRAM,linenum);
												return T_WRITE;}

"TRUE"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_BCONST,linenum);
												return T_BCONST;}

"FALSE"							        {printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_BCONST,linenum);
												return T_BCONST;}
					
"OR"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_OROP,linenum);
												return T_OROP;}	
												
"*"|"/"|"DIV"|"MOD"|"AND"						{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_MULDIVANDOP,linenum);
												return T_MULDIVANDOP;}

"IN"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_INOP,linenum);
												return T_INOP;}
											
"NOT"									{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_NOTOP,linenum);
												return T_NOTOP;}

(\_)?[a-zA-Z]({LETTERDIGIT}*[a-zA-Z0-9])*				{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext, T_ID, linenum); 
												return T_ID;}
																			

(0H)([1-9A-F]{HEXDIGIT}*)?(\.)(0|0*[1-9A-F]{HEXDIGIT}*) 	{printf("[TOKEN FOUND: %s = %lf | TOKEN NUMBER: %d | LINE: %d]\n",yytext, RealHexFunc(yytext), T_RHEXCONST, linenum); 
												return T_RHEXCONST;}
												

(0B)(0|1[01]*)?(\.)(0|0*1[01]*)				{printf("[TOKEN FOUND: %s = %lf | TOKEN NUMBER: %d | LINE: %d]\n", yytext,RealBinFunc(yytext), T_RBINCONST, linenum); 
												return T_RBINCONST;}
																	

(0|[1-9]{DIGIT}*)?(\.)(0|0*[1-9]{DIGIT}*)	    		{printf("[TOKEN FOUND: %s = %lf | TOKEN NUMBER: %d | LINE%d]\n",yytext, RealDecimalFunc(yytext), T_RDECCONST, linenum);
 												return T_RDECCONST;}
																	
													
(0|[1-9]{DIGIT}*)?((\.)(0|0*[1-9]{DIGIT}*)EXPONENT)	{printf("[TOKEN FOUND: %s = %lf | TOKEN NUMBER: %d | LINE: %d]\n", yytext,RealDecimalFunc(yytext), T_RDECCONST, linenum); 
												return T_RDECCONST;}


(0|[1-9]{DIGIT}*)EXPONENT				{printf("[TOKEN FOUND: %s = %lf | TOKEN NUMBER: %d | LINE: %d]\n", yytext,RealDecimalFunc(yytext), T_RDECCONST, linenum); 
												return T_RDECCONST;}

																																																
 /* HEXADEMICAL CONSTANT */
(0H)([1-9A-F])({HEXDIGIT}*)											{printf("[TOKEN FOUND: %s = %d | TOKEN NUMBER: %d | LINE: %d]\n", 
																	yytext, HexadecimalIntFunc(yytext), T_ICONST, linenum); return T_ICONST;}
 /* BINARY CONSTANT */
(0B)1[01]*														{printf("[TOKEN FOUND: %s = %d | TOKEN NUMBER: %d | LINE: %d]\n", 
																	yytext, BinaryIntegerFunc(yytext), T_ICONST, linenum); return T_ICONST;}																	
 /* INTEGER CONSTANT */
0|[1-9]{DIGIT}*													{printf("[TOKEN FOUND: %s = %d | TOKEN NUMBER: %d | LINE: %d]\n", 
																	yytext, decimalIntegerFunc(yytext), T_ICONST, linenum); return T_ICONST;}

												
\'\\n\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
												
\'\\t\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'\\r\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'\\f\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'\\b\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'\\v\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'{ASCII}\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'{DIGIT}\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
																	
\'{LETTER}\'			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_CCONST,linenum);return T_CCONST;}
															 														
											


">"|">="|"<"|"<="		{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_RELOP,linenum);return T_RELOP;}
                                                
																	
[+-]				{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_ADDOP,linenum);return T_ADDOP;}
                                                
                                                
"("     			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_LPAREN,linenum);return T_LPAREN;}
                                                
                                                
")"     			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_RPAREN,linenum);return T_RPAREN;}
                                              
                                               
";"      			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_SEMI,linenum);return T_SEMI;}
                                               
                	                                
"."         			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_DOT,linenum);return T_DOT;}
                                               
                                                
","         			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_COMMA,linenum);return T_COMMA;}
                                               
                                                
"="           			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_EQU,linenum);return T_EQU;}
                                                
                                                
":"        			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_COLON,linenum);return T_COLON;}
                                                

"["       			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_LBRACK,linenum); return T_LBRACK;}
                                              
                                                
"]"        			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_RBRACK,linenum);return T_RBRACK;}
                                                
                                                
":="        			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_ASSIGN,linenum);return T_ASSIGN;}
                                                
                                    	            
".."        			{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_DOTDOT,linenum);return T_DOTDOT;}
                                                
												
<INITIAL><<EOF>>		{printf("[TOKEN FOUND: %s | TOKEN NUMBER: %d | LINE: %d]\n", yytext,T_EOF,linenum);return T_EOF;}
                                               	
                     
					 
					 
					                            


"{"														BEGIN(COMMENT);
<COMMENT>[^}\n]+												;
<COMMENT>\n													{if(flag) errorstr(); linenum++;}
<COMMENT><<EOF>>												{yyerror("Comment not finished"); yyterminate();}
<COMMENT>"}"													BEGIN(INITIAL);

																
 /* Strings */ 
\"														{strbufptr = strbuf; BEGIN(STRING);}
<STRING>\"													{BEGIN(INITIAL); *strbufptr = '\0';
														printf("[String Found: \"%s\" | TOKEN: %d | LINE: %d]\n" ,strbuf, T_STRING, linenum);}
																
<STRING>\n													yyerror("Non-acceptable input in string!");
<STRING>\\n													*strbufptr++ ='\n';
<STRING>\\t													*strbufptr++ ='\t';
<STRING>\\r													*strbufptr++ ='\r';
<STRING>\\b													*strbufptr++ ='\b';
<STRING>\\v													*strbufptr++ ='\v';
<STRING>\\f													*strbufptr++ ='\f';
<STRING>\\\n													{if(flag) errorstr(); linenum++;}
<STRING>\\(.)													*strbufptr++ = yytext[1];
<STRING>[^\\\n\"]+												{char *ptr = yytext; 
														while ( *ptr ){ *strbufptr++ = *ptr++;}}
<STRING><<EOF>>												{yyerror("String is missing or not terminated"); yyterminate();}
																
																
{WHITESPACE}													;
{NEWLINE}													{if(flag) errorstr(); linenum++;} 
															
															
.														yyerror("Wrong input!");
 /* ====[END RULES BLOCK]==== */ 
%%



int decimalIntegerFunc(char *str){
    return atoi(str); 
}       

int HexadecimalIntFunc(char *str){
    int x;
    x= (int)strtol(&str[2], NULL, 16);
    return x;
}

int BinaryIntegerFunc ( char *str){
   int x;
   x=(int)strtol(&str[2], NULL, 2);  
}



double RealDecimalFunc ( char *str){
	return atof(str);  
}



double RealHexFunc (char *str){
	double x;
	int i;
	int declength, strlength, realength;
	char *character;
	
	strlength = strlen(str);
	character = strchr(str, '.');
	realength = strlen(character) - 1;
	declength = strlength - realength + 1;
	x=(int)strtol(&str[2],&character, 16);
	
	for (i = 1; i <= realength; i++){
		if ((character[i] == 'A') || (character[i] == 'B') || (character[i] == 'C') || (character[i] == 'D') || (character[i] == 'E') || (character[i] == 'F')){
			x = (character[i] - '7') * (1 / pow(16,i)) + x;
		}else{
			if ((character[i] == 'a') || (character[i] == 'b') || (character[i] == 'c') || (character[i] == 'd') || (character[i] == 'e') || (character[i] == 'f')){
				x = (character[i] - 'W') * (1 / pow(16,i)) + x;
			}else{
				x = (character[i] - '0') * (1 / pow(16,i)) + x;
			}
		}
	}
    return x;
}




double RealBinFunc ( char *str){
		double x;
		int i;
		int declength, strlength, realength;
		char *character;
		character = strchr(str,',');
		realength = strlen(character) - 1;
		declength = strlength - realength + 1;
		x=(int)strtol(&str[2], &character,2);
		for(i=1; i<=realength;i++){
			x=(character[i] - '0') * (1/ pow(2,i)) + x;
		}
		return x;
		
		
}


void yyerror (char *msg){
	errors++;
	printf("(%d) Error %s found, token %s in line %d -->%s<--\n",errors, msg, yytext, linenum, line );
	if(MAX_ERRORS == errors){
		printf("ERRORS DETECTED IN PROGRAM %d\n ERRORS DETECTED: %d\n TERMINATING....\n",errors,MAX_ERRORS);
		exit(-1);
}
}


/* MAIN */

int main(int argc, char *argv[]){
	int token;
	
	++argv; --argc;
	if( argc > 0){
		yyin = fopen(argv[0], "r");
		if (yyin == NULL){
			perror ("Error opening the file"); return -1;
		}
		yyin1 = fopen(argv[0], "r");
		if (yyin1 == NULL){
			perror ("Error opening the file"); return -1;
		}
	}
	errorstr();
	token = yylex(); 
	while(token != T_EOF){
		token = yylex();
	}
	fclose(yyin); 
	yyterminate();
}



void errorstr(void){
	off_t pos;
	int k;
	char c;
	
	for(k = 0; k < MAX_LINE; k++){
		line[k] = '\0';
	}
	
	k = 0;
	
	while(1){
		c = fgetc(yyin1);
		if( feof(yyin1) || c == '\n' ){ 
			break;
		}
		line[k] = c;
		k++;
	}
	if (feof(yyin1)){
		flag = 0;
	}
}
