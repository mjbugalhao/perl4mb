#!/usr/bin/perl
use warnings;
use strict;

my @tab_pds = (
	[0,0,0],
	[0,0,0],
	[0,0,0]
);

my $acabou = 0;
#enquanto não for dada indicação para parar a execução 
while ($acabou != 1) {
	my $coordenadas_ok = 0;

	#enquanto não for introduzida uma coordenada correcta 
	while ($coordenadas_ok != 1) {
		print "\nIntroduza as coordenadas no formato x,y - ";
		my $coordenadas = <STDIN>;

		#chama função que valida se resposta está ok
		$coordenadas_ok = val_coordenadas($coordenadas);}

		#verifica se há condições para terminar
		$acabou = verifica_fim();
	
		if ($acabou != 1) {
			#cria resposta independente
			prep_resposta();
			#verifica se há condições para terminar
			$acabou = verifica_fim();}
	
		#chama função que imprime toda a tabela
		imp_tab();
}

#função que valida se resposta está ok
sub val_coordenadas {	
	my $validado = 1;
	
	chomp $_[0];
	my $txt = $_[0];
	
	#verifica se o comprimento está certo
	if (length($txt) != 3) {
		$validado = 0;
		return $validado;}
	
	#verifica se está no formato a,b
	my $virgula = index($txt, ",");
	if ($virgula == -1) {
		$validado = 0;
		return $validado;}
	
	my ($linha, $coluna) = split /,/, $txt;
	
	if ( $linha =~ /[0-2]/ and $coluna =~ /[0-2]/) {
		#linha e coluna estão OK
	} else {
		$validado = 0;
		return $validado;}

	if ($tab_pds[$linha][$coluna] == 2) {
		$validado = 0;
		return $validado;}
		
	if ($validado == 1) {
		$tab_pds[$linha][$coluna] = 1;}
		
	return $validado;
}

#prepara a resposta automática
sub prep_resposta {
	my $responder = 0;
	
	#verifica linhas (procura d.e.l.)- ciclo interior em $q
	my $p = 0;	
	my $q = 0;
	my $r = 0;
	my $s = 0;
	my $del = 0;

	while ($p < 3) {
		while ($q < 3) {
			if ($tab_pds[$p][$q] == 1) {$del++;}
			if ($tab_pds[$p][$q] == 0 or $tab_pds[$p][$q] == 2) {
				$r=$p;
				$s=$q;}
			$q++;}
			
		if ($del == 2 and $tab_pds[$r][$s] == 0) {
			$tab_pds[$r][$s] = 2;
			return;}
		
		$p++;
		$q = 0;
		$del = 0;
	}

	#verifica colunas (procura d.e.c.) - ciclo interior em $p
	$p = 0; #linhas	
	$q = 0; #colunas
	$del = 0;

	while ($q < 3) {
		while ($p < 3) {
			if ($tab_pds[$p][$q] == 1) {$del++;}
			if ($tab_pds[$p][$q] == 0 or $tab_pds[$p][$q] == 2) {
				$r=$p;
				$s=$q;} 
			$p++;}
			
		if ($del == 2 and $tab_pds[$r][$s] == 0) {
			$tab_pds[$r][$s] = 2;
			return;}
		
		$q++;
		$p = 0;
		$del = 0;
	}
	
	#verifica diagonal 1
	$p = 0;	
	$q = 0;
	$r = 0;
	$s = 0;
	$del = 0;

	while ($p < 3) {
		while ($q < 3) {
			if ($tab_pds[$p][$q] == 1) {$del++;}
			if ($tab_pds[$p][$q] == 0 or $tab_pds[$p][$q] == 2) {
				$r=$p;
				$s=$q;}
			$q++;
			$p++;
		}
	}
	if ($del == 2 and $tab_pds[$r][$s] == 0) {
		$tab_pds[$r][$s] = 2;
		return;}

	#verifica diagonal 2
	$p = 0;	
	$q = 2;
	$r = 0;
	$s = 0;
	$del = 0;

	while ($p < 3) {
		while ($q >= 0) {
			if ($tab_pds[$p][$q] == 1) {$del++;}
			if ($tab_pds[$p][$q] == 0 or $tab_pds[$p][$q] == 2) {
				$r=$p;
				$s=$q;}
			$p++;
			$q--;
		}
	}
	if ($del == 2 and $tab_pds[$r][$s] == 0) {
		$tab_pds[$r][$s] = 2;
		return;}
	
	#se não existe risco, responde aleatoriamente
	while ($responder != 1) {
		my $linha_resp = int(rand(3));
		my $coluna_resp = int(rand(3));
		
		if ($tab_pds[$linha_resp][$coluna_resp] == 0) {
			$tab_pds[$linha_resp][$coluna_resp] = 2;
			$responder = 1;}
		}
}

#verificar se existem condições para acabar 
sub verifica_fim {
	my $j = 0;	
	my $k = 0;
	my $tudo = 0;

	#verifica completo
	while ($j < 3) {
		while ($k < 3) {
			if ($tab_pds[$j][$k] == 1 or $tab_pds[$j][$k] == 2) {
				$tudo++;}
			$k++;}
		$j++;
		$k = 0;

	}
	if ($tudo == 9) {
		print "TERMINADO\n";
		return 1;}
	
	$j = 0;	
	$k = 0;
	my $tel_1 = 0;
	my $tel_2 = 0;

	#verifica linhas 
	while ($j < 3) {
		while ($k < 3) {
			if ($tab_pds[$j][$k] == 1) {$tel_1++;}
			if ($tab_pds[$j][$k] == 2) {$tel_2++;}
			$k++;}
			
			if ($tel_1 == 3) {
				print "V1\n";
				return 1;}
			if ($tel_2 == 3) {
				print "V2\n";
				return 1;}
		$j++;
		$k = 0;
		$tel_1 = 0;
		$tel_2 = 0;
	}
	
	$j = 0;	
	$k = 0;
	$tel_1 = 0;
	$tel_2 = 0;

	#verifica colunas
	while ($k < 3) {
		while ($j < 3) {
			if ($tab_pds[$j][$k] == 1) {$tel_1++;}
			if ($tab_pds[$j][$k] == 2) {$tel_2++;}
			$j++;}
			
			if ($tel_1 == 3) {
				print "\nAcabou - V1\n";
				return 1;}
			if ($tel_2 == 3) {
				print "\nAcabou - V2\n";
				return 1;}
		$k++;
		$j = 0;
		$tel_1 = 0;
		$tel_2 = 0;
	}
	
	#verifica diagonais (1)
	if (($tab_pds[0][0] == 1 and $tab_pds[1][1] == 1 and $tab_pds[2][2] == 1) or ($tab_pds[0][2] == 1 and $tab_pds[1][1] == 1 and $tab_pds[2][0] == 1)) {
		print "\nAcabou - V1\n";
		return 1;}
	
	#verifica diagonais (2)
	if (($tab_pds[0][0] == 2 and $tab_pds[1][1] == 2 and $tab_pds[2][2] == 2) or ($tab_pds[0][2] == 2 and $tab_pds[1][1] == 2 and $tab_pds[2][0] == 2)) {
		print "\nAcabou - V2\n";
		return 1;}
}

#função que imprime toda a tabela
sub imp_tab {

print "\n", "PDS:", "\n","\n";

my $l = 0;	
my $c = 0;

while ($l < 3) {
	while ($c < 3) {
		print $tab_pds[$l][$c], " ";
		$c++;
		}
	print "\n";
	$l++;
	$c = 0;
	}
}