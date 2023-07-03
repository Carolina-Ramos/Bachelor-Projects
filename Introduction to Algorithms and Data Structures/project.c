#include <string.h>
#include <stdio.h>
#include <stdlib.h>
 
#define N 10
#define M 350

typedef struct{

	char descricao[64];
	int dia;
	int inicio;
	int duracao; 
	int sala;
	int fim;
	int dia_total;
	int total_hora;
	int print;
	char responsavel[64];
	char participantes1[64];
	char participantes2[64];
	char participantes3[64];
}Eventos;

Eventos evento;
Eventos matriz[10][100];
Eventos lista[1000];
char caracteristicas[9][64];
char descricao[64];
int posicao, posicao2;

void le_info(char str[M]);
void conversao(int data, int inicio);
void passa_info();
void cria_evento();
void print_participantes(char lista[3][64]);
void tamanho_matriz(int sala);
void tamanho_matriz1(int sala);
void salas_iguais(int sala);
void responsavel_igual(int sala, int t, char *responsavel1, char *responsavel2);
void print_lista();
void muda_inicio(char input[M]);
void imprime(int sala);
void apaga_evento(char descricao[64]);
void ordena_sala(int i);
void ordena_data();

int main(){
	char comando;
	char input[341];
	char *nao = "0";
	int i, j,e ,t, flag = 0, input1;
	int dia_in, hora_in;
 
	strcpy(evento.descricao, nao);
	for(i=0; i<=9; i++){
		for(j=0; j<=99; j++){
			matriz[i][j]= evento;
		}
	}
	for(i=0; i<=999; i++){
			lista[i]= evento;
		}
	
	while(1){
	scanf("%c", &comando);
	getchar();
	
	switch(comando){
		case 'a':
			fgets(input, M, stdin);
			le_info(input);
			dia_in = atoi(caracteristicas[1]);
			hora_in = atoi(caracteristicas[2]);
			conversao(dia_in, hora_in);
			passa_info();
			cria_evento();
			break;
		case 'l':
			ordena_data();
			break;
		case 's':
			fgets(input, M, stdin);
			input1 = atoi(input);
			ordena_sala(input1);
			print_lista(input1);
			break;
		case 'r':
			fgets(input, M, stdin);
			for (t = 0; t<=9; t++){
			tamanho_matriz(t);
				for (e = 0; e < posicao; e++){
					if (strcmp(input, matriz[t][e].descricao) != 0){
						flag = 1;}
					else if (strcmp(input, matriz[t][e].descricao) == 0){
						apaga_evento(input);
			}}}
			if (flag == 1){
				printf("Evento %s inexistente.\n", input);
				flag = 0;
			}
			break;
		case 'i':
			fgets(input, M, stdin);
			muda_inicio(input);
			break;
		case 't':
			fgets(input, M, stdin);
			printf("t");
			break;
		case 'm':
			fgets(input, M, stdin);
			printf("m");
			break;
		case 'A':
			fgets(input, M, stdin);
			printf("A");
			break;
		case 'R':
			fgets(input, M, stdin);
			printf("R");
			break;
		case 'x':
			return 0;
	}
  }
	return 0;
}



void le_info(char str[M]){
	char *linha=str, *nao="0";
	int i=0;
	
	linha = strtok(linha, ":");
	
		while (linha != NULL) {
			strcpy(caracteristicas[i], linha);
			linha = strtok(NULL, ":");
			i++;
		}
		if (linha==NULL){
			strcpy(caracteristicas[i], nao);
		}	
}

void conversao(int data, int inicio){
	int dia, ano, mes, resto, hora, min, total_dia, total_hora;
	ano = (data % 10000) - 2019;
	resto = data / 10000;
	mes = (resto % 100) * 30;
	dia = resto / 100;
	total_dia = ano + mes + dia;
	hora = (inicio / 100) * 60;
	min = inicio % 100;
	total_hora = hora + min;
	evento.total_hora = total_hora;
	evento.dia_total = total_dia;
	evento.fim = total_hora + evento.duracao;
}

void passa_info(){
	strcpy(evento.descricao,caracteristicas[0]);
	evento.dia = atoi(caracteristicas[1]);
	evento.inicio = atoi(caracteristicas[2]);
	evento.duracao = atoi(caracteristicas[3]);
	evento.sala = atoi(caracteristicas[4]);
	strcpy(evento.responsavel, caracteristicas[5]);
	strcpy(evento.participantes1, caracteristicas[6]);
	strcpy(evento.participantes2, caracteristicas[7]);
	strcpy(evento.participantes3, caracteristicas[8]);
}

