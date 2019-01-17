#line 1 "C:/Users/1/Desktop/jpeg2000/Michell/Novo michel - Copia/MyProject.c"
sbit LCD_RS at RA0_bit;
sbit LCD_EN at RA1_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISA0_bit;
sbit LCD_EN_Direction at TRISA1_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;



sbit Soft_I2C_Scl at RB2_bit;
sbit Soft_I2C_Sda at RB3_bit;
sbit Soft_I2C_Scl_Direction at TRISB2_bit;
sbit Soft_I2C_Sda_Direction at TRISB3_bit;



char seconds, minutes, hours, day, month, year, diasem;
char fw=0,fx=0,flag,flag1,horalarm[7],minutalarm[7],zi,flagalarm=0,dsq[28];


void interrupt(){
 INTCON.INTF=0;
 fw++,fw%=9;
 }


void le(char i,char j,char k){
 fx=j;
 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 while(fw==k){
 if(PORTB.f1)
 break;
 if(PORTA.f4&&!flag)
 flag1++,fx++,fx%=i,flag++;
 if((!PORTA.f4)&&flag)
 flag=0;
 Lcd_Chr_Cp(fx+48);
 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 Delay_ms(40);
 }
 while(PORTB.f1);
 }


void inic(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(2,4,",   /  /20");
 Lcd_Out(1,6,":  :");
 }


void le2direto(char level,char corte,char *v){
 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 le(10,*v & 0x0F,level);
 *v=(*v & 0xF0)|fx;

 le(corte,*v>>4,level);
 *v=(*v & 0x0F)|(fx<<4);
 }


void ajust(){
 Lcd_Cmd(_LCD_BLINK_CURSOR_ON);

 while(fw==1){
 Lcd_Chr(1,11, (seconds & 0x0F) + 48);
 le(10,seconds & 0x0F,1);
 seconds=(seconds & 0xF0)|fx;

 le(6,seconds>>4,1);
 seconds=(seconds & 0x0F)|(fx<<4);

 le2direto(1,6,&minutes);
 le2direto(1,fx>3?2:3,&hours);

 Lcd_Chr(2,15, (year & 0x0F) + 48);
 le(10,year & 0x0F,1);
 year=(year & 0xF0)|fx;

 le(10,year>>4,1);
 year=(year & 0x0F)|(fx<<4);

 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);

 le2direto(1,fx>2?1:2,&month);
 le2direto(1,4,&day);

 while(fw==1){
 if(PORTB.f1){
 flag1=1;
 break;
 }

 if(PORTA.f4&&!flag)
 flag1++,diasem%=7,diasem++,flag++;

 if((!PORTA.f4)&&flag)
 flag=0;

 Lcd_Out(2, 1,&dsq[(diasem-1)<<2]);

 Delay_ms(10);
 }
 while(PORTB.f1);
 }


 if(flag1){
 flag1=0,fw=0;
 Soft_I2C_Start();
 Soft_I2C_Write(0xD0);
 Soft_I2C_Write(0);
 Soft_I2C_Write(seconds);
 Soft_I2C_Write(minutes);
 Soft_I2C_Write(hours);
 Soft_I2C_Write(diasem);
 Soft_I2C_Write(day);
 Soft_I2C_Write(month);
 Soft_I2C_Write(year);
 Soft_I2C_Stop();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 return;
 }

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,2,"Alarme  :");
 Lcd_Chr(2,6,':');

 for(zi=0;zi<7;zi++){
 Lcd_Chr(1, 9, zi+ 49);
 Lcd_Chr(2, 4, ((horalarm[zi]) >> 4) + 48);
 Lcd_Chr_Cp((horalarm[zi] & 0x0F) + 48);
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 Lcd_Chr_Cp(((minutalarm[zi] & 0x70) >> 4) + 48);
 Lcd_Chr_Cp((minutalarm[zi] & 0x0F) + 48);

 while(fw==(zi+2)){
 Lcd_Chr(2,11, ((minutalarm[zi] & 0x80) >> 7) + 48);
 le(2,(minutalarm[zi]&0x80)>>7,zi+2);
 minutalarm[zi]=(minutalarm[zi] & 0x7F)|(fx<<7);

 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 Lcd_Cmd(_LCD_MOVE_CURSOR_LEFT);
 le(10,minutalarm[zi] & 0x0F,zi+2);
 minutalarm[zi]=(minutalarm[zi] & 0xF0)|fx;

 le(6,(minutalarm[zi]&0x70)>>4,zi+2);
 minutalarm[zi]=(minutalarm[zi] & 0x8F)|(fx<<4);

 le2direto(zi+2,fx>3?2:3,&horalarm[zi]);
 }

 if(flag1){
 flag1=0,fw=0;
 inic();
 }

 }
 inic();
 }


void imp(char q){
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 Lcd_Chr_Cp(((q) >> 4) + 48);
 Lcd_Chr_Cp((q & 0x0F) + 48);
 }


void main() {
 PORTB = 0xFF;
 TRISA = 0xfb;
 TRISB = 0xff;

 CMCON = 0X07;

 dsq[0]=0x44,dsq[1]=0x6f,dsq[2]=0x6d,dsq[3]=0x00,dsq[4]=0x53,dsq[5]=0x65,dsq[6]=0x67,dsq[7]=0x00,dsq[8]=0x54,dsq[9]=0x65,dsq[10]=0x72,dsq[11]=0x00,dsq[12]=0x51,dsq[13]=0x75,dsq[14]=0x61,dsq[15]=0x00,dsq[16]=0x51,dsq[17]=0x75,dsq[18]=0x69,dsq[19]=0x00,dsq[20]=0x53,dsq[21]=0x65,dsq[22]=0x78,dsq[23]=0x00,dsq[24]=0x53,dsq[25]=0x61,dsq[26]=0x62,dsq[27]=0x00;

 for(zi=0;zi<7;zi++)
 horalarm[zi]=0,minutalarm[zi]=0;

 Soft_I2C_Init();
 Lcd_Init();

 INTCON.GIE=1;
 INTCON.PEIE=1;
 INTCON.INTE=1;

 inic();

 while (1) {
 Soft_I2C_Start();
 Soft_I2C_Write(0xD0);
 Soft_I2C_Write(0);
 Soft_I2C_Start();
 Soft_I2C_Write(0xD1);

 seconds = Soft_I2C_Read(1);
 minutes = Soft_I2C_Read(1);
 hours = Soft_I2C_Read(1);
 diasem=Soft_I2C_Read(1);
 day = Soft_I2C_Read(1);
 month = Soft_I2C_Read(1);
 year=Soft_I2C_Read(0);
 Soft_I2C_Stop();

 Lcd_Out(2, 1,&dsq[(diasem-1)<<2]);
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);

 imp(day);
 imp(month);
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 imp(year);

 Lcd_Chr(1, 4, ((hours) >> 4) + 48);
 Lcd_Chr_Cp((hours & 0x0F) + 48);
 imp(minutes);
 imp(seconds);

 for(zi=0;zi<7;zi++)
 if(hours==horalarm[zi]&&!seconds&&(minutes|0x80)==minutalarm[zi])
 flagalarm=1;

 if(flagalarm){
 flagalarm++,flagalarm%21;

 PORTA.f2=1;
 Delay_ms(180);
 PORTA.f2=0;
 Delay_ms(140);
 PORTA.f2=1;
 Delay_ms(180);
 PORTA.f2=0;
 Delay_ms(470);

 if(fw||PORTB.f1||PORTA.f4)
 fw=0,flagalarm=0;

 continue;
 }

 if(fw)ajust();

 Delay_ms(400);
 }
 }
