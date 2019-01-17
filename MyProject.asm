
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,28 :: 		void interrupt(){
;MyProject.c,29 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;MyProject.c,30 :: 		fw++,fw%=9;
	INCF       _fw+0, 1
	MOVLW      9
	MOVWF      R4+0
	MOVF       _fw+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _fw+0
;MyProject.c,31 :: 		}
L_end_interrupt:
L__interrupt67:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_le:

;MyProject.c,34 :: 		void le(char i,char j,char k){
;MyProject.c,35 :: 		fx=j;
	MOVF       FARG_le_j+0, 0
	MOVWF      _fx+0
;MyProject.c,36 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,37 :: 		while(fw==k){
L_le0:
	MOVF       _fw+0, 0
	XORWF      FARG_le_k+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_le1
;MyProject.c,38 :: 		if(PORTB.f1)
	BTFSS      PORTB+0, 1
	GOTO       L_le2
;MyProject.c,39 :: 		break;
	GOTO       L_le1
L_le2:
;MyProject.c,40 :: 		if(PORTA.f4&&!flag)
	BTFSS      PORTA+0, 4
	GOTO       L_le5
	MOVF       _flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_le5
L__le61:
;MyProject.c,41 :: 		flag1++,fx++,fx%=i,flag++;
	INCF       _flag1+0, 1
	INCF       _fx+0, 1
	MOVF       FARG_le_i+0, 0
	MOVWF      R4+0
	MOVF       _fx+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _fx+0
	INCF       _flag+0, 1
L_le5:
;MyProject.c,42 :: 		if((!PORTA.f4)&&flag)
	BTFSC      PORTA+0, 4
	GOTO       L_le8
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_le8
L__le60:
;MyProject.c,43 :: 		flag=0;
	CLRF       _flag+0
L_le8:
;MyProject.c,44 :: 		Lcd_Chr_Cp(fx+48);
	MOVLW      48
	ADDWF      _fx+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;MyProject.c,45 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,46 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_le9:
	DECFSZ     R13+0, 1
	GOTO       L_le9
	DECFSZ     R12+0, 1
	GOTO       L_le9
	NOP
;MyProject.c,47 :: 		}
	GOTO       L_le0
L_le1:
;MyProject.c,48 :: 		while(PORTB.f1);
L_le10:
	BTFSS      PORTB+0, 1
	GOTO       L_le11
	GOTO       L_le10
L_le11:
;MyProject.c,49 :: 		}
L_end_le:
	RETURN
; end of _le

_inic:

;MyProject.c,52 :: 		void inic(){
;MyProject.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,55 :: 		Lcd_Out(2,4,",   /  /20");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,56 :: 		Lcd_Out(1,6,":  :");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,57 :: 		}
L_end_inic:
	RETURN
; end of _inic

_le2direto:

;MyProject.c,60 :: 		void le2direto(char level,char corte,char *v){
;MyProject.c,61 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,62 :: 		le(10,*v & 0x0F,level);
	MOVLW      10
	MOVWF      FARG_le_i+0
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVLW      15
	ANDWF      INDF+0, 0
	MOVWF      FARG_le_j+0
	MOVF       FARG_le2direto_level+0, 0
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,63 :: 		*v=(*v & 0xF0)|fx;
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVLW      240
	ANDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       _fx+0, 0
	IORWF      R0+0, 1
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,65 :: 		le(corte,*v>>4,level);
	MOVF       FARG_le2direto_corte+0, 0
	MOVWF      FARG_le_i+0
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FARG_le_j+0
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	MOVF       FARG_le2direto_level+0, 0
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,66 :: 		*v=(*v & 0x0F)|(fx<<4);
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVLW      15
	ANDWF      INDF+0, 0
	MOVWF      R2+0
	MOVF       _fx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R2+0, 0
	IORWF      R0+0, 1
	MOVF       FARG_le2direto_v+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,67 :: 		}
L_end_le2direto:
	RETURN
; end of _le2direto

_ajust:

