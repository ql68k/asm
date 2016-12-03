* Set default or given channel V0.2   PUBLIC DOMAIN by Tony Tebby  QJUMP
* V0.3 - getpars, modified by pjwitte
*
* call parameters   : a3 and a5 standard pointers to name table for parameters
* return parameters : d6 pointer to channel table
*                     a0 channel id
*                     d3 smashed
         section code

         xdef    channel,chan_get,chan_d6,chan_look,chan_par

         xref   getpars
*
channel
        moveq   #3,d6           ;default is channel #3
chan_d6
        cmpa.l  a3,a5           ;are there any parameters?
        ble.s   chan_look       ;... no
chan_par
        btst    #7,1(a6,a3.l)   ;has the first parameter a hash?
        beq.s   chan_look       ;... no
chan_get
        moveq   #$10,d0         get one integer
        bsr     getpars
        bmi.s   chan_exit
        move.w  0(a6,a1.l),d6   ;get value in d6 to replace the default
        addq.l  #2,a1
        move.l  a1,$58(a6)      ;reset ri stack pointer
*
chan_look
        mulu    #$28,d6         ;make d6 (long) pointer to channel table
        add.l   $30(a6),d6      ;bv.chbas
        cmp.l   $34(a6),d6      ;bv.chp is it within the table?
        bge.s   cherr_no        ;... no
        move.l  0(a6,d6.l),a0   ;set channel id
        move.w  a0,d0           ;is it open?
        bmi.s   cherr_no        ;... no
        moveq   #0,d0           ;no error
chan_exit
        rts
cherr_no
        moveq   #-6,d0          ;err.no  channel not open
        rts

        end
