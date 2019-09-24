unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
const
g=15;
nn=2000;
kmax=30000;
color=15;
w0=5e13;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    Image1: TImage;
    Edit2: TEdit;
    Label2: TLabel;
    Timer1: TTimer;
    ListBox1: TListBox;
    Memo1: TMemo;
    Label4: TLabel;
    Button2: TButton;
    Edit1: TEdit;
    Edit3: TEdit;
    RadioGroup2: TRadioGroup;
    Edit4: TEdit;
    Label1: TLabel;
    Label5: TLabel;

    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
TRect=record
    top,left,right,bottom: integer;  end;

var
  Form1: TForm1;

vc, ny: integer;
x: array[0..4800] of integer;
x1: array[0..4800] of integer;
Qkt, T, a, q,d3,erfc,c: real;
{key: char;}
gd, gm,i,j,k,maxx,maxy,n1,ik: integer;
s,dt,time, d1,d2: real;
s1,s2,sstr: string;
offon,ss:string;
conce:array [0..5] of real;
y: array[-1..661] of word;
nz: byte;

GistRect: TRect;

implementation

{$R *.dfm}
procedure TForm1.Button2Click(Sender: TObject);
//procedure coef_dif(t,d,ik,c:real);
const
nz=22; a=3.4e-10;
var k1,erf,k3,e,de,xx,dd:real;
i,nn:word;
begin
D1:=strtofloat(edit1.Text);     //edit2 -mistake
D2:=strtofloat(edit3.Text);    // edit2 -mistake

 ik:=3;
  case ListBox1.ItemIndex of
 0:ik:=1;
 1:ik:=2;
 2:ik:=3;
 3:ik:=4;
 end;

 {ik:=3;} c:=  conce[ik];
xx:=(ik+0.5)*nz*a/2;
k1:=2*c;
k3:=xx/2/sqrt(time);
//d1:=1E-14;
//d2:=1E-12;
dd:=abs((d1-d2)/1000);  nn:=0;
d3:=(d1+d2)/2;
while abs(d2-d1)>dd do  //1E-17 do
     begin
     erf:=0;
     e:=k3/sqrt(d3);  // x/aqrt(2Dt)
     de:=e/100;
     for i:=1 to 100 do erf:=erf+exp(-sqr(de*i))*de;
     erf:=erf*2/sqrt(pi);
     erfc:=1-erf;
     if (k1-erfc)>0 then d1:=d3 else d2:=d3;
     d3:=(d1+d2)/2;   inc(nn);
     end;
     //image1.Canvas.TextOut(580,290,' D3 ');
     image1.Canvas.TextOut(520,290+20*ik,floattostrF(d3,ffExponent,5,2));//{*1000000000000},ffFixed,7,6)+' *10^-12');
     image1.Canvas.TextOut(480,290,' D= ');
     image1.Canvas.TextOut(600,310,' erfc ');
     image1.Canvas.TextOut(600,290+20*2,floattostrF(erfc,ffFixed,6,5));
     image1.Canvas.TextOut(600,290+20*3,inttostr(nn));
      edit1.Text:=floattostrF(d1,ffExponent,5,2);
        edit3.Text:=floattostrF(d2,ffExponent,5,2);
end;
 {     con:=conce[j];
     ikaru:=i/nz;

     coef_dif(dt,ikaru,con,d3,erfc);}

            {++++++++++++++++   BUTTON START  ++++++++++++++++++++++}
procedure TForm1.Button1Click(Sender: TObject);
var
 con,ikaru:real;
begin

T:=strtofloat(edit2.Text);
 time:=strtofloat(edit4.Text);

case  RadioGroup2.ItemIndex of
    0: begin  Q:=250800; a:=3.4; end;
    1: begin  Q:=250800; a:=3.4; end;
    2: begin Q:=48070; a:=2.6; end; //T:=325;
    3: begin Q:=80256; a:=3.4; end; //T:=500;


