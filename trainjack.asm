; ---------
; Constants
; ---------

; Memory adresses
PPUCTRL_ADDR = $2000

SCROLL_PLAYER = $0000
SCROLL_BACKGROUND = $0001
SCROLL_TRAIN1 = $0002
SCROLL_TRAIN2 = $0003

SCROLL_PAGE = $0004 ; bit 0: player
                    ; bit 1: background
                    ; bit 2: train1
                    ; bit 3: train2

SPRITE_DATA = $0200 ; to $02FF

; Other
SCROLL_BIT_PLAYER = %00000001
SCROLL_BIT_BACKGROUND = %00000010
SCROLL_BIT_TRAIN1 = %00000100
SCROLL_BIT_TRAIN2 = %00001000

; -----------
; iNES header
; -----------

    .db "NES", $1a ; identification of the iNES header
    .db 16 ; number of 16KB PRG-ROM pages
    .db 16 ; number of 8KB CHR-ROM pages
    .db $40|1 ; mapper 4 and mirroring
    .dsb 9, $00 ; clear remaining bytes

; ---------------
; Program bank(s)
; ---------------

    ; bank 0
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 1
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 2
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 3
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 4
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 5
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 6
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 7
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 8
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 9
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 10
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 11
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 12
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 13
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 14
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 15
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 16
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 17
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 18
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 19
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 20
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 21
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 22
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 23
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 24
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 25
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 26
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 27
    .base $A000
    ; code
    .pad $C000, $FF

    ; bank 28
    .base $8000
    ; code
    .pad $A000,$FF

    ; bank 29
    .base $A000
    ; code
    .pad $C000, $FF

    ; ALWAYS active in ROM at C000-DFFF
    ; bank 30
    .base $C000
    ; code
    .pad $E000,$FF

    ; ALWAYS active in ROM at E000-FFFF
    ; bank 31
    .base $E000
    .include "PRG/prg031.asm"