;MyProject.c,70 :: 		void ajust(){
;MyProject.c,71 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,73 :: 		while(fw==1){
L_ajust12:
	MOVF       _fw+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_ajust13
;MyProject.c,74 :: 		Lcd_Chr(1,11, (seconds & 0x0F) + 48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      15
	ANDWF      _seconds+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;MyProject.c,75 :: 		le(10,seconds & 0x0F,1);
	MOVLW      10
	MOVWF      FARG_le_i+0
	MOVLW      15
	ANDWF      _seconds+0, 0
	MOVWF      FARG_le_j+0
	MOVLW      1
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,76 :: 		seconds=(seconds & 0xF0)|fx;
	MOVLW      240
	ANDWF      _seconds+0, 0
	MOVWF      R0+0
	MOVF       _fx+0, 0
	IORWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _seconds+0
;MyProject.c,78 :: 		le(6,seconds>>4,1);
	MOVLW      6
	MOVWF      FARG_le_i+0
	MOVF       R1+0, 0
	MOVWF      FARG_le_j+0
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	MOVLW      1
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,79 :: 		seconds=(seconds & 0x0F)|(fx<<4);
	MOVLW      15
	ANDWF      _seconds+0, 1
	MOVF       _fx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      _seconds+0, 1
;MyProject.c,81 :: 		le2direto(1,6,&minutes);
	MOVLW      1
	MOVWF      FARG_le2direto_level+0
	MOVLW      6
	MOVWF      FARG_le2direto_corte+0
	MOVLW      _minutes+0
	MOVWF      FARG_le2direto_v+0
	CALL       _le2direto+0
;MyProject.c,82 :: 		le2direto(1,fx>3?2:3,&hours);
	MOVLW      1
	MOVWF      FARG_le2direto_level+0
	MOVF       _fx+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_ajust14
	MOVLW      2
	MOVWF      ?FLOC___ajustT43+0
	GOTO       L_ajust15
L_ajust14:
	MOVLW      3
	MOVWF      ?FLOC___ajustT43+0
L_ajust15:
	MOVF       ?FLOC___ajustT43+0, 0
	MOVWF      FARG_le2direto_corte+0
	MOVLW      _hours+0
	MOVWF      FARG_le2direto_v+0
	CALL       _le2direto+0
;MyProject.c,84 :: 		Lcd_Chr(2,15, (year & 0x0F)   + 48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      15
	ANDWF      _year+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;MyProject.c,85 :: 		le(10,year & 0x0F,1);
	MOVLW      10
	MOVWF      FARG_le_i+0
	MOVLW      15
	ANDWF      _year+0, 0
	MOVWF      FARG_le_j+0
	MOVLW      1
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,86 :: 		year=(year & 0xF0)|fx;
	MOVLW      240
	ANDWF      _year+0, 0
	MOVWF      R0+0
	MOVF       _fx+0, 0
	IORWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _year+0
;MyProject.c,88 :: 		le(10,year>>4,1);
	MOVLW      10
	MOVWF      FARG_le_i+0
	MOVF       R1+0, 0
	MOVWF      FARG_le_j+0
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	MOVLW      1
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,89 :: 		year=(year & 0x0F)|(fx<<4);
	MOVLW      15
	ANDWF      _year+0, 1
	MOVF       _fx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      _year+0, 1
;MyProject.c,91 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,92 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,94 :: 		le2direto(1,fx>2?1:2,&month);
	MOVLW      1
	MOVWF      FARG_le2direto_level+0
	MOVF       _fx+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_ajust16
	MOVLW      1
	MOVWF      ?FLOC___ajustT55+0
	GOTO       L_ajust17
L_ajust16:
	MOVLW      2
	MOVWF      ?FLOC___ajustT55+0
L_ajust17:
	MOVF       ?FLOC___ajustT55+0, 0
	MOVWF      FARG_le2direto_corte+0
	MOVLW      _month+0
	MOVWF      FARG_le2direto_v+0
	CALL       _le2direto+0
;MyProject.c,95 :: 		le2direto(1,4,&day);
	MOVLW      1
	MOVWF      FARG_le2direto_level+0
	MOVLW      4
	MOVWF      FARG_le2direto_corte+0
	MOVLW      _day+0
	MOVWF      FARG_le2direto_v+0
	CALL       _le2direto+0
;MyProject.c,97 :: 		while(fw==1){
L_ajust18:
	MOVF       _fw+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_ajust19
;MyProject.c,98 :: 		if(PORTB.f1){
	BTFSS      PORTB+0, 1
	GOTO       L_ajust20
;MyProject.c,99 :: 		flag1=1;
	MOVLW      1
	MOVWF      _flag1+0
;MyProject.c,100 :: 		break;
	GOTO       L_ajust19
;MyProject.c,101 :: 		}
L_ajust20:
;MyProject.c,103 :: 		if(PORTA.f4&&!flag)
	BTFSS      PORTA+0, 4
	GOTO       L_ajust23
	MOVF       _flag+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_ajust23
L__ajust63:
;MyProject.c,104 :: 		flag1++,diasem%=7,diasem++,flag++;
	INCF       _flag1+0, 1
	MOVLW      7
	MOVWF      R4+0
	MOVF       _diasem+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _diasem+0
	INCF       R0+0, 0
	MOVWF      _diasem+0
	INCF       _flag+0, 1
L_ajust23:
;MyProject.c,106 :: 		if((!PORTA.f4)&&flag)
	BTFSC      PORTA+0, 4
	GOTO       L_ajust26
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ajust26
L__ajust62:
;MyProject.c,107 :: 		flag=0;
	CLRF       _flag+0
L_ajust26:
;MyProject.c,109 :: 		Lcd_Out(2, 1,&dsq[(diasem-1)<<2]);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      1
	SUBWF      _diasem+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _dsq+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,111 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_ajust27:
	DECFSZ     R13+0, 1
	GOTO       L_ajust27
	DECFSZ     R12+0, 1
	GOTO       L_ajust27
	NOP
;MyProject.c,112 :: 		}
	GOTO       L_ajust18
L_ajust19:
;MyProject.c,113 :: 		while(PORTB.f1);
L_ajust28:
	BTFSS      PORTB+0, 1
	GOTO       L_ajust29
	GOTO       L_ajust28
L_ajust29:
;MyProject.c,114 :: 		}
	GOTO       L_ajust12
L_ajust13:
;MyProject.c,117 :: 		if(flag1){
	MOVF       _flag1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ajust30
;MyProject.c,118 :: 		flag1=0,fw=0;
	CLRF       _flag1+0
	CLRF       _fw+0
;MyProject.c,119 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;MyProject.c,120 :: 		Soft_I2C_Write(0xD0);
	MOVLW      208
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,121 :: 		Soft_I2C_Write(0);
	CLRF       FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,122 :: 		Soft_I2C_Write(seconds);              // Start from address 2
	MOVF       _seconds+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,123 :: 		Soft_I2C_Write(minutes);
	MOVF       _minutes+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,124 :: 		Soft_I2C_Write(hours);
	MOVF       _hours+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,125 :: 		Soft_I2C_Write(diasem);
	MOVF       _diasem+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,126 :: 		Soft_I2C_Write(day);
	MOVF       _day+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,127 :: 		Soft_I2C_Write(month);
	MOVF       _month+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,128 :: 		Soft_I2C_Write(year);
	MOVF       _year+0, 0
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,129 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;MyProject.c,130 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,131 :: 		return;
	GOTO       L_end_ajust
;MyProject.c,132 :: 		}
L_ajust30:
;MyProject.c,134 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,135 :: 		Lcd_Out(1,2,"Alarme  :");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,136 :: 		Lcd_Chr(2,6,':');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,138 :: 		for(zi=0;zi<7;zi++){
	CLRF       _zi+0
L_ajust31:
	MOVLW      7
	SUBWF      _zi+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ajust32
;MyProject.c,139 :: 		Lcd_Chr(1, 9, zi+ 49);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      49
	ADDWF      _zi+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,140 :: 		Lcd_Chr(2, 4, ((horalarm[zi]) >> 4) + 48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _zi+0, 0
	ADDLW      _horalarm+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;MyProject.c,141 :: 		Lcd_Chr_Cp((horalarm[zi] & 0x0F) + 48);
	MOVF       _zi+0, 0
	ADDLW      _horalarm+0
	MOVWF      FSR
	MOVLW      15
	ANDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,142 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,143 :: 		Lcd_Chr_Cp(((minutalarm[zi] & 0x70) >> 4) + 48);
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      112
	ANDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,144 :: 		Lcd_Chr_Cp((minutalarm[zi] & 0x0F) + 48);
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      15
	ANDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,146 :: 		while(fw==(zi+2)){
L_ajust34:
	MOVLW      2
	ADDWF      _zi+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ajust72
	MOVF       R1+0, 0
	XORWF      _fw+0, 0
L__ajust72:
	BTFSS      STATUS+0, 2
	GOTO       L_ajust35
;MyProject.c,147 :: 		Lcd_Chr(2,11, ((minutalarm[zi] & 0x80) >> 7) + 48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;MyProject.c,148 :: 		le(2,(minutalarm[zi]&0x80)>>7,zi+2);
	MOVLW      2
	MOVWF      FARG_le_i+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      1
	MOVWF      FARG_le_j+0
	MOVLW      2
	ADDWF      _zi+0, 0
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,149 :: 		minutalarm[zi]=(minutalarm[zi] & 0x7F)|(fx<<7);
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVLW      127
	ANDWF      INDF+0, 0
	MOVWF      R2+0
	MOVLW      7
	MOVWF      R1+0
	MOVF       _fx+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ajust73:
	BTFSC      STATUS+0, 2
	GOTO       L__ajust74
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ajust73
L__ajust74:
	MOVF       R2+0, 0
	IORWF      R0+0, 1
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,151 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,152 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
	MOVLW      16
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,153 :: 		le(10,minutalarm[zi] & 0x0F,zi+2);
	MOVLW      10
	MOVWF      FARG_le_i+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      15
	ANDWF      INDF+0, 0
	MOVWF      FARG_le_j+0
	MOVLW      2
	ADDWF      _zi+0, 0
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,154 :: 		minutalarm[zi]=(minutalarm[zi] & 0xF0)|fx;
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVLW      240
	ANDWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       _fx+0, 0
	IORWF      R0+0, 1
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,156 :: 		le(6,(minutalarm[zi]&0x70)>>4,zi+2);
	MOVLW      6
	MOVWF      FARG_le_i+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVLW      112
	ANDWF      INDF+0, 0
	MOVWF      FARG_le_j+0
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	RRF        FARG_le_j+0, 1
	BCF        FARG_le_j+0, 7
	MOVLW      2
	ADDWF      _zi+0, 0
	MOVWF      FARG_le_k+0
	CALL       _le+0
;MyProject.c,157 :: 		minutalarm[zi]=(minutalarm[zi] & 0x8F)|(fx<<4);
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      R3+0
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVLW      143
	ANDWF      INDF+0, 0
	MOVWF      R2+0
	MOVF       _fx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R2+0, 0
	IORWF      R0+0, 1
	MOVF       R3+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,159 :: 		le2direto(zi+2,fx>3?2:3,&horalarm[zi]);
	MOVLW      2
	ADDWF      _zi+0, 0
	MOVWF      FARG_le2direto_level+0
	MOVF       _fx+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_ajust36
	MOVLW      2
	MOVWF      ?FLOC___ajustT166+0
	GOTO       L_ajust37
L_ajust36:
	MOVLW      3
	MOVWF      ?FLOC___ajustT166+0
L_ajust37:
	MOVF       ?FLOC___ajustT166+0, 0
	MOVWF      FARG_le2direto_corte+0
	MOVF       _zi+0, 0
	ADDLW      _horalarm+0
	MOVWF      FARG_le2direto_v+0
	CALL       _le2direto+0
;MyProject.c,160 :: 		}
	GOTO       L_ajust34
L_ajust35:
;MyProject.c,162 :: 		if(flag1){
	MOVF       _flag1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_ajust38
;MyProject.c,163 :: 		flag1=0,fw=0;
	CLRF       _flag1+0
	CLRF       _fw+0
;MyProject.c,164 :: 		inic();
	CALL       _inic+0
;MyProject.c,165 :: 		}
L_ajust38:
;MyProject.c,138 :: 		for(zi=0;zi<7;zi++){
	INCF       _zi+0, 1
;MyProject.c,167 :: 		}
	GOTO       L_ajust31
L_ajust32:
;MyProject.c,168 :: 		inic();
	CALL       _inic+0
;MyProject.c,169 :: 		}
L_end_ajust:
	RETURN
; end of _ajust

_imp:

;MyProject.c,172 :: 		void imp(char q){
;MyProject.c,173 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,174 :: 		Lcd_Chr_Cp(((q)  >> 4) + 48);
	MOVF       FARG_imp_q+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,175 :: 		Lcd_Chr_Cp((q & 0x0F) + 48);
	MOVLW      15
	ANDWF      FARG_imp_q+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,176 :: 		}
L_end_imp:
	RETURN
; end of _imp

_main:

;MyProject.c,179 :: 		void main() {
;MyProject.c,180 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,181 :: 		TRISA = 0xfb;
	MOVLW      251
	MOVWF      TRISA+0
;MyProject.c,182 :: 		TRISB = 0xff;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,184 :: 		CMCON = 0X07;
	MOVLW      7
	MOVWF      CMCON+0
;MyProject.c,186 :: 		dsq[0]=0x44,dsq[1]=0x6f,dsq[2]=0x6d,dsq[3]=0x00,dsq[4]=0x53,dsq[5]=0x65,dsq[6]=0x67,dsq[7]=0x00,dsq[8]=0x54,dsq[9]=0x65,dsq[10]=0x72,dsq[11]=0x00,dsq[12]=0x51,dsq[13]=0x75,dsq[14]=0x61,dsq[15]=0x00,dsq[16]=0x51,dsq[17]=0x75,dsq[18]=0x69,dsq[19]=0x00,dsq[20]=0x53,dsq[21]=0x65,dsq[22]=0x78,dsq[23]=0x00,dsq[24]=0x53,dsq[25]=0x61,dsq[26]=0x62,dsq[27]=0x00;
	MOVLW      68
	MOVWF      _dsq+0
	MOVLW      111
	MOVWF      _dsq+1
	MOVLW      109
	MOVWF      _dsq+2
	CLRF       _dsq+3
	MOVLW      83
	MOVWF      _dsq+4
	MOVLW      101
	MOVWF      _dsq+5
	MOVLW      103
	MOVWF      _dsq+6
	CLRF       _dsq+7
	MOVLW      84
	MOVWF      _dsq+8
	MOVLW      101
	MOVWF      _dsq+9
	MOVLW      114
	MOVWF      _dsq+10
	CLRF       _dsq+11
	MOVLW      81
	MOVWF      _dsq+12
	MOVLW      117
	MOVWF      _dsq+13
	MOVLW      97
	MOVWF      _dsq+14
	CLRF       _dsq+15
	MOVLW      81
	MOVWF      _dsq+16
	MOVLW      117
	MOVWF      _dsq+17
	MOVLW      105
	MOVWF      _dsq+18
	CLRF       _dsq+19
	MOVLW      83
	MOVWF      _dsq+20
	MOVLW      101
	MOVWF      _dsq+21
	MOVLW      120
	MOVWF      _dsq+22
	CLRF       _dsq+23
	MOVLW      83
	MOVWF      _dsq+24
	MOVLW      97
	MOVWF      _dsq+25
	MOVLW      98
	MOVWF      _dsq+26
	CLRF       _dsq+27
;MyProject.c,188 :: 		for(zi=0;zi<7;zi++)
	CLRF       _zi+0
L_main39:
	MOVLW      7
	SUBWF      _zi+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;MyProject.c,189 :: 		horalarm[zi]=0,minutalarm[zi]=0;
	MOVF       _zi+0, 0
	ADDLW      _horalarm+0
	MOVWF      FSR
	CLRF       INDF+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	CLRF       INDF+0
;MyProject.c,188 :: 		for(zi=0;zi<7;zi++)
	INCF       _zi+0, 1
;MyProject.c,189 :: 		horalarm[zi]=0,minutalarm[zi]=0;
	GOTO       L_main39
L_main40:
;MyProject.c,191 :: 		Soft_I2C_Init();           // Initialize Soft I2C communication
	CALL       _Soft_I2C_Init+0
;MyProject.c,192 :: 		Lcd_Init();                // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,194 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;MyProject.c,195 :: 		INTCON.PEIE=1;
	BSF        INTCON+0, 6
;MyProject.c,196 :: 		INTCON.INTE=1;
	BSF        INTCON+0, 4
;MyProject.c,198 :: 		inic();
	CALL       _inic+0
;MyProject.c,200 :: 		while (1) {
L_main42:
;MyProject.c,201 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;MyProject.c,202 :: 		Soft_I2C_Write(0xD0);
	MOVLW      208
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,203 :: 		Soft_I2C_Write(0);              // Start from address 2
	CLRF       FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,204 :: 		Soft_I2C_Start();
	CALL       _Soft_I2C_Start+0
;MyProject.c,205 :: 		Soft_I2C_Write(0xD1);
	MOVLW      209
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,207 :: 		seconds = Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _seconds+0
;MyProject.c,208 :: 		minutes = Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _minutes+0
;MyProject.c,209 :: 		hours = Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _hours+0
;MyProject.c,210 :: 		diasem=Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _diasem+0
;MyProject.c,211 :: 		day = Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _day+0
;MyProject.c,212 :: 		month = Soft_I2C_Read(1);
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _month+0
;MyProject.c,213 :: 		year=Soft_I2C_Read(0);
	CLRF       FARG_Soft_I2C_Read_ack+0
	CLRF       FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _year+0
;MyProject.c,214 :: 		Soft_I2C_Stop();
	CALL       _Soft_I2C_Stop+0
;MyProject.c,216 :: 		Lcd_Out(2, 1,&dsq[(diasem-1)<<2]);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      1
	SUBWF      _diasem+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _dsq+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,217 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,219 :: 		imp(day);
	MOVF       _day+0, 0
	MOVWF      FARG_imp_q+0
	CALL       _imp+0
;MyProject.c,220 :: 		imp(month);
	MOVF       _month+0, 0
	MOVWF      FARG_imp_q+0
	CALL       _imp+0
;MyProject.c,221 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,222 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,223 :: 		imp(year);
	MOVF       _year+0, 0
	MOVWF      FARG_imp_q+0
	CALL       _imp+0
;MyProject.c,225 :: 		Lcd_Chr(1, 4, ((hours)  >> 4)   + 48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _hours+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	RRF        FARG_Lcd_Chr_out_char+0, 1
	BCF        FARG_Lcd_Chr_out_char+0, 7
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_out_char+0, 1
	CALL       _Lcd_Chr+0
;MyProject.c,226 :: 		Lcd_Chr_Cp((hours & 0x0F)   + 48);
	MOVLW      15
	ANDWF      _hours+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;MyProject.c,227 :: 		imp(minutes);
	MOVF       _minutes+0, 0
	MOVWF      FARG_imp_q+0
	CALL       _imp+0
;MyProject.c,228 :: 		imp(seconds);
	MOVF       _seconds+0, 0
	MOVWF      FARG_imp_q+0
	CALL       _imp+0
;MyProject.c,230 :: 		for(zi=0;zi<7;zi++)
	CLRF       _zi+0
L_main44:
	MOVLW      7
	SUBWF      _zi+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main45
;MyProject.c,231 :: 		if(hours==horalarm[zi]&&!seconds&&(minutes|0x80)==minutalarm[zi])
	MOVF       _zi+0, 0
	ADDLW      _horalarm+0
	MOVWF      FSR
	MOVF       _hours+0, 0
	XORWF      INDF+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main49
	MOVF       _seconds+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main49
	MOVLW      128
	IORWF      _minutes+0, 0
	MOVWF      R1+0
	MOVF       _zi+0, 0
	ADDLW      _minutalarm+0
	MOVWF      FSR
	MOVF       R1+0, 0
	XORWF      INDF+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main49
L__main65:
;MyProject.c,232 :: 		flagalarm=1;
	MOVLW      1
	MOVWF      _flagalarm+0
L_main49:
;MyProject.c,230 :: 		for(zi=0;zi<7;zi++)
	INCF       _zi+0, 1
;MyProject.c,232 :: 		flagalarm=1;
	GOTO       L_main44
L_main45:
;MyProject.c,234 :: 		if(flagalarm){
	MOVF       _flagalarm+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main50
;MyProject.c,235 :: 		flagalarm++,flagalarm%21;
	INCF       _flagalarm+0, 1
;MyProject.c,237 :: 		PORTA.f2=1;
	BSF        PORTA+0, 2
;MyProject.c,238 :: 		Delay_ms(180);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      212
	MOVWF      R12+0
	MOVLW      133
	MOVWF      R13+0
L_main51:
	DECFSZ     R13+0, 1
	GOTO       L_main51
	DECFSZ     R12+0, 1
	GOTO       L_main51
	DECFSZ     R11+0, 1
	GOTO       L_main51
;MyProject.c,239 :: 		PORTA.f2=0;
	BCF        PORTA+0, 2
;MyProject.c,240 :: 		Delay_ms(140);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      108
	MOVWF      R12+0
	MOVLW      159
	MOVWF      R13+0
L_main52:
	DECFSZ     R13+0, 1
	GOTO       L_main52
	DECFSZ     R12+0, 1
	GOTO       L_main52
	DECFSZ     R11+0, 1
	GOTO       L_main52
	NOP
	NOP
;MyProject.c,241 :: 		PORTA.f2=1;
	BSF        PORTA+0, 2
;MyProject.c,242 :: 		Delay_ms(180);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      212
	MOVWF      R12+0
	MOVLW      133
	MOVWF      R13+0
L_main53:
	DECFSZ     R13+0, 1
	GOTO       L_main53
	DECFSZ     R12+0, 1
	GOTO       L_main53
	DECFSZ     R11+0, 1
	GOTO       L_main53
;MyProject.c,243 :: 		PORTA.f2=0;
	BCF        PORTA+0, 2
;MyProject.c,244 :: 		Delay_ms(470);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      197
	MOVWF      R12+0
	MOVLW      194
	MOVWF      R13+0
L_main54:
	DECFSZ     R13+0, 1
	GOTO       L_main54
	DECFSZ     R12+0, 1
	GOTO       L_main54
	DECFSZ     R11+0, 1
	GOTO       L_main54
	NOP
;MyProject.c,246 :: 		if(fw||PORTB.f1||PORTA.f4)
	MOVF       _fw+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	BTFSC      PORTB+0, 1
	GOTO       L__main64
	BTFSC      PORTA+0, 4
	GOTO       L__main64
	GOTO       L_main57
L__main64:
;MyProject.c,247 :: 		fw=0,flagalarm=0;
	CLRF       _fw+0
	CLRF       _flagalarm+0
L_main57:
;MyProject.c,249 :: 		continue;
	GOTO       L_main42
;MyProject.c,250 :: 		}
L_main50:
;MyProject.c,252 :: 		if(fw)ajust();
	MOVF       _fw+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main58
	CALL       _ajust+0
L_main58:
;MyProject.c,254 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main59:
	DECFSZ     R13+0, 1
	GOTO       L_main59
	DECFSZ     R12+0, 1
	GOTO       L_main59
	DECFSZ     R11+0, 1
	GOTO       L_main59
;MyProject.c,255 :: 		}
	GOTO       L_main42
;MyProject.c,256 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