end;


  begin  //found end and delete

  //if tex1=1 then q:=250800; if tex1=1 then a:=3.4E-10;
  //if tex1=2 then q:=205632; if tex1=2 then a:=3.64E-10;
  //if tex1=3 then q:=48070; if tex1=3 then a:=2.6E-10;
  //if tex1=4 then q:=80256; if tex1=4 then a:=3.4E-10;

  Qkt:=q/8.31/T;

 // time:=0;
  ny:=round(nn/15);
  //w=wo*exp(-Q/Rt)*dt=1;
  dt:=exp(Qkt)/w0;//*(k/kmax);

  gd:=0;

  maxy:=maxy div -40;

  if offon='off' then
     begin
     offon:='on';
     timer1.Enabled:=true;
     Button1.caption:='Pause';
     image1.canvas.brush.color:=clWhite;
     image1.Canvas.Rectangle(0,0,image1.Width,image1.Height);
     end
  else
     begin
     offon:='off';
     timer1.Enabled:=false;
    //  if Button2.caption:='Go';
     Button1.caption:='Go';

       { --------------------P R O C E D U R E------------------  }
  for i:= -1 to 661 do y[i]:=0;
  for i:=1 to nn do
    begin
      j:=x[i]+330;
      if j>660 then j:=661;
      if j<0 then j:=-1;
      inc(y[j]);
    end;

  nz:=round(330/15);
  for i:=0 to (660-nz) do
  if i mod nz=0 then
  for j:=1 to nz-1 do
    begin
    y[i]:=y[i]+y[i+j];
    y[i+j]:=0;
    end;

  nz:=round(330/15);

  maxx:=image1.Width;
  maxy:=image1.Height;
  image1.Canvas.Brush.color:=clWhite;  {___________GISTOGRAMA}
  image1.canvas.Rectangle(0,260,maxx,0);
  image1.Canvas.Brush.color:=clYellow;
  for i:=0 to 661 do
  if y[i]>0 then image1.canvas.Rectangle(i,260,i+nz-2,260-y[i]);

                                   {!!!GISTOGRAMA________}
  j:=1;
  for i:=329 to 660-nz do
  if (i mod nz=0) and (j<6) then            { Relative concentration }
     begin
     conce[j]:=y[i]/ny;
     con:=conce[j];
     ikaru:=i/nz;
    // d3:=0;

    // coef_dif(dt,a,ikaru,con);

     image1.Canvas.Brush.Color:=clWhite;
     image1.Canvas.TextOut(450,290,' C ');
     image1.Canvas.TextOut(430,290+20*j,'['+inttostr(j)+']');
     image1.Canvas.TextOut(450,290+20*j,floattostrF(conce[j],ffFixed,6,5));
    // image1.Canvas.TextOut(500,290,' D=D3 ');
     //image1.Canvas.TextOut(500,290+20*j,floattostrF(d3*1000000000000,ffFixed,7,6)+' *10^-12');
    // image1.Canvas.TextOut(600,290,' erfc ');
    // image1.Canvas.TextOut(600,290+20*j,floattostrF(erfc,ffFixed,6,5));

     image1.Canvas.Brush.Color:=clBlue;
     image1.Canvas.Rectangle(i,140,i+nz-2,120);
     image1.Canvas.Brush.Color:=clYellow;
     image1.Canvas.TextOut(i+2,122,' '+inttostr(j)+' ');
     j:=j+1;
     end;

  { --------------------------E N D------------------------  }
  {------------------SEREDNO-KVADRATICHNE-----------------------}
  time:=time+dt;
   edit4.Text:=floattostrF(time,ffExponent,5,2); 
  s:=0;
  n1:=0;
  for i:=1 to nn do
  if x1[i]>-200 then
     begin
     s:=s+(x[i]-x1[i])*(x[i]-x1[i]);
     inc(n1);
     end;
  s:=s/n1;
  image1.Canvas.brush.Color:=clWhite;
  str(s:10:4,sstr);
  image1.Canvas.Pen.Color:=clGreen;
  image1.Canvas.TextOut(10,10,'<x^2>(pixel^2)= '+sstr);
  s:=time*1e3;
  str(s:10:4,sstr);
  image1.Canvas.TextOut(10,30,'time(ms)= '+sstr);
     end;

end;
end;
{++++++++++++++++  EEEENNNNNNDDD Button  ++++++++++++++++++++++WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW}

             {______________________________________________________}

            {_____________________T I M E R___________________________}
