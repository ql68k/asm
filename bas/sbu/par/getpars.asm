* Getpars - general parameter getter
*  PWITTE June 18th 2000
*
* V0.02 NB! Versions prior to 1.00 are liable to change substantially!
*

         section code

         xdef getpars

*
getpars
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Gets specified number of parameters of a specified type
*
*   input  d0.w = num.t
*
*       where num represents the number of parameters to fetch
*       in the top three nibbles of the word (0..FFF)
*       A value of zero here means: Fetch any number.
*
*       t represents the type (0..6) in the last nibble
*       types may be one of: 0 - int, 2 - fp, 4 - str, 6 - lint
*
*   return cc  = set
*          d3 -  number fetched
*          a1 -> stack top (pointer to last parameter fetched)
*          a3 -> next par
*          a5 -> last par
* all other registers preserved
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
       movem.l d1/d2/d4/d6/a0/a2/a4,-(a7)
       move.w d0,d3
       lsr.w #4,d3               ;d3 contains number of pars required
       beq.s gp_2
       lsl.w #3,d3               ;convert to pointer value
       lea.l 0(a3,d3.w),a4       ;a4->last par to fetch
       cmpa.l a4,a5              ;are there at least that many pars?
       bge.s gp_1                ; yes continue
       moveq #-15,d0             ; no, quit with error
       bra.s gp_rts
gp_1
       exg a4,a5
gp_2
       andi.w #$000f,d0          ;d0.w = type
       move.w d0,a2
       movea.w $0112(a2),a2
       jsr     (a2)
       movea.l a5,a3             ;update first par pointer
       movea.l a4,a5             ;restore last par pointer
gp_rts
       movem.l (a7)+,d1/d2/d4/d6/a0/a2/a4
       rts
*
       end
