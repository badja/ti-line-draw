; Sample Ion program for using lineDraw, lineClipAndDraw and lineClipAndDrawLong
;
; Version: 1.0
; Author: Badja <http://badja@calc.org> <badja@calc.org>
; Date: 19 June 2001

      .nolist
      #include "ion.inc"
      .list
#ifdef TI83P
      .org  progstart-2
      .db   $BB,$6D
#else
      .org  progstart
#endif
      ret
      jr    nc,start
      .db   "LineDraw Demo",0
start:

; Demonstrate lineClipAndDraw
; -------------------------------------------
      ld    de,256*(-48+256) + 31   ; (D, E) = (-48, 31)
      ld    hl,256*79 + (-56+256)   ; (H, L) = (79, -56)
clipLoop:
      push  de
      push  hl
      call  lineClipAndDraw         ; draw clipped line from (D, E) to (H, L) in graph buffer
      call  ionFastCopy             ; copy graph buffer to screen
      bcall(_cleargbuf)             ; clear graph buffer
      pop   hl
      pop   de
      inc   d                       ; D = D + 1
      inc   l                       ; L = L + 1
      ld    a,d
      cp    128
      jr    nz,clipLoop             ; loop while D <= 127

; Demonstrate lineClipAndDrawLong
; -------------------------------------------
      ld    de,256*127 + (-128+256) ; (D, E) = (127, -128)
      ld    hl,256*127 + 127        ; (H, L) = (127, 127)
longLoop:
      push  de
      push  hl
      call  lineClipAndDrawLong     ; draw clipped line from (D, E) to (H, L) in graph buffer
      call  ionFastCopy             ; copy graph buffer to screen
      bcall(_cleargbuf)             ; clear graph buffer
      pop   hl
      pop   de
      dec   h                       ; H = H - 1
      ld    a,h
      cp    -129
      jr    nz,longLoop             ; loop while H >= -128

; Demonstrate lineDraw
; -------------------------------------------
      ld    de,256*95         ; (D, E) = (95, 0)
      ld    hl,63             ; (H, L) = (0, 63)
lineLoop:
      push  de
      push  hl
      call  lineDraw          ; draw line from (D, E) to (H, L) in graph buffer
      call  ionFastCopy       ; copy graph buffer to screen
      pop   hl
      pop   de
      dec   d                 ; D = D - 1
      inc   h                 ; H = H + 1
      bit   7,d
      jr    z,lineLoop        ; loop while D >= 0

      bcall(_getkey)          ; wait for keypress
      ret


      #include "linedraw.inc" ; lineDraw routine
      #include "lineclip.inc" ; lineClipAndDraw routine

.end
