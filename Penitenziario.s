.section .rodata
filename: .asciz "penitenziario.dat"
read_mode: .asciz "r"
write_mode: .asciz "w"
fmt_new_line: .asciz "\n"
fmt_nome:
    .ascii "\n\n        <3 PENITENZIARIO DI BIKINI BOTTOM - ELENCO COMPLETO DEI DETENUTI <3 \n"
fmt_separatore:
    .asciz "--------------------------------------------------------------------------------------\n"
fmt_intestazione:
    .asciz "|  # | NOME           | COGNOME        | ETÀ     | SESSO | CRIMINE         | PENA    |\n"
fmt_detenuto:
    .asciz "|%3d | %-15s| %-15s| %-8d| %-6s| %-16s| %-8d|\n"
fmt_opzioni:
    .ascii "1: Aggiungi detenuto\n"
    .ascii "2: Elimina detenuto\n"
    .ascii "3: Scambia di posto due detenuti\n"
    .ascii "4: Età media dei detenuti\n"
    .ascii "5: Tempo di detenzione medio(double)\n"
    .ascii "6: Mostra i detenuti con un ETÀ maggiore o uguale a\n"
    .ascii "7: Mostra i detenuti con una PENA minore o uguale a\n"
    .ascii "8: Punti bonus?:D \n"
    .asciz "0: Esci\n"

fmt_eta_media: .asciz "\n\nEtà media dei detenuti: %d\n\n"
fmt_scambia_detenuti: .asciz "\n\n Scambio avvenuto con successo!\n\n"
fmt_tempo_detenzione_double: .asciz "\n\nTempo di detenzione medio: %.2f   (%d giorni)\n\n"
fmt_fail_save_data: .asciz "\n\nImpossibile salvere i dati.\n\n"
fmt_fail_aggiungi_detenuto: .asciz "\n\nMemoria insufficiente. Eliminare un detenuto, quindi riprovare.\n\n"
fmt_fail_rimuovi_detenuto: .asciz "\n\nImpossibile eliminare un detenuto: Non sono presenti detenuti"
fmt_fail_detenuti: .asciz "\n\nNessun detenuto presente\n"
fmt_fail_presenza: .asciz "\n\nNessun detenuto corrisponde ai parametri richiesti\n"
fmt_fail_opzione: .asciz "\n\nNessuna opzione corrisponde a questo numero \n    Seleziona un'opzione valida (0-8)\n"
fmt_fail_input: .asciz "\nIl numero inserito non corrisponde a nessun detenuto\n"
fmt_fail_scambio: .asciz "\nNon sono presenti sufficienti detenuti per effettuare uno scambio\n"

fmt_scan_int: .asciz "%d" 
fmt_scan_str: .asciz "%127s"

fmt_prompt_menu: .asciz "? "
fmt_prompt_nome: .asciz "Nome: "
fmt_prompt_cognome: .asciz "Cognome: "
fmt_prompt_eta: .asciz "Età (in anni): "
fmt_prompt_sesso: .asciz "Sesso (M/F/N): "
fmt_prompt_crimine: .asciz "Crimine: "
fmt_prompt_pena: .asciz "Pena (in mesi): "
fmt_prompt_index: .asciz "# (fuori range per annullare): "
fmt_prompt_scambia_detenuti1: .asciz "\n\nInserisci la posizione del detenuto da scambiare \n\n"
fmt_prompt_scambia_detenuti2: .asciz "\n\nInserisci una posizione, diversa dalla precedente, con cui scambiarlo\n\n"
fmt_prompt_filtro_eta_maggiore: .asciz "\n\n\t\t    Detenuti con un età MAGGIORE o uguale a: " 
fmt_prompt_filtro_pena_minore: .asciz "\n\n\tDetenuti con un tempo di detenzione (in mesi) MINORE o uguale a: "
fmt_easter_egg: .ascii "      .--..--..--..--..--..--.                                                  \n"
                .ascii "    .' \\  (`._   (_)     _   \\                                                \n"
                .ascii "  .'    |  '._)         (_)  |                                                  \n"
                .ascii "  \\ _.')\\      .----..---.   /                                                \n"
                .ascii "  |(_.'  |    /    .-\\-.  \\  |                                                \n"
                .ascii "  \\     0|    |   ( O| O) | o|                                                 \n"
                .ascii "   |  _  |  .--.____.'._.-.  |                                                  \n"
                .ascii "   \\ (_) | o         -` .-`  |                                                 \n"
                .ascii "    |    \\   |`-._ _ _ _ _\\ /                                                 \n"
                .ascii "    \\    |   |  `. |_||_|   |    https://www.youtube.com/watch?v=dQw4w9WgXcQ   \n"
                .ascii "    | o  |    \\_      \\     |     -.   .-.                                    \n"
                .ascii "    |.-.  \\     `--..-'   O |     `.`-' .'                                     \n"
                .ascii "  _.'  .' |     `-.-'      /-.__   ' .-'                                        \n"
                .ascii ".' `-.` '.|='=.='=.='=.='=|._/_ `-'.'                                           \n"
                .ascii "`-._  `.  |________/\_____|    `-.'                                             \n"
                .ascii "   .'   ).| '=' '='\/ '=' |                                                     \n"
                .ascii "   `._.`  '---------------'                                                     \n"
                .ascii "           //___\\   //___\\                                                    \n"
                .ascii "             ||       ||                                                        \n"
                .ascii "             ||_.-.   ||_.-.                                                    \n"
                .asciz "            (_.--__) (_.--__)                                                   \n"





