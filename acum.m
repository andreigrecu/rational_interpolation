clear all
close all
clc

%Tema numarul 9, Grecu Andrei-Alexandru, 324AB

n = 4;
% se alege un n>=3(ca gradul numaratorului+gradul numitorului sa fie >=6
xa = [2 4 5 11 16 18 21];
ya = [7 9 8 14 12 19 30];
%se aleg coordonatele punctelor
y = 0;
dy = 0;

i = xa(1);
j = 1;
while i <= xa(n)
    xa1(j) = i;
    i = i + 0.2;
    j = j + 1;
end

%am luat o multime de puncte intre primul si ultimul punct
%pe care il cunosc pentru a afla y-ul de multe ori si a crea 
%noul grafic prin interpolare.


%am mers din 0.2 in 0.2, dar se poate modifica aceasta valoare,
%in functie de cate puncte ne dorim pe grafic

ya1 = zeros(1,length(xa1));
dy1 = 0;    
for i = 1:length(xa1)
    [ya1(i), dy1] = inter(xa,ya,n,xa1(i),ya1(i),dy1);
end

%pun in vectorul ya1, de lungime egala cu xa1, valorile scoase de functia
%de interpolare cu functii rationale

figure(1);
plot(xa,ya);
figure(2);
plot(xa1,ya1)

%cele doua grafice, unul al functiei originale in care intre punctele date
%este trasa o dreapta, iar celalalt obtinut prin interpolare.