void cria_evento(){
	int i, j;
	int salas = evento.sala;
	int n = salas - 1; 
	
	tamanho_matriz(n);
		
	if (posicao == 0){
	  matriz[n][0] = evento;
	  for (i=0; i<=9; i++){
		if (i == (n)){}
		else{ 
			tamanho_matriz(i);
			for (j = 0; j <= posicao; j++){
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes3);
				apaga_evento(descricao);	
			}
		}
	  }
	}  
	else{
		salas_iguais(n);
		for (i=0; i<=9; i++){
			tamanho_matriz(i);
			for (j = 0; j <= posicao; j++){
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.responsavel, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes1, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes2, matriz[i][j].participantes3);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].responsavel);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes1);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes2);
				responsavel_igual(i, j, evento.participantes3, matriz[i][j].participantes3);
				apaga_evento(descricao);
			}
		}
	}
} 

void tamanho_matriz(int sala){
	int e = 0, i = 0;
	char *nao="0";
	
	while (e<=99){
		if (strcmp(matriz[sala][e].descricao, nao) == 0){
			i++;
		}
		e++;
	}
	posicao = (99 - i) + 1;
}

void tamanho_matriz1(int sala){
	int e = 0, i = 0;
	char *nao="0";
	
	while (e<=99){
		if (strcmp(matriz[sala][e].descricao, nao) == 0){
			i++;
		}
		e++;
	}
	posicao2 = (99 - i) + 1;
}

void salas_iguais(int sala){
	int t;
	for  (t=0; t <= posicao; t++){
		if (strcmp(matriz[sala][t].descricao, evento.descricao) == 0){
			matriz[sala][posicao] = evento;
		}
		else{
		if (matriz[sala][t].dia_total == evento.dia_total){	
			if (matriz[sala][t].total_hora <= evento.total_hora && 
				matriz[sala][t].fim >= evento.total_hora){
				printf("Impossivel agendar evento %s. Sala%d ocupada.\n", evento.descricao, evento.sala);
				apaga_evento(evento.descricao);
			}
			else if (evento.fim == matriz[sala][t].fim){
				printf("Impossivel agendar evento %s. Sala%d ocupada.\n", evento.descricao, evento.sala);
				apaga_evento(evento.descricao);
			}
		}
		else if (posicao >= 0 && posicao <= 99){
			matriz[sala][posicao] = evento;
		}
	  }
	}
}
	
void responsavel_igual(int sala, int t,char *responsavel1, char *responsavel2){
	
	if (matriz[sala][t].dia_total == evento.dia_total){
		if (strcmp(responsavel1, responsavel2) == 0 && strcmp(matriz[sala][t].descricao, evento.descricao) != 0){
			if (matriz[sala][t].total_hora <= evento.total_hora && matriz[sala][t].fim > evento.total_hora){
				printf("Impossivel agendar evento %s. Participante %s tem um evento sobreposto.\n", evento.descricao, responsavel1);
				strcpy(descricao, evento.descricao);
			}
		}
	}
}

void ordena_sala(int i){
	Eventos evento1;
	int  e, t;
	int n= i-1;
		
		tamanho_matriz(n);
		for (e = 1; e < posicao; e++){
			for (t = 1; t < posicao-1; t++){
				if (matriz[n][t].dia_total > matriz[n][t+1].dia_total){
						evento1 = matriz[n][t];
						matriz[n][t] = matriz[n][t+1];
						matriz[n][t+1] = evento1;
					}
				else if (matriz[n][t].dia_total == matriz[n][t+1].dia_total){
					if (matriz[n][t].total_hora > matriz[n][t+1].total_hora){
						evento1= matriz[n][t];
						matriz[n][t] = matriz[n][t+1];
						matriz[n][t+1] = evento1;					
					}
				}
			}
		}
		}