.align 2

.data
n_detenuti: .word 0

.equ max_detenuti, 5
.equ size_detenuto_nome, 15
.equ size_detenuto_cognome, 15
.equ size_detenuto_eta, 4
.equ size_detenuto_sesso, 2
.equ size_detenuto_crimine, 30
.equ size_detenuto_pena, 4

.equ offset_detenuto_nome, 0
.equ offset_detenuto_cognome, offset_detenuto_nome + size_detenuto_nome //15
.equ offset_detenuto_eta, offset_detenuto_cognome + size_detenuto_cognome //30
.equ offset_detenuto_sesso, offset_detenuto_eta + size_detenuto_eta //34
.equ offset_detenuto_crimine, offset_detenuto_sesso + size_detenuto_sesso //36
.equ offset_detenuto_pena, offset_detenuto_crimine + size_detenuto_crimine //66
.equ detenuto_size_aligned, 80 //il primo multiplo di 16 dopo 70 ( 16*((70//16)+1) )

.bss
tmp_str: .skip 128
tmp_int: .skip 8
detenuto: .skip detenuto_size_aligned * max_detenuti //la tabella

.macro read_int prompt //macro per leggere int
    print \prompt

    adr x0, fmt_scan_int
    adr x1, tmp_int
    bl scanf

    ldr x0, tmp_int
.endm

.macro read_str prompt //macro per leggere string
    print \prompt

    adr x0, fmt_scan_str
    adr x1, tmp_str
    bl scanf
.endm

.macro save_to item, offset, size  //per copiare la stringa nell'array
    add x0, \item, \offset
    ldr x1, =tmp_str
    mov x2, \size
    bl strncpy

    add x0, \item, \offset + \size - 1
    strb wzr, [x0]
.endm

