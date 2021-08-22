function[y, dy] = inter(xa, ya, n, x, y, dy) 
   %functia primeste vectorii xa si ya care reprezinta coordonatele punctelor cunoscute
   %de exemplu primul punct este de coordonate xa(1),ya(1)
   %functia primeste si numarul acestor puncte: n
   %x este coordonata pentru care vrem sa scoatem y-ul(y initial 0)
   %dy este eroarea cu care am gasit y
   
    ns = 1;    %ca sa ramana y = ya(1) in cazul in care conditia de la linia 27 nu e indeplinita                         
    TINY = 1e-25; %un numar foarte mic( va evita mai tarziu in program un 0/0)
    c = zeros(1,n);
    d = zeros(1,n);% doi vectori de lungime n
    %se vor memora micile diferente dintre parinti si copii
    %de exemplu daca ne uitam in *tabloul cu stramosi o sa se tina in c(1):
    %P21 - P11, iar in d(1): P21-P22.
    hh = abs(x - xa(1)); 
    %este memorata diferenta dintre abscisa cautata si prima abscisa
    %cunoscuta;
    %este necesara pentru a avea cu cine sa comparam diferentele urmatoare
    
    
    for i = 1:n 
        h = abs(x - xa(i));
        if h == 0.0
            y = ya(i);
            dy = 0.0;
        end
        if h < hh
            ns = i; %se afla ns pentru cel mai apropiat element din tablou.
            hh = h;
        end
        
    c(i) = ya(i);
    d(i) = ya(i) + TINY;%aici este adaugata valoare foarte mica 
    %initializez tablourile
    end
    
    %in bucla sunt calculate celelalte diferente si comparate cu 0.0 sau cu
    %cea initiala;
    
    %daca este gasita o diferenta mai mica i se va retine pozitia si
    %valoarea;
    
    %daca este 0, y-ul pe care avem sa il returnam este ya(i), iar eroarea la
    %este 0;
    
    y = ya(ns);
    ns = ns - 1;
    %aproximarea initiala a lui y
    for m = 1:n-1 %e parcursa matricea de stramosi
        for i = 1:n-m
            w = c(i+1) - d(i);
            h = xa(i+m) - x; %h nu va fi niciodata 0 pentru ca a fost testat in 
            %bucla de initializare
            t = (xa(i)-x)*d(i)/h;%aici ajuta ca h nu e 0
            dd = t - c(i+1);
            
            if(dd == 0.0)
                display('ERROR in routine ratint');%eroarea spune ca functia de interpolare are un pol
                %exact in abscisa x pentru care cautam y-ul.
            end
            
            dd = w/dd;
            d(i) = c(i+1)*dd;
            c(i) = t*dd;
            
        end
        
        %pentru fiecare coloana a tabloului de stramosi sunt updatate c si
        %d, trecand in bucla creata pe la fiecare dintre acestia. 
        
        if 2*ns < n-m
            dy = c(ns+1);
        end
        
        if 2*ns >= n-m
            dy = d(ns);
            ns = ns - 1;
        end
        
        y = y + dy;
        
        %Dupa ce fiecare coloana a tabloului de stramosi e completata,
        %trebuie decis care corectie, c sau d este adaugata la y-ul pe care
        %il cautam; 
        %Se alege cea mai rapida ruta prin tablou, updatand ns in
        %consecinta, pentru a nu pierde locul curent.
        %dy de la final este eroarea, care trebuie si ea adaugata.
    end
            
end