void ordena_data(){
	Eventos evento1;
	int n, i, e, t, swap=0;
	
	for(i=0; i<=9; i++){
		tamanho_matriz(i);
		for (e=0; e < posicao; e++){
			for (n=0; strcmp(lista[n].descricao, "0"); n++){
				lista[n]= matriz[i][e];
			}
		}}
	while (swap == posicao){
		for (n=0; n<posicao; n++){
			t=n+1;
			if (lista[n].dia_total > lista[t].dia_total){
					if (lista[n].total_hora > lista[t].total_hora){
							swap++;
							evento1 = lista[n];
							lista[n] = lista[t];
							lista[t] = evento1;
					}
				}
				else if (lista[n].dia_total <= lista[t].dia_total){
					if (lista[n].total_hora > lista[t].total_hora){
						swap++;
						evento1= lista[n];
						lista[n] = lista[t];
						lista[t] = evento1;					
					}
				}
			}
			}
	for (n = 0; n < posicao; n++){
		if (strcmp(lista[n].participantes2, "0") == 0){
			printf("%s %08d %04d %d Sala%d %s\n* %s\n", lista[n].descricao, lista[n].dia, lista[n].inicio, lista[n].duracao, lista[n].sala, lista[n].responsavel, lista[n].participantes1);
		}
		else if (strcmp(lista[n].participantes3, "0") == 0){
			printf("%s %08d %04d %d Sala%d %s\n* %s %s\n", lista[n].descricao, lista[n].dia, lista[n].inicio, lista[n].duracao, lista[n].sala, lista[n].responsavel, lista[n].participantes1, lista[n].participantes2);
		}
		else
			printf("%s %08d %04d %d Sala%d %s\n* %s %s %s\n", lista[n].descricao, lista[n].dia, lista[n].inicio, lista[n].duracao, lista[n].sala, lista[n].responsavel, lista[n].participantes1, lista[n].participantes2, lista[n].participantes3);
	}
		}
		
	
		/*for (n = 0; n <= 9; n++){
			tamanho_matriz1(n);
			for (i = 0; i < posicao2; i++){
				if (matriz[n][i].print == 0){
					for (t = 1; t <= 9; t++){
						tamanho_matriz(t);
						for (e= 0; e < posicao; e++){
							if (matriz[n][i].dia_total <= matriz[t][e].dia_total){
								if (matriz[n][i].total_hora < matriz[t][e].total_hora){ }
								else if (matriz[n][i].total_hora < matriz[t][e].total_hora){
									print = 0;
							}
						}
					}
				}
				if (print == 1){
					matriz[n][i].print = 1;	
					if (strcmp(matriz[n][i].participantes2, "0") == 0){
						printf("%s %08d %04d %d Sala%d %s\n* %s\n", matriz[n][i].descricao, matriz[n][i].dia, matriz[n][i].inicio, matriz[n][i].duracao, matriz[n][i].sala, matriz[n][i].responsavel, matriz[n][i].participantes1);
					}
					else if (strcmp(matriz[n][i].participantes3, "0") == 0){
						printf("%s %08d %04d %d Sala%d %s\n* %s %s\n", matriz[n][i].descricao, matriz[n][i].dia, matriz[n][i].inicio, matriz[n][i].duracao, matriz[n][i].sala, matriz[n][i].responsavel, matriz[n][i].participantes1, matriz[n][i].participantes2);
					}
					else
						printf("%s %08d %04d %d Sala%d %s\n* %s %s %s\n", matriz[n][i].descricao, matriz[n][i].dia, matriz[n][i].inicio, matriz[n][i].duracao, matriz[n][i].sala, matriz[n][i].responsavel, matriz[n][i].participantes1, matriz[n][i].participantes2, matriz[n][i].participantes3);
					}
					print = 1;
				}
				else
					break;
			}
}*/

void muda_inicio(char input[M]){
	int t, e, inicio, flag2 = 1, flag1 = 2;
	le_info(input);
	strcpy(descricao, caracteristicas[0]);
	inicio = atoi(caracteristicas[1]);
	for (t = 0; t<=9; t++){
		tamanho_matriz(t);
			for (e = 0; e < posicao; e++){
				if (strcmp(matriz[t][e].descricao, descricao) == 0){
					flag1 = 1;}
				else if (strcmp(descricao, matriz[t][e].descricao) !=0)
					flag2 = 0;
			}}
	if (flag1 == 1){
		evento = matriz[t][e];
		apaga_evento(descricao);
		conversao(evento.dia, inicio);
		passa_info();
		cria_evento();}
	if (flag2 == 0 && flag1 == 2){
		printf("Evento %s inexistente.\n", descricao);
	}
}
				
void print_lista(int sala){
	int e, n = sala - 1;
	tamanho_matriz(n);
	for (e = 0; e < posicao; e++){
		if (strcmp(matriz[n][e].participantes2, "0") == 0){
			printf("%s %08d %04d %d Sala%d %s\n* %s", matriz[n][e].descricao, matriz[n][e].dia, matriz[n][e].inicio, matriz[n][e].duracao, matriz[n][e].sala, matriz[n][e].responsavel, matriz[n][e].participantes1);
		}
		else if (strcmp(matriz[n][e].participantes3, "0") == 0){
			printf("%s %08d %04d %d Sala%d %s\n* %s %s", matriz[n][e].descricao, matriz[n][e].dia, matriz[n][e].inicio, matriz[n][e].duracao, matriz[n][e].sala, matriz[n][e].responsavel, matriz[n][e].participantes1, matriz[n][e].participantes2);
		}
		else
			printf("%s %08d %04d %d Sala%d %s\n* %s %s %s", matriz[n][e].descricao, matriz[n][e].dia, matriz[n][e].inicio, matriz[n][e].duracao, matriz[n][e].sala, matriz[n][e].responsavel, matriz[n][e].participantes1, matriz[n][e].participantes2, matriz[n][e].participantes3);
	}
}


void apaga_evento(char descricao[64]){
	int i, e, t, n=0;
	
	for (i = 0; i<=9; i++){
		tamanho_matriz(i);
		for (e = 0; e <= posicao; e++){
			if (strcmp(descricao, matriz[i][e].descricao) == 0){
				for (t = e; t<= (posicao-1); t++){
					n = t +1;
					matriz[i][e] = matriz[i][n];
				}
			}
		}
	}
}
