* S*Basic functions IOFSTR & IOFLIN
*
* V0.00 May 3rd 2002
* V0.01 Remove lf after flin
* V0.02 Fixed stack problem
* V0.03 Round buffer size down to even
*
* pjwitte 2oo2..2oi6+

        section code

        xdef ioflin,iofstr

        xref getpars,resrir,channel,bplet


*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Simplified FSTRG$:
*
* Usage: er% = IOFSTR%([#ch%;] timeout%, buflen%, str$)
*        er% = IOFLIN%([#ch%;] timeout%, buflen%, str$)
*
* Note: Buffer size rounded down to even, max 32766

ioflin
        moveq #2,d5             flag fetch LF-terminated line
        bra.s fs_0

iofstr
        moveq #3,d5             flag fetch bytes

fs_0
        move.l $58(a6),d7       save "empty" stack pointer
        sub.l $5c(a6),d7        make it relative to BAS

        bsr channel             get channel no. (default #3)
        bne.s exit

        moveq #$20,d0           get two (more) integers
        bsr getpars
        bne.s exit

        move.w 0(a6,a1.l),d3    d3 = timeout
        move.w 2(a6,a1.l),d1    d1 = number of bytes to fetch (nbf)
        bmi.s err_bp

        bclr #0,d1              make even and ensure < 32767

        move.w d1,d2            this is where iow.fxxx wants it
        ext.l d1
        addq.l #2,d1            room for len
        bsr resrir              reserve room

        add.l $5c(a6),d7        restore old stack relationship

        move.w d2,d1            any bytes to fetch?
        beq.s nul                is there justification for accepting this?

        move.l a1,a5            save offset to start
        addq.l #2,a1            leave room for len

        move.w d5,d0            use fline or fstrg
        trap #4                 relative
        trap #3

        subq.w #2,d5            flin?
        bne.s stuffret

        cmpi.b #10,-1(a6,a1.l)  last char lf?
        bne.s stuffret

        subq.w #1,d1            ignore lf

stuffret
        movea.l a5,a1           point to start

nul
        move.w d1,0(a6,a1.l)    set len
        move.l a1,$58(a6)
        move.w d0,d2            save error

        bsr bplet               stuff string into var str$
        bne.s exit

        move.l d7,$58(a6)       tidy stack
        subq.l #2,$58(a6)       2 bytes for return
        move.l $58(a6),a1

        move.w d2,0(a6,a1.l)    set error

        moveq #3,d4             return integer
        moveq #0,d0

exit
        rts

err_bp
        moveq #-15,d0
        rts

*
        end