; ---------------
; CHR-ROM bank(s)
; ---------------

    .incbin "CHR/chr000.chr" ; empty
    .incbin "CHR/chr001.chr" ; empty
    .incbin "CHR/chr002.chr" ; ...
    .incbin "CHR/chr003.chr"
    .incbin "CHR/chr004.chr"
    .incbin "CHR/chr005.chr"
    .incbin "CHR/chr006.chr"
    .incbin "CHR/chr007.chr"
    .incbin "CHR/chr008.chr"
    .incbin "CHR/chr009.chr"
    .incbin "CHR/chr010.chr"
    .incbin "CHR/chr011.chr"
    .incbin "CHR/chr012.chr"
    .incbin "CHR/chr013.chr"
    .incbin "CHR/chr014.chr"
    .incbin "CHR/chr015.chr"
    .incbin "CHR/chr016.chr"
    .incbin "CHR/chr017.chr"
    .incbin "CHR/chr018.chr"
    .incbin "CHR/chr019.chr"
    .incbin "CHR/chr020.chr"
    .incbin "CHR/chr021.chr"
    .incbin "CHR/chr022.chr"
    .incbin "CHR/chr023.chr"
    .incbin "CHR/chr024.chr"
    .incbin "CHR/chr025.chr"
    .incbin "CHR/chr026.chr"
    .incbin "CHR/chr027.chr"
    .incbin "CHR/chr028.chr"
    .incbin "CHR/chr029.chr"
    .incbin "CHR/chr030.chr"
    .incbin "CHR/chr031.chr"
    .incbin "CHR/chr032.chr"
    .incbin "CHR/chr033.chr"
    .incbin "CHR/chr034.chr"
    .incbin "CHR/chr035.chr"
    .incbin "CHR/chr036.chr"
    .incbin "CHR/chr037.chr"
    .incbin "CHR/chr038.chr"
    .incbin "CHR/chr039.chr"
    .incbin "CHR/chr040.chr"
    .incbin "CHR/chr041.chr"
    .incbin "CHR/chr042.chr"
    .incbin "CHR/chr043.chr"
    .incbin "CHR/chr044.chr"
    .incbin "CHR/chr045.chr"
    .incbin "CHR/chr046.chr"
    .incbin "CHR/chr047.chr"
    .incbin "CHR/chr048.chr"
    .incbin "CHR/chr049.chr"
    .incbin "CHR/chr050.chr"
    .incbin "CHR/chr051.chr"
    .incbin "CHR/chr052.chr"
    .incbin "CHR/chr053.chr"
    .incbin "CHR/chr054.chr"
    .incbin "CHR/chr055.chr"
    .incbin "CHR/chr056.chr"
    .incbin "CHR/chr057.chr"
    .incbin "CHR/chr058.chr"
    .incbin "CHR/chr059.chr"
    .incbin "CHR/chr060.chr"
    .incbin "CHR/chr061.chr"
    .incbin "CHR/chr062.chr"
    .incbin "CHR/chr063.chr"
    .incbin "CHR/chr064.chr"
    .incbin "CHR/chr065.chr"
    .incbin "CHR/chr066.chr"
    .incbin "CHR/chr067.chr"
    .incbin "CHR/chr068.chr"
    .incbin "CHR/chr069.chr"
    .incbin "CHR/chr070.chr"
    .incbin "CHR/chr071.chr"
    .incbin "CHR/chr072.chr"
    .incbin "CHR/chr073.chr"
    .incbin "CHR/chr074.chr"
    .incbin "CHR/chr075.chr"
    .incbin "CHR/chr076.chr"
    .incbin "CHR/chr077.chr"
    .incbin "CHR/chr078.chr"
    .incbin "CHR/chr079.chr"
    .incbin "CHR/chr080.chr"
    .incbin "CHR/chr081.chr"
    .incbin "CHR/chr082.chr"
    .incbin "CHR/chr083.chr"
    .incbin "CHR/chr084.chr"
    .incbin "CHR/chr085.chr"
    .incbin "CHR/chr086.chr"
    .incbin "CHR/chr087.chr"
    .incbin "CHR/chr088.chr"
    .incbin "CHR/chr089.chr"
    .incbin "CHR/chr090.chr"
    .incbin "CHR/chr091.chr"
    .incbin "CHR/chr092.chr"
    .incbin "CHR/chr093.chr"
    .incbin "CHR/chr094.chr"
    .incbin "CHR/chr095.chr"
    .incbin "CHR/chr096.chr"
    .incbin "CHR/chr097.chr"
    .incbin "CHR/chr098.chr"
    .incbin "CHR/chr099.chr"
    .incbin "CHR/chr100.chr"
    .incbin "CHR/chr101.chr"
    .incbin "CHR/chr102.chr"
    .incbin "CHR/chr103.chr"
    .incbin "CHR/chr104.chr"
    .incbin "CHR/chr105.chr"
    .incbin "CHR/chr106.chr"
    .incbin "CHR/chr107.chr"
    .incbin "CHR/chr108.chr"
    .incbin "CHR/chr109.chr"
    .incbin "CHR/chr110.chr"
    .incbin "CHR/chr111.chr"
    .incbin "CHR/chr112.chr"
    .incbin "CHR/chr113.chr"
    .incbin "CHR/chr114.chr"
    .incbin "CHR/chr115.chr"
    .incbin "CHR/chr116.chr"
    .incbin "CHR/chr117.chr"
    .incbin "CHR/chr118.chr"
    .incbin "CHR/chr119.chr"
    .incbin "CHR/chr120.chr"
    .incbin "CHR/chr121.chr"
    .incbin "CHR/chr122.chr"
    .incbin "CHR/chr123.chr"
    .incbin "CHR/chr124.chr"
    .incbin "CHR/chr125.chr"
    .incbin "CHR/chr126.chr"
    .incbin "CHR/chr127.chr"
