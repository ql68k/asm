* S(uper)BASIC proc/function header
*

        section code

        xref IOFSTR,IOFLIN

        lea.l   key,a1
        move.w  $110,a2
        jmp     (a2)
*
key
        dc.w    0,0,3
        dc.w    IOFSTR-*
        dc.b    7,'IOFSTR%'
        dc.w    IOFLIN-*
        dc.b    7,'IOFLIN%'
        dc.w    0

*
        end