.macro str_spreg a 
    str \a, [sp, #-8]!
.endm

.macro ldr_spreg a 
    ldr \a, [sp], #8
.endm

.macro stp_spreg a b
    stp \a, \b, [sp, #-16]!
.endm

.macro ldp_spreg a b
    ldp \a, \b, [sp], #16
.endm

.macro convalida_input a //controllare se l'opzione scelta dall'utente è compresa tra le opzioni esistenti (1-8)
    cmp \a, 1 //controlla se l'input (a) è minore di 1
    blt stop

    mov w1, #8 
    cmp \a, w1 //controlla se l'input (a) è maggiore di 8
    bgt stop

    b skip
    stop:
        print fmt_fail_opzione //"Nessuna opzione corrisponde a questo numero \n    Seleziona un'opzione valida (0-8)"
        b main_loop
    skip:

.endm  

.macro print fmt
    adr x0, \fmt //stampa la format string in input
    bl printf
.endm

.macro print_detenuto a b
        /*  a rappresenta la posizione del detenuto nella tabella in output
            b è l'indirizzo di memoria del detenuto
            passare e stampare tutti i dati del detenuto */
        adr x0, fmt_detenuto // format string per stampare i dati di un detenuto
        add x1, \a, #1 // posizione del detenuto nella nuova tabella
        add x2, \b, offset_detenuto_nome //x2 = nome detenuto
        add x3, \b, offset_detenuto_cognome // x3 = cognome detenuto
        ldr w4, [\b, offset_detenuto_eta] // w4 = età detenuto
        add x5, \b, offset_detenuto_sesso // x5 = sesso detenuto 
        add x6, \b, offset_detenuto_crimine // x6 = crimine detenuto
        ldr w7, [\b, offset_detenuto_pena] // w7 = pena detenuto
        bl printf
.endm

.macro ControllaVuoto var jump
    ldr \var, n_detenuti // var = numero dei detenuti 
    cmp \var, #0 // controlla se è presente almeno un detenuto 
    beq \jump //in caso contrario salta all'error handling
.endm

.macro ControllaIndexDetenuto a b
    cmp \a, 1 //controlla se l'input (a) è minore di 1
    blt \b // se è minore non è valido e lo manda all'etichetta (b)

    ldr x1, n_detenuti //x1 = numero detenuti
    cmp \a, x1 //controlla se l'input (a) è minore di 1
    bgt \b // se è maggiore non è valido e lo manda all'etichetta (b)
.endm

.macro scambiareg dati pos 
    mov x0, \pos
    mov x1, \dati
    mov x2, detenuto_size_aligned
    bl memcpy

.endm
.text

.type main, %function
.global main
main:
    stp_spreg x29 x30
    stp_spreg x19 x20
    stp_spreg x21 x22
    stp_spreg x23 x24
    stp_spreg x25 x26
    str_spreg x27

    bl load_data

    main_loop:
        bl print_menu
        read_int fmt_prompt_menu //fmt_prompt_menu= "? "
        
        //menu
        cmp x0, #0 
        beq end_main_loop

        convalida_input w0

        cmp x0, #1
        bne no_aggiungi_detenuto
        bl aggiungi_detenuto
        no_aggiungi_detenuto:

        cmp x0, #2
        bne no_elimina_detenuto
        bl elimina_detenuto
        no_elimina_detenuto:

        cmp x0, #3
        bne no_scambia_detenuti
        bl scambia_detenuti
        no_scambia_detenuti:

        cmp x0, #4
        bne no_calcola_eta_media
        bl calcola_eta_media
        no_calcola_eta_media:

        cmp x0, #5
        bne no_calcola_detenzione_media_double
        bl calcola_detenzione_media_double
        no_calcola_detenzione_media_double:

        cmp x0, #6
        bne no_detenuti_piu_grandi
        bl detenuti_piu_grandi
        no_detenuti_piu_grandi:

        cmp x0, #7
        bne no_detenuti_pena_minore
        ControllaVuoto x21 detenuti_pena_minore_error //x21 = numero dei detenuti
        ldr x22, =detenuto //x22 = indirizzo di memoria del detenuto
        ldr x23, =detenuto //x23 = indirizzo di memoria del detenuto
        add x22, x22, offset_detenuto_pena //x22 = posizione della pena del detenuto corrente
        read_int fmt_prompt_filtro_pena_minore //leggi pena "Detenuti con un tempo di detenzione (in mesi) MINORE o uguale a:" 
        mov x19, x0 // x19 = numero detenuti
        mov x20, #0 // x20 = 0 (contatore detenuti)
        mov x25, #0 // x25 = 0 (contatore nuova tabella)
        mov x26, #0 // x26 = flag
        print fmt_separatore
        print fmt_intestazione
        bl detenuti_pena_minore
        print fmt_separatore
        print fmt_new_line
        bl no_detenuti_pena_minore
        detenuti_pena_minore_error:
            print fmt_fail_detenuti // "Nessun detenuto presente"
        no_detenuti_pena_minore:

        cmp x0, #8
        bne no_easter_egg 
        print fmt_easter_egg
        no_easter_egg:
        
    b main_loop

    end_main_loop:

    mov w0, #0

    ldr_spreg x27
    ldp_spreg x25 x26
    ldp_spreg x23 x24
    ldp_spreg x21 x22
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size main, (. - main)



.type load_data, %function //leggere i dati nel file penitenziario.dat
load_data:
    stp_spreg x29 x30
    str_spreg x19
    
    adr x0, filename //penitenziario.dat
    adr x1, read_mode
    bl fopen

    cmp x0, #0
    beq end_load_data

    mov x19, x0 

    ldr x0, =n_detenuti
    mov x1, #4
    mov x2, #1
    mov x3, x19
    bl fread

    ldr x0, =detenuto
    mov x1, detenuto_size_aligned
    mov x2, max_detenuti
    mov x3, x19
    bl fread 

    mov x0, x19
    bl fclose

    end_load_data:

    ldr_spreg x19
    ldp_spreg x29 x30
    ret
    .size load_data, (. - load_data)



.type save_data, %function //scrive su penitenziario.dat (aggiunge o elimina detenuti)
save_data:
    stp_spreg x29 x30
    str_spreg x19
    
    adr x0, filename
    adr x1, write_mode
    bl fopen

    cmp x0, #0 //controlla se l'apertura è andata a buon fine
    beq fail_save_data

        mov x19, x0

        ldr x0, =n_detenuti
        mov x1, #4
        mov x2, #1
        mov x3, x19
        bl fwrite

        ldr x0, =detenuto
        mov x1, detenuto_size_aligned
        mov x2, max_detenuti
        mov x3, x19
        bl fwrite

        mov x0, x19
        bl fclose

        b end_save_data

    fail_save_data:
        print fmt_fail_save_data // "Impossibile salvare i dati"

    end_save_data:

    ldr_spreg x19
    ldp_spreg x29 x30
    ret
    .size save_data, (. - save_data)



.type print_menu, %function //stampa la tabella (all'inizio e poi anche aggiornata ogni volta)
print_menu:
    stp_spreg x29 x30
    stp_spreg x19 x20
    stp_spreg x21 x22

    print fmt_nome
    print fmt_intestazione

    mov x19, #0 // x19 = contatore
    ldr x20, n_detenuti // x20 = n detenuti
    ldr x21, =detenuto // x21 = indirizzo di memoria del primo detenuto
    print_entries_loop: 
        cmp x19, x20
        bge end_print_entries_loop

        print_detenuto x19 x21 //stampa tutti i dati del detenuto

        add x19, x19, #1 // aumenta contatore 
        add x21, x21, detenuto_size_aligned // x21 = indirizzo di memoria del detenuto successivo
        b print_entries_loop
    end_print_entries_loop:

    print fmt_separatore

    print fmt_opzioni

    ldp_spreg x21 x22
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size print_menu, (. - print_menu)





//


//FUNZIONI DEL MENÙ---------------------------------------------
.type aggiungi_detenuto, %function
aggiungi_detenuto:
    stp_spreg x29 x30
    stp_spreg x19 x20
    
    ldr x19, n_detenuti // x19 = n_detenuti
    ldr x20, =detenuto // x20 = indirizzo di memoria dell'inizio della tabella
    mov x0, detenuto_size_aligned // x0 = 80
    mul x0, x19, x0  // x0 = 80*n_detenuti 
    add x20, x20, x0 // x20 = posizione successiva all'ultimo detenuto inserito
    
    cmp x19, max_detenuti //controllo memoria piena
    bge fail_aggiungi_detenuto
        read_str fmt_prompt_nome //"Nome: "
        save_to x20, offset_detenuto_nome, size_detenuto_nome
        
        read_str fmt_prompt_cognome //"Cognome: "
        save_to x20, offset_detenuto_cognome, size_detenuto_cognome

        read_int fmt_prompt_eta //"Età (in anni): "
        str w0, [x20, offset_detenuto_eta]      
        
        read_str fmt_prompt_sesso //"Sesso (M/F/N): "
        save_to x20, offset_detenuto_sesso, size_detenuto_sesso

        read_str fmt_prompt_crimine //"Crimine: "
        save_to x20, offset_detenuto_crimine, size_detenuto_crimine

        read_int fmt_prompt_pena //"Pena (in mesi): "
        str w0, [x20, offset_detenuto_pena]      

        add x19, x19, #1 
        ldr x20, =n_detenuti    
        str x19, [x20] //aggiorna il numero di detenuti

        bl save_data

        b end_aggiungi_detenuto 
    fail_aggiungi_detenuto:
        print fmt_fail_aggiungi_detenuto //"Memoria insufficiente. Eliminare un detenuto, quindi riprovare."
    end_aggiungi_detenuto:
    
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size aggiungi_detenuto, (. - aggiungi_detenuto)



.type elimina_detenuto, %function
elimina_detenuto:
    stp_spreg x29 x30

    ControllaVuoto x0, elimina_detenuto_error
        b rmv_detenuto
    elimina_detenuto_error:
        print fmt_fail_rimuovi_detenuto //"Impossibile eliminare un detenuto: Non sono presenti detenuti"
        b end_elimina_detenuto

    rmv_detenuto:

    read_int fmt_prompt_index //input e "# (fuori range per annullare): "

    ControllaIndexDetenuto x0 end_elimina_detenuto

    //esempio: indice del detenuto da eliminare (x0) = 4

    sub x5, x0, #1   // x5 = (indice del detenuto da eliminare - 1)  -                      (esempio: x5 = 3)
    ldr x6, n_detenuti // x6 = numero detenuti
    sub x6, x6, x0  // x6 = (numero detenuti - indice del detenuto da eliminare)  -         (esempio: x6 = 1)
    mov x7, detenuto_size_aligned // x7 = 80
    ldr x0, =detenuto
    mul x1, x5, x7  // x1 = ((indice del detenuto da eliminare -1) * 80)  -                 (esempio: x1 = 240)
    add x0, x0, x1  // x0 = posizione, in memoria, del 4 detenuto
    add x1, x0, x7  // x1 = (posizione, in memoria, del 4 detenuto + 80)  -                 (esempio: x1 = 320)
    mul x2, x6, x7  // x2 = (numero detenuti - indice del detenuto da eliminare) * 80)  -   (esempio: x2 = 80)

    bl memcpy  // memcpy prende gli x2 byte a partire dall'indirizzo contenuto in x1 e li copia nell'indirizzo contenuto in x0


    ldr x0, =n_detenuti
    ldr x1, [x0]
    sub x1, x1, #1
    str x1, [x0] //decrementa il valore di n_detenuti di 1

    bl save_data //salva tutti i cambiamenti

    end_elimina_detenuto:
    mov x0, #9 //per resettare x0
    
    ldp_spreg x29 x30
    ret
    .size elimina_detenuto, (. - elimina_detenuto)



.type scambia_detenuti, %function
scambia_detenuti:
    stp_spreg x29 x30
    stp_spreg x19 x20
    stp_spreg x21 x22
    stp_spreg x23 x24
    str_spreg x25 
    
    ldr x25, n_detenuti
    cmp x25, #1
    bne giusto
    print fmt_fail_scambio //"Non sono presenti sufficienti detenuti per effettuare uno scambio"
    bl end_scambia_detenuti
    giusto:
    
    ControllaVuoto x19, fail_scambia_detenuti //x19 = numero dei detenuti

    //controllo per verificare che il primo input sia un numero compreso tra 1 e 5
    b scambia_detenuti1
    errore_primo_input:
    print fmt_fail_input // "Il numero inserito non corrisponde a nessun detenuto"
    scambia_detenuti1:
    read_int fmt_prompt_scambia_detenuti1
    ControllaIndexDetenuto x0 errore_primo_input
    mov x20, x0 // x20 = pos primo detenuto da scambiare

    //controlli per verificare che il secondo input sia un numero compreso tra 1 e 5 e diverso dal primo
    b scambia_detenuti2
    errore_secondo_input:
    print fmt_fail_input // "Il numero inserito non corrisponde a nessun detenuto"
    scambia_detenuti2:
    read_int fmt_prompt_scambia_detenuti2
    ControllaIndexDetenuto x0 errore_secondo_input
    mov x21, x0 // x21 = pos secondo detenuto da scambiare
    cmp x20, x21
    beq scambia_detenuti2

    ldr x22, =detenuto //x22 = indirizzo di memoria del detenuto 1
    mov w2, #1
    loop_w20:
        cmp w2, w20
        beq salvaw20
        add x22, x22, detenuto_size_aligned //x22= indirizzo di memoria del detenuto successivo
        add w2, w2, #1
        b loop_w20
        salvaw20:

    ldr x23, =detenuto //x23 = indirizzo di memoria del detenuto 2
    mov w2, #1
    loop_w21:
        cmp w2, w21
        beq salvaw21
        add x23, x23, detenuto_size_aligned //x23= indirizzo di memoria del detenuto successivo
        add w2, w2, #1
        b loop_w21
        salvaw21:



    ldr x24, =detenuto // x24 = indirizzo di memoria dopo tutti i detenuti
    mov w2, #0
    loop_w19:
        cmp w2, w19
        beq salvaw19
        add x24, x24, detenuto_size_aligned
        add w2, w2, #1  
        b loop_w19
        salvaw19:

    
    scambiareg x22 x24 //x22 = dati      x24 = posizione dove salvare i dati

    scambiareg x23 x22 //x23 = dati      x22 = posizione dove salvare i dati

    scambiareg x24 x23 //x24 = dati      x23 = posizione dove salvare i dati
    print fmt_scambia_detenuti //"Scambio avvenuto con successo!"

    b end_scambia_detenuti 
    fail_scambia_detenuti:
        print fmt_fail_detenuti // "Nessun detenuto presente."

    end_scambia_detenuti:

    bl save_data

    ldr_spreg x25
    ldp_spreg x23 x24
    ldp_spreg x21 x22
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size scambia_detenuti, (. - scambia_detenuti)


.type calcola_eta_media, %function
calcola_eta_media:
    stp_spreg x29 x30
    
    ControllaVuoto x0 calcola_eta_media_error //x0 = numero dei detenuti

        mov x1, #0 // x1 = 0
        mov x2, #0 // x2 = 0 (contatore)
        ldr x3, =detenuto //x3 = indirizzo di memoria del detenuto
        add x3, x3, offset_detenuto_eta // x3 = posizione della pena del detenuto corrente
        calcola_eta_media_loop://do.. while
            ldr x4, [x3] //x4 = età del detenuto corrente
            add w1, w1, w4 //w1 = w1 + w4
            add x3, x3, detenuto_size_aligned //x3= indirizzo di memoria del detenuto successivo

            add w2, w2, #1 //aumenta di 1 il contatore
            cmp w2, w0 //compara il contatore con il numero dei detenuti
            blt calcola_eta_media_loop //ripeti il loop
        
        udiv w1, w1, w0 // w1 = w1/w0
        print fmt_eta_media //"Età media dei detenuti: %d"

        b end_calcola_eta_media

    calcola_eta_media_error:
        print fmt_fail_detenuti // "Nessun detenuto presente."
    
    end_calcola_eta_media:

    ldp_spreg x29 x30
    ret
    .size calcola_eta_media, (. - calcola_eta_media)



.type calcola_detenzione_media_double, %function
calcola_detenzione_media_double:
    stp_spreg x29 x30
    
    ControllaVuoto x0 calcola_detenzione_media_double_error //x0 = numero dei detenuti

        fmov d1, xzr
        mov x2, #0 //x2 contatore dei detenuti
        ldr x3, =detenuto //x3 = indirizzo di memoria del detenuto
        add x3, x3, offset_detenuto_pena // x3 = posizione della pena del detenuto corrente
        calcola_detenzione_media_double_loop: //do.. while
            ldr x4, [x3] //x4 = pena del detenuto corrente
            ucvtf d4, x4 //converte x4 in decimale e lo mette in d4
            fadd d1, d1, d4 // d1 = d1 + d4
            add x3, x3, detenuto_size_aligned //x3= indirizzo di memoria del detenuto successivo

            add x2, x2, #1 //aumenta di 1 il contatore
            cmp x2, x0 //compara il contatore con il numero dei detenuti
            blt calcola_detenzione_media_double_loop //ripeti il loop
        
        ucvtf d0, x0 // d0 = x0 (5, il numero dei detenuti)
        fdiv d0, d1, d0 // d0 = d0/d1
        mov x2, #30 //x2 = numero di giorni in un mese (30)
        ucvtf d2, x2 // d2 = x2 (30)
        fmul d1, d0, d2 //d1 = detenzione media * 30
        fcvtzu w1, d1 //convertire in intero il numero dei giorni
        print fmt_tempo_detenzione_double// "Tempo di detenzione medio: %.2f   (%d giorni)"

        b end_calcola_detenzione_media_double
    calcola_detenzione_media_double_error:
        print fmt_fail_detenuti // "Nessun detenuto presente."

    end_calcola_detenzione_media_double:

    ldp_spreg x29 x30
    ret
    .size calcola_detenzione_media_double, (. - calcola_detenzione_media_double)


//--------------------------------------------------------------


//vvvv-------------Filtro Iterativo-----------------------------
.type detenuti_piu_grandi, %function
detenuti_piu_grandi:
    stp_spreg x29 x30
    stp_spreg x19 x20
    stp_spreg x21 x22
    stp_spreg x23 x24
    stp_spreg x25 x26

    ControllaVuoto x21 detenuti_piu_grandi_error //x21 = numero dei detenuti
    
    read_int fmt_prompt_filtro_eta_maggiore //" Detenuti con un età MAGGIORE o uguale a: "
    
    mov w19, w0 //x19 = età inserita in input
    mov x20, #0 //x20 = contatore dei detenuti
    
    ldr x22, =detenuto 
    mov x23, x22  // x23 = x22

    add x22, x22, offset_detenuto_eta //x22 = posizione dell'età del detenuto corrente
    
    mov x25, #0 // x25 = 0, contatore nuova tabella
    print fmt_separatore
    print fmt_intestazione

    detenuti_piu_grandi_loop://do.. while

        ldr x24, [x22] //x24 = età detenuto
        cmp w19, w24 // x19 = età cercata
        bgt salta_piccoli // se x19 è più piccolo di x24 salta all'etichetta
        
        print_detenuto x25 x23
        add x25, x25, #1 //incrementa il contatore

        salta_piccoli:
        add x22, x22, detenuto_size_aligned //prossima età detenuto
        add x23, x23, detenuto_size_aligned //prossimo detenuto
        add x20, x20, #1   // indice +1
        cmp x20, x21  // fino a che x20 non arriva ad n_detenuti
        blt detenuti_piu_grandi_loop 
    
    print fmt_separatore
    cmp x25, #0
    bne end_detenuti_piu_grandi
        print fmt_fail_presenza //"Nessun detenuto corrisponde ai parametri richiesti"
        b end_detenuti_piu_grandi

    detenuti_piu_grandi_error:
        print fmt_fail_detenuti //"Nessun detenuto presente"

    end_detenuti_piu_grandi:

    ldp_spreg x25 x26
    ldp_spreg x23 x24
    ldp_spreg x21 x22
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size detenuti_piu_grandi, (. - detenuti_piu_grandi)

//^^^^----------------------------------------------------------


//vvvv-------------Filtro Ricorsivo-----------------------------
.type detenuti_pena_minore, %function
detenuti_pena_minore:
    stp_spreg x29 x30
    stp_spreg x19 x20
    stp_spreg x21 x22
    stp_spreg x23 x24
    str_spreg x25

    caso_base:
    cmp x20, x21 //x20= contatore, x21= num detenuti
    blt caso_ricorsivo 
    b end_detenuti_pena_minore

    caso_ricorsivo:
    ldr x24, [x22] //x24 = pena detenuto
    cmp w19, w24 // w19 = pena cercata
    blt salta_pene_piu_grandi // se x19 è più piccolo di x24 salta all'etichetta

    print_detenuto x25 x23 // x25 = contatore detenuto - x23 = indirizzo detenuto
    add x25, x25, #1 //x25 contatore

    salta_pene_piu_grandi:
        add x22, x22, detenuto_size_aligned //pena del detenuto
        add x23, x23, detenuto_size_aligned //detenuto
        add x20, x20, #1   // indice +1
    bl detenuti_pena_minore

    end_detenuti_pena_minore:

    ldr_spreg x25
    ldp_spreg x23 x24
    ldp_spreg x21 x22
    ldp_spreg x19 x20
    ldp_spreg x29 x30
    ret
    .size detenuti_pena_minore, (. - detenuti_pena_minore)
//^^^^----------------------------------------------------------

