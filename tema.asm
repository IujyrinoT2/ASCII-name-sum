;tema | Afiseaza numele complet al unei persoane plus suma cifrelor din codul ascii al numelui
;----------------------------------------------------------------------------------------------
.model small ;Directiva preprocesor, arata cantitatea de memorie necesara programului programului
.stack 100h ;Directiva preprocesor, arata marimea stivei procesorului necesara programului
.data ;Directiva preprocesor, arata inceputul segmentului de date, unde sunt definite variabilele utilizate de program

	Numetot db 'Victor Chitanu$' ;Variablila de tip data byte(8 biti) unde se afla numele complet
	suma dw ? 					 ;Variablila de tip data word(16 biti) unde este stocata suma ca numar intreg
	afissuma db 10 dup(" ") 	 ;Variabila de tip data byte(8 biti) unde este stocata suma ca sir de caractere pentru afisare 
	idv dw 10 					 ;Variabila de tip data word(16 biti) unde este stocat deimpartitul "10" necesar parcurgerii cifrelor sumei intregi
				
.code 						;Directiva preprocesor, arata ca urmeaza codul sursa propriu zis
.startup 					;Directiva preprocesor, arata inceputul codului sursa
	
	;Initializare segment de date 
	mov ax, @data			; Adresa segmentului de date este bagat in registrul ax 
	mov ds, ax	 			; care apoi este copiata in registrul ds
	
	;Afisare nume complet
	mov ah, 09h 			; in registrul ah in partea high este bagata instructiune 09h (9 in hexa) care este interpretata de dos ca fiind afisare, 
							; aceasta afiseaza valoarea de la adresa stocata in registrul dx 
	mov dx, offset Numetot 	; in registrul dx este bagat adresa de inceput al sirului de caractere "Numetot"
	int 21h 				; intreruperea 21h (21 in hexadecimal) interpreteaza valorarea de la registrul ah partea high  
	
	
	mov si, 0 				; initializare registru si cu 0
	
	;Parcurgem numele pana la numele de familie
loop1:
	inc si 					; incrementare si cu 1
	 
	cmp Numetot[si], ' ' 	; compara elementul din Numetot de pe pozitia Numetot[si] cu caracterul spatiu
	jne loop1 				; daca Numetot[si] este diferit de caracterul spatiu se reiau instructiunile de la loop1:
	
	
	mov suma, 0 			; initializam suma cu 0 
	inc si 					; se incrementeaza si cu 1 ca sa sara peste caracterul spatiu 
	
	;Adunam valorile ascii in suma
loop2:
	mov dl, Numetot[si] 	; se muta in registrul low dl caracterul Numetot[si] 
	add suma, dx 			; implicit dupa instructiunea de mai sus, in dx ramane echivalentul zecimal(ASCII) al lui dl 
	inc si 					; incrementam si cu 1
	
	cmp Numetot[si], '$' 	; compara elementul din Numetot[si] cu terminatorul de string '$'
	jne loop2			 	; instructiunile din loop2 se vor repeta pana se ajunge la finalul sirului

	
	
	;Convertim suma in ascii
	mov ax, suma 			; suma este bagata in registrul ax 
	mov si, 9 ; 			; afissuma poate retine numere de pana la 9 cifre 
	mov afissuma[si], '$'	; iar elementul zece este terminatorul de sir 
	dec si ; si = 8 
	mov dx, 0 				; se initializeaza restul impartirii
	
loop3:	
	div idv 				; ax = ax / 10, cu restul salvat in dx (16 biti = dw) si dl (8 biti = db)
	add dl, '0' 			; se aduna caracterul zero la rest pentru conversie
	mov afissuma[si], dl 	; restul convertit este adaugat la suma afisabila
	dec si 					; decrementeaza si cu 1 
	mov dx, 0 				; reinitialiazarea restului
	
	cmp ax, 0 				; instructiunile din loop 3 se vor executa pana ax va ajunge 0 
	jne loop3 				; in urma impartirilor succesive la 10 
	
	
	
	mov ah, 09h				; in registrul ah in partea high este bagata instructiunea 09h (9 in hexa) care este interpretata de dos ca fiind afisare, 
							; aceasta afiseaza valoarea de la adresa stocata in registrul dx
	mov dx, offset afissuma	; in registrul dx este bagat adresa de inceput al sirului de caractere "afissuma"
	int 21h					; intreruperea 21h (21 in hexadecimal) interpreteaza valorarea de la registrul ah partea high 
	
	mov ah, 4ch				; in registrul ah in partea high este bagata instructiunea 4ch (4c ~= 76 in hexa) care reda controlul sistemului inapoi dos-ului (sfarsit program) 
	int 21h 				; intreruperea 21h (21 in hexadecimal) interpreteaza valorarea de la registrul ah partea high
	
				
end							; sfarsitul codului sursa 