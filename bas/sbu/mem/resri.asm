* General SuperBASIC utilities
*
        section code

        xdef    resri

*
resri
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Sub-routine to reserve (additional) room on on ri.stack
* If there's anything on the stack you wish to keep set bv_rip to point to
* it before calling this routine.
*
* input  :
*          d1.l = number of bytes required
* return : cc     ???
*          a1  -> "empty" stack
*          errors: none, returns to SB with OM
*          a1/d0  ???
*          bv.rip may change during this call
*          d1 preserved, no other registers affected
*
        move.l  $58(a6),a1              ;bv.rip
        movem.l d1-d3/a2,-(a7)
        move.w  $11a,a2
        jsr     (a2)
        movem.l (a7)+,d1-d3/a2
        movea.l $58(a6),a1
        rts
*
        end
