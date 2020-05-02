; ------------
; SUB-ROUTINES
; ------------

vblankwait:
    ; Wait for vblank to make sure PPU is ready
    BIT $2002
    BPL vblankwait
    RTS

; -------------------
; INITIALIZATION CODE
; -------------------
RESET:
    SEI ; Disable IRQs
    CLD ; Disable decimal mode

    JSR vblankwait ; jump to vblank wait #1

    LDX #$40
    STX $4017    ; disable APU frame IRQ
    LDX #$FF
    TXS          ; Set up stack
    INX          ; now X = 0
    STX $2000    ; disable NMI
    STX $2001    ; disable rendering
    STX $4010    ; disable DMC IRQs
    STX $E000    ; disable IRQ generation

    LDA #$00
clrmem:
    STA $0000, x
    STA $0100, x
    STA $0200, x
    STA $0300, x
    STA $0400, x
    STA $0500, x
    STA $0600, x
    STA $0700, x
    INX
    BNE clrmem

    JSR vblankwait  ; jump to vblank wait again, returns here

; Enable IRQs
; We do this later because otherwise FCEUX doesn't work, for some reason
    CLI

; SWITCH CHR BANK
    LDA #%00000010
    STA $8000
    LDA #0
    STA $8001

; LOAD PALATTES

    ; Prepare write to $3F00
    LDA $2002    ; read PPU status to reset the high/low latch to high
    LDA #$3F
    STA $2006    ; write the high byte of $3F00 address
    LDA #$00
    STA $2006    ; write the low byte of $3F00 address

    ; Write palattes
    LDX #$00
LoadPalettesLoop:
    LDA palettes, x        ;load palette byte
    STA $2007             ;write to PPU
    INX                   ;set index to next byte
    CPX #$20
    BNE LoadPalettesLoop  ;if x = $20, 32 bytes copied, all done

; LOAD BACKGROUND

    LDA $2002             ; read PPU status to reset the high/low latch
    LDA #$20
    STA $2006             ; write the high byte of $2000 address
    LDA #$00
    STA $2006             ; write the low byte of $2000 address

    LDX #$00              ; start out at 0
LoadBackgroundLoop:
    LDA #1                ; first tile (bush)
    STA $2007             ; write to PPU
    INX                   ; X = X + 1
    CPX #$40
    BNE LoadBackgroundLoop  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero
                          ; if compare was equal to 128, keep going down

LoadAttribute:
    LDA $2002             ; read PPU status to reset the high/low latch
    LDA #$23
    STA $2006             ; write the high byte of $23C0 address
    LDA #$C0
    STA $2006             ; write the low byte of $23C0 address
    LDX #$00              ; start out at 0
LoadAttributeLoop:
    LDA attribute, x      ; load data from address (attribute + the value in x)
    STA $2007             ; write to PPU
    INX                   ; X = X + 1
    CPX #$08              ; Compare X to hex $08, decimal 8 - copying 8 bytes
    BNE LoadAttributeLoop  ; Branch to LoadAttributeLoop if compare was Not Equal to zero
                          ; if compare was equal to 128, keep going down

    LDA #%10000000   ; enable NMI, sprites from Pattern Table 0
    STA $2000

    LDA #%00010000   ; no intensify (black background), enable sprites
    STA $2001

Forever:
    JMP Forever ; Infinite loop

; -------------
; SCROLL MACROS
; -------------

; Sets the page bit in PPUCTRL to the specified bit in SCROLL_PAGE
.macro STORE_PAGE _bit
    LDA SCROLL_PAGE
    AND _bit
    BEQ StorePage

    LDA #%00000001

StorePage:
    ORA #%10010000 ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
    STA PPUCTRL_ADDR
    .endm

; Increases a scroll variable in memory
.macro SCROLL _scroll_addr,_page_bit,_speed
    LDA _scroll_addr
    ADC _speed
    STA _scroll_addr

    BCC ScrollEnd

    ; switch page
    LDA SCROLL_PAGE
    EOR _page_bit
    STA SCROLL_PAGE

ScrollEnd:
    .endm

; Sets PPUSCROLL to a scroll variable in memory
.macro STORE_SCROLL _scroll_addr
    LDA $2002             ; read PPU status to reset the high/low latch
    LDX _scroll_addr
    STX $2005
    .endm

; ------------
; V-BLANK CODE
; ------------
NMI:
; Copy sprite data from $0200-$02FF
    LDA #$00
    STA $2003  ; set the low byte (00) of the RAM address
    LDA #$02
    STA $4014  ; set the high byte (02) of the RAM address, start the transfer

; PPU clean up
    LDA #%00011110 ; enable sprites, enable background, no clipping on left side
    STA $2001

; Scrolling
    SCROLL SCROLL_BACKGROUND,#SCROLL_BIT_BACKGROUND,#4

    STORE_SCROLL SCROLL_BACKGROUND
    LDX #$F8 ; y-scroll
    STX $2005

    STORE_PAGE #SCROLL_BIT_BACKGROUND

; Setup IRQ
    LDA #8+#8 ; apparently the first 8 lines don't count?

    STA $E000 ; Disable IRQ counter
    STA $C000 ; Set IRQ counter
    STA $C001 ; Set IRQ counter
    STA $E001 ; Enable IRQ counter

    RTI

; --------
; IRQ CODE
; --------
IRQ:
    SEI ; Disable maskable interrupts

; Save A, X, and Y
    pha
    txa
    pha
    tya
    pha

    ;LDA #0
    ;STA $2001

    STORE_SCROLL SCROLL_PLAYER
    STORE_PAGE #SCROLL_BIT_PLAYER

    LDA #1
    STA $E000 ; Acknowledge IRQ interrupt

; Load A, X, and Y
    pla
    tay
    pla
    tax
    pla

    RTI

; ----
; DATA
; ----

palettes:
    .db $27,$15,$2D,$30,  $27,$27,$27,$27,  $27,$27,$27,$27,  $27,$27,$27,$27   ;;background palette
    .db $27,$27,$27,$27,  $27,$27,$27,$27,  $27,$27,$27,$27,  $27,$27,$27,$27   ;;sprite palette

attribute:
    .db %00000000, %00010000, %01010000, %00010000, %00000000, %00000000, %00000000, %00110000
    .db $24,$24,$24,$24, $47,$47,$24,$24 ,$47,$47,$47,$47, $47,$47,$24,$24 ,$24,$24,$24,$24 ,$24,$24,$24,$24, $24,$24,$24,$24, $55,$56,$24,$24  ;;brick bottoms

; ---
; ???
; ---

    .pad $FFFA, $FF

; -----------------
; INTERRUPT VECTORS
; -----------------

    .base $fffa

    .dw NMI
    .dw RESET
    .dw IRQ
