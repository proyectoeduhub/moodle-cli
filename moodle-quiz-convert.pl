#!/usr/bin/perl


# Converts questions to GIFT format
# taken from http://cio.umh.es/cursos/moodle/importando_preguntas_de_word/default.htm#script_perl
# as seen on http://www.reflexionesenelearning.es/2007/07/importando-preguntas-test-de-word.html


$i=0;
open (FICHERO,$ARGV[0]);
while (<FICHERO>)
{   if ($_=~/^[1-9]/)
     { chop;
@enunciado=split(/\)/);

print "\n:: pregunta $i ::[html] @enunciado[1]"; 
$i++;
}

if (($_=~/Verdadero/) && ($_=~/(OK)/)) {
print "{Verdadero}\n";
}
   
if (($_=~/Falso/) && ($_=~/(OK)/)) {
print "{Falso}\n";
}

}

close(FICHERO);