{ open Parser }


rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"		{ comment lexbuf }           (* Comments *)
| "//"		{ comment2 lexbuf }
| '('		{ LPAREN }
| ')'      	{ RPAREN }
| ';'      	{ SEMI }
| ','      	{ COMMA }
| '+'      	{ PLUS }
| '-'      	{ MINUS }
| '*'      	{ TIMES }
| '/'      	{ DIVIDE }
| '^'      	{ EXPONENT }
| "MC"     	{ MC }
| "eval"   	{ EVAL }
| "fill_in" { FILL_IN }
| "TF"		{ TF }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/"  { token lexbuf }
| _     { comment lexbuf }

and comment2 = parse
  '\n'	{ token lexbuf }
| _		{ comment lexbuf }