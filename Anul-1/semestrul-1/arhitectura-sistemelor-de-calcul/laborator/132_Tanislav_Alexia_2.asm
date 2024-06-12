.data
	lines: .space 4
	columns: .space 4
	lineIndex: .space 4
	columnIndex: .space 4
	matrix: .space 2000
	nrCeluleVii: .space 4
	index: .space 4
	dr: .space 4
	stg: .space 4
	k: .space 4
	sum: .long 0
	veciniTrei: .long 3
	veciniDoi: .long 2
	liniiModif: .space 4
	colModif: .space 4
	newMatrix: .space 2000
	indexK: .long 0
	
	read: .asciz "r"
	write: .asciz "w"
	fileIn: .asciz "in.txt"
	fileOut: .asciz "out.txt"
	in: .space 4
	out: .space 4
	
	formatScan: .asciz "%d"
	formatPrint: .asciz "%d "
	formatNewLine: .asciz "%s"
	newLine: .asciz "\n"

.text

.global main

main:
	pushl $write
	pushl $fileOut
	call fopen
	popl %ebx
	popl %ebx
	movl %eax, out
	
	pushl $read
	pushl $fileIn
	call fopen
	popl %ebx
	popl %ebx
	movl %eax, in
	
	pushl $lines
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	pushl $columns
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	pushl $nrCeluleVii
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	addl $2, lines                       # bordam matricea pe linii
	addl $2, columns                     # bordam matricea pe col
	
	movl $0, index
	
forCitireCeluleViiPoz:
	movl index, %ecx
	cmp %ecx, nrCeluleVii                 # comparam nr de celule vii cu indexul
	je citireK
	
	pushl $stg                            # citim linia poz celulei vii
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	pushl $dr                             # citim coloana poz celulei vii
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	
	addl $1, stg                          # mut poz i in matricea bordata
	addl $1, dr                           # mut poz j in matricea bordata
	
	movl stg, %eax                        # stg*columns+dr
	movl $0, %edx
	mull columns
	addl dr, %eax                         # eax=poz celulei vii
	
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)
	
	incl index
	jmp forCitireCeluleViiPoz
	
citireK:
	pushl $k                             # nr evolutii/iteratii/generatii
	pushl $formatScan
	pushl in
	call fscanf
	popl %ebx
	popl %ebx
	popl %ebx
	jmp forK
	
forK:
	movl indexK, %edx
	cmp %edx, k
	je afMatrice
	jmp MatriceNoua
	
forKcont:
	addl $1, indexK
	jmp forK
	
MatriceNoua:
	movl lines, %ebx
	sub $1, %ebx
	movl %ebx, liniiModif
	movl columns, %ebx
	sub $1, %ebx
	movl %ebx, colModif
	movl $0, %ebx
	
	movl $1, lineIndex
	forLinesNou:                                  # primul for pt linii
		movl lineIndex, %ecx
		cmp %ecx, liniiModif
		je interschimbareMatriceNoua
		
		movl $1, columnIndex                  # al doilea for pt coloane
		forColumnNou:
			movl columnIndex, %ecx
			cmp %ecx, colModif
			je contForLinesNou               # continui for linii
			
			# prelucrarea datelor
			# elementul curent este la lineIndex*columns+columnIndex
			movl lineIndex, %eax          # eax=lineIndex
			movl $0, %edx
			mull columns                 # eax=eax*columns
			addl columnIndex, %eax        # eax=eax+columnIndex
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx    # ebx=matrix[lineIndex][columnIndex]
			
			# adunam celule vii
			addl $1, %eax                 # elem est
			addl (%edi, %eax, 4), %edx    
			addl columns, %eax            # elem sud-est
			addl (%edi, %eax, 4), %edx    
			subl $1, %eax                 # elem sud
			addl (%edi, %eax, 4), %edx
			subl $1, %eax                 # elem sud-vest
			addl (%edi, %eax, 4), %edx
			subl columns, %eax            # elem vest
			addl (%edi, %eax, 4), %edx    
			subl columns, %eax            # elem nord-vest
			addl (%edi, %eax, 4), %edx
			addl $1, %eax                 # elem nord
			addl (%edi, %eax, 4), %edx
			addl $1, %eax                 # elem nord-est
			addl (%edi, %eax, 4), %edx
			
			# revenim la adresa elem curent
			subl $1, %eax
			addl columns, %eax
			
			mov %edx, sum                 # avem suma cel vii
			movl $0, %edx
			cmp %ebx, %edx                # edx<=ebx
			je elemZero                   # du-te ca ebx=0
			
			# elem curent = 1
			mov sum, %edx
			cmp %edx, veciniTrei
			je totCelulaVie
			
			cmp %edx, veciniDoi
			je totCelulaVie
			
			# daca se ajunge aici inseamna ca moare, 1 devine 0
			lea newMatrix, %esi
			movl $0, (%esi, %eax, 4)
			addl $1, columnIndex          # incrementam index coloana
			jmp forColumnNou
			
			totCelulaVie:
				lea newMatrix, %esi
				movl $1, (%esi, %eax, 4)      # din 0 se face 1
				addl $1, columnIndex          # incrementam index coloana
				jmp forColumnNou
			
			elemZero:                             # compari suma pt elem 0
				mov sum, %edx
				cmp %edx, veciniTrei          # sum=3?
				je creare
				lea newMatrix, %esi           # sum=3  celula moarta in cont
				movl $0, (%esi, %eax, 4)
				
				addl $1, columnIndex          # incrementam index coloana
				jmp forColumnNou
			
				creare: 
					lea newMatrix, %esi
					movl $1, (%esi, %eax, 4)      # din 0 se face 1
					addl $1, columnIndex          # incrementam index coloana
					jmp forColumnNou

	contForLinesNou:                              # restul de for linii
		addl $1, lineIndex
		jmp forLinesNou
		
interschimbareMatriceNoua:
	movl $0, lineIndex
	forLinesAf:                                     # primul for pt linii
		movl lineIndex, %ecx
		cmp %ecx, lines
		je forKcont
		
		movl $0, columnIndex                  # al doilea for pt coloane
		forColumnAf:
			movl columnIndex, %ecx
			cmp %ecx, columns
			je contForLinesAf               # continui for linii
			
			# elementul curent este la lineIndex*columns+columnIndex
			movl lineIndex, %eax          # eax=lineIndex
			movl $0, %edx
			mull columns                  # eax=eax*columns
			addl columnIndex, %eax        # eax=eax+columnIndex
			
			lea newMatrix, %esi            
			movl (%esi, %eax, 4), %ebx
			lea matrix, %edi
			movl %ebx, (%edi, %eax, 4)    # ebx=newMatrix[lineIndex][columnInddex]
			
			addl $1, columnIndex          # incrementam index coloana
			jmp forColumnAf

	contForLinesAf:                                 # restul de for linii
		addl $1, lineIndex
		jmp forLinesAf
		
randNou:
	pushl $newLine
	pushl $formatNewLine
	pushl out
	call fprintf
	pop %ebx
	pop %ebx
	pop %ebx
	jmp afMatrice

afMatrice:
	movl $1, lineIndex
	forLines:                                     # primul for pt linii
		movl lineIndex, %ecx
		cmp %ecx, liniiModif
		je etExit
		
		movl $1, columnIndex                  # al doilea for pt coloane
		forColumn:
			movl columnIndex, %ecx
			cmp %ecx, colModif
			je contForLines               # continui for linii
			
			# prelucrarea datelor
			# elementul curent este la lineIndex*columns+columnIndex
			movl lineIndex, %eax          # eax=lineIndex
			movl $0, %edx
			mull columns                  # eax=eax*columns
			addl columnIndex, %eax        # eax=eax+columnIndex
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx    # ebx=matrix[lineIndex][columnIndex]
			
			pushl %ebx                    # afisez elem curent ebx
			pushl $formatPrint
			pushl out
			call fprintf
			popl %ebx
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			addl $1, columnIndex          # incrementam index coloana
			jmp forColumn

	contForLines:                                 # restul de for linii
		pushl $newLine
		pushl $formatNewLine
		pushl out
		call fprintf
		pop %ebx
		pop %ebx
		pop %ebx
		addl $1, lineIndex
		jmp forLines
		

etExit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