procedure TForm1.Timer1Timer(Sender: TObject);
{ -------------VAR PROCEDUR's}
var
j,i:integer;
con, ikaru: real;

{--------------END VAR}
begin
                   {  DRAW PIXELS  }
for i:= 1 to nn do
       begin
       with image1.Canvas do
           begin
           pixels[x[i]+330, round((maxy+1)/2 -(maxy-ny+1)/2+round(i/15)+206)]:= clWhite;

           if random(2)=1 then x[i]:=x[i]+1
           else x[i]:=x[i]-1;
           if x[i]<-330 then x[i]:=-326;

           pixels[x[i]+330, round((maxy+1)/2-(maxy-ny+1)/2+round(i/15)+206)]:= clRed;
           end;
       end;
                   {  eennnddd DRAW PIXELS  }
{ Here we periodically draw our coordinate axis - the pixels paint over it }
if k mod 100=0 then
     begin
       for i:=-g to g do
         begin
           with image1.Canvas do
             begin
             moveto(round(330*i/g)+330,260+2);
             lineto(round(330*i/g)+330,260+4);
             moveto(round(330*i/g)+328,260+6);
             str(i,s1);
             textout(image1.Canvas.PenPos.X , image1.Canvas.PenPos.Y, s1);
             end;
         end;
     end;
k:=k+1;
{    END    }

{    When KMAX wanders, we stop the process and cut the histogram drawing. There will also be a mean square}
if k=kmax then
  begin
  str(kmax,s1);
  s1:='Пройшло '+s1+' блукань';
  timer1.Enabled:=false;
  showmessage(s1);
  offon:='off';
  timer1.Enabled:=false;
  Button1.caption:='Go';

       { --------------------P R O C E D U R E------------------  }
  for i:= -1 to 661 do y[i]:=0;
  for i:=1 to nn do
    begin
      j:=x[i]+330;
      if j>660 then j:=661;
      if j<0 then j:=-1;
      inc(y[j]);
    end;

  nz:=round(330/15);
  for i:=0 to (660-nz) do
  if i mod nz=0 then
  for j:=1 to nz-1 do
    begin
    y[i]:=y[i]+y[i+j];
    y[i+j]:=0;
    end;
  nz:=round(330/15);
  maxx:=image1.Width;
  maxy:=image1.Height;
  image1.Canvas.Brush.color:=clWhite;  {___________GISTOGRAMA}
  image1.canvas.Rectangle(0,260,maxx,0);
  image1.Canvas.Brush.color:=clYellow;
  for i:=0 to 661 do
  if y[i]>0 then image1.canvas.Rectangle(i,260,i+nz-2,260-y[i]);

                                   {!!!GISTOGRAMA________}
  j:=1;
  for i:=329 to 660-nz do
  if (i mod nz=0) and (j<6) then            {Relative concentration}
     begin
     conce[j]:=y[i]/ny;
     con:=conce[j];
     ikaru:=i/nz;
    // d3:=0;

     //coef_dif(dt,a,ikaru,con);

     image1.Canvas.Brush.Color:=clWhite;
     image1.Canvas.TextOut(450,290,' C ');
     image1.Canvas.TextOut(430,290+20*j,'['+inttostr(j)+']');
     image1.Canvas.TextOut(450,290+20*j,floattostrF(conce[j],ffFixed,6,5));

     image1.Canvas.Brush.Color:=clBlue;
     image1.Canvas.Rectangle(i,140,i+nz-2,120);
     image1.Canvas.Brush.Color:=clYellow;
     image1.Canvas.TextOut(i+2,122,' '+inttostr(j)+' ');
     j:=j+1;
     end;

  { --------------------------E N D------------------------  }
  {------------------SEREDNO-KVADRATICHNE-----------------------}
  time:=time+dt;
  s:=0;
  n1:=0;
  for i:=1 to nn do
  if x1[i]>-100 then
     begin
     s:=s+(x[i]-x1[i])*(x[i]-x1[i]);
     inc(n1);
     end;
  s:=s/n1;
  image1.Canvas.brush.Color:=clWhite;
  str(s:10:4,sstr);
  image1.Canvas.Pen.Color:=clGreen;
  image1.Canvas.TextOut(10,10,'<x^2>(pixel^2)= '+sstr);
  s:=time*1e3;
  str(s:10:4,sstr);
  image1.Canvas.TextOut(10,30,'time(ms)= '+sstr);
  end;

end;
{________________________ TIMER END____________________}



//procedure TForm1.Button2Click(Sender: TObject);
//begin
//coef_dif;  // coef_dif(t,d,ik,c)
//TMemo ......
 //end;


procedure TForm1.Button3Click(Sender: TObject);
begin
//Check radiobuton2;
Close();   //Goto
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
k:=0;
offon:='off';  // but2:='no'
for  j:=1 to nn do
     begin
     x[j]:=-random(330){*15};
     x1[j]:=x[j];
     end;
end;

end.

