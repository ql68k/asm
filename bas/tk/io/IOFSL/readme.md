                        S*Basic functions IOFSTR & IOFLIN
                        =================================

Open source toolkit. No guarantees. Use at own risk. Feel free to correct
and improve.

V0.03,  by pjwitte, December 1st 2016    First release in the wild

        gtchan is a public domain sub routine by Tony Tebby


These are somewhat simplified S*BASIC functions to implement the io.fstr and
io.flin (QDOS) (iob.flin and iob.fmul in SMSQ/E) traps. Simplified here means:

1. QDOS and SMSQ/E error returns are long word by design; here I return them as
integer to avoid the time, space and hassel of converting them to float for
S*BASIC.

2. Some sub routines are generalised, as these commands originated in a
larger toolkit.

3. Rounding down buffer size instead of checking for max.


Usage:

        er% = IOFSTR%([#ch%;] timeout%, buflen%, str$)
        er% = IOFLIN%([#ch%;] timeout%, buflen%, str$)

Note: Buffer size rounded down to even, max 32766
