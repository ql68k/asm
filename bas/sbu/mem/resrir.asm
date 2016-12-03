        section code

        xdef resrir

        xref resri

*
resrir
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Allocate and reserve (additional) room on on ri.stack and point to it
* Ensure a1 is word aligned
*
* input  :
*          d1.l = number of bytes required
* return : cc     ???
*          d1     preserved
*          a1  -> top of stack (lowest address) aligned on a word boundry
*          errors: returns directly to SB (Qdos), err.imem (Smsq)
*          d0      ???
*          no other registers affected
*          bv.rip may change during this call
*
        bsr     resri           reserve memory
        tst.l   d0
        bmi.s   rts

        sub.l   d1,$58(a6)      allocate d1 bytes
        btst    #0,d1           if even do no more
        beq.s   ri_rts

        subq.l  #1,$58(a6)      otherwise pull back one more
ri_rts
        movea.l $58(a6),a1      a1 -> TOS

rts
        rts
*
        end
