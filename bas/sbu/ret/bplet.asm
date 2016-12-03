* Utilise sb.putp (bp.let)
*
        section code

        xdef    bplet
*
bplet
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Stuff variable in parameter list with contents on stack
*
* input  :
*          a1 -> value on RI stack
*          a3 -> parameter
*
* output :    cc set
*          a3 -> next parameter
*          d0 =  error
*          no other registers affected
*
        movem.l d1-d3/a0-a2,-(a7)
        move.w  $120,a2
        jsr     (a2)
        movem.l (a7)+,d1-d3/a0-a2
        addq.l  #8,a3
        tst.l   d0
        rts
*
        end
