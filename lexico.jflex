package logica;

// importaciones
import java_cup.runtime.Symbol;
import java.util.LinkedList;
%%

// código de usuario
%{
    public LinkedList<Errores> listaErrores = new LinkedList<Errores>();
    String lexema;
%}

%init{
    yyline = 0;
    yycolumn = 0; // Cambiado a 0
    listaErrores = new LinkedList<>();
%init}

// características de JFlex
%cup
%class scanner
%public
%line
%column
%buffer 1024
%char
%full
%debug

// Definición de patrones
espacio = [\ \r\t\f\n]+
comentario_linea = #[^\r\n]*[\r\n]?
comentario_multilinea = "<!"[^!]*"!>"

// Identificadores y números
IDENTIFICADOR = [a-zA-Z_][a-zA-Z_0-9]*
NUMERO = [0-9]+
LETRAS = [a-zA-Z]

// Símbolos
FLECHA = "->"
COMA = ","
LLAVE_IZQ = "{"
LLAVE_DER = "}"
TILDE_INVERTIDA = "~"
FIN_CADENA = ";"
DOS_PUNTOS = ":"
PAREN_IZQ = "("
PAREN_DER = ")"

// Operaciones
UNION = "U"
INTERSECCION = "&"
COMPLEMENTO = "^"
DIFERENCIA = "-"

// Palabras reservadas
CONJ = "CONJ"
OPERA = "OPERA"
EVALUAR = "EVALUAR"

%%

// Reglas de JFlex
<YYINITIAL> {espacio} { /* Ignorar espacios */ }
<YYINITIAL> {comentario_linea} { /* Ignorar comentarios de linea */ }
<YYINITIAL> {comentario_multilinea} { /* Ignorar comentarios multilínea */ }


// Palabras reservadas
<YYINITIAL> {CONJ} {return new Symbol(sym.CONJ, yyline, yycolumn, yytext());}
<YYINITIAL> {OPERA} {return new Symbol(sym.OPERA, yyline, yycolumn, yytext());}
<YYINITIAL> {EVALUAR} {return new Symbol(sym.EVALUAR, yyline, yycolumn, yytext());}

// Símbolos
<YYINITIAL> {FLECHA} {return new Symbol(sym.FLECHA, yyline, yycolumn, yytext());}
<YYINITIAL> {COMA} {return new Symbol(sym.COMA, yyline, yycolumn, yytext());}
<YYINITIAL> {LLAVE_IZQ} {return new Symbol(sym.LLAVE_IZQ, yyline, yycolumn, yytext());}
<YYINITIAL> {LLAVE_DER} {return new Symbol(sym.LLAVE_DER, yyline, yycolumn, yytext());}
<YYINITIAL> {TILDE_INVERTIDA} {return new Symbol(sym.TILDE_INVERTIDA, yyline, yycolumn, yytext());}
<YYINITIAL> {FIN_CADENA} {return new Symbol(sym.FIN_CADENA, yyline, yycolumn, yytext());}
<YYINITIAL> {DOS_PUNTOS} {return new Symbol(sym.DOS_PUNTOS, yyline, yycolumn, yytext());}
<YYINITIAL> {PAREN_IZQ} {return new Symbol(sym.PAREN_IZQ, yyline, yycolumn, yytext());}
<YYINITIAL> {PAREN_DER} {return new Symbol(sym.PAREN_DER, yyline, yycolumn, yytext());}

// Operaciones
<YYINITIAL> {UNION} {return new Symbol(sym.UNION, yyline, yycolumn, yytext());}
<YYINITIAL> {INTERSECCION} {return new Symbol(sym.INTERSECCION, yyline, yycolumn, yytext());}
<YYINITIAL> {COMPLEMENTO} {return new Symbol(sym.COMPLEMENTO, yyline, yycolumn, yytext());}
<YYINITIAL> {DIFERENCIA} {return new Symbol(sym.DIFERENCIA, yyline, yycolumn, yytext());}

// Identificadores y números y letras
<YYINITIAL> {LETRAS} {return new Symbol(sym.LETRAS, yyline, yycolumn, yytext());}
<YYINITIAL> {IDENTIFICADOR} {return new Symbol(sym.IDENTIFICADOR, yyline, yycolumn, yytext());}
<YYINITIAL> {NUMERO} {return new Symbol(sym.NUMERO, yyline, yycolumn, yytext());}


// Manejo de caracteres no reconocidos
<YYINITIAL> . {listaErrores.add(new Errores("Lexico","El lexema: "+yytext()+" no esta definido",yyline+1, yycolumn+1));}
