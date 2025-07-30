unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JPEG, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FontDialog1: TFontDialog;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    Bevel1: TBevel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    Picture: TPicture;
    aFont: TFont;
    bmp: TBitmap;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    Picture.LoadFromFile('test.bmp');
    Image1.Picture.Bitmap.Width  := Picture.Width;
    Image1.Picture.Bitmap.Height := Picture.Height;
    Image1.Picture.Bitmap.PixelFormat := pf24Bit;
    Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE; aFont := TFont.Create; bmp := TBitmap.Create;
  Picture := TPicture.Create;
  FontDialog1.Font.Name := 'Terminal';
  FontDialog1.Font.Size := 5;
  aFont.Assign(FontDialog1.Font);
end;

procedure TForm1.Button2Click(Sender: TObject);
var FntH, FntW: Integer; MaxCharH, MaxCharW: Integer; X, Y, nx, ny: Integer;
  aColor: TColor; //c: Byte;
function CalcGrayValue(Color: Cardinal): byte;
  var c: TRGBTRIPLE; // h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color);
    c.rgbtGreen := GetGValue(Color); c.rgbtBlue  := GetBValue(Color);
    Result := round((c.rgbtRed + c.rgbtGreen + c.rgbtBlue) / 3);
  end;

begin
  Image1.Picture.Bitmap.Width  := Picture.Width;
  Image1.Picture.Bitmap.Height := Picture.Height;
  Image1.Picture.Bitmap.PixelFormat := pf24Bit;
  Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
  bmp.Width       := Image1.Picture.Width;
  bmp.Height      := Image1.Picture.Height;
  bmp.PixelFormat := pf24Bit;
  bmp.Canvas.Brush.Style := bsSolid;
  bmp.Canvas.Brush.Color := clBlack;
  bmp.Canvas.FillRect(RECT(0,0,bmp.Width,bmp.Height));
  bmp.Canvas.Brush.Style := bsClear;
  bmp.Canvas.Font := aFont;
  With Image1.Picture.Bitmap do
  begin Canvas.Font.Assign(aFont);
    FntH := Canvas.TextHeight('X'); FntW := Canvas.TextWidth('X');
    MaxCharH := (Height-1) div FntH; MaxCharW := (Width-1) div FntW;
    //c := 1;
    nx := 0; ny := 0; for y := 0 to MaxCharH do
    begin  for x := 0 to MaxCharW do
      begin aColor := Canvas.Pixels[nx, ny];

         Case RadioGroup1.ItemIndex of
          0: bmp.Canvas.Font.Color := RGB(CalcGrayValue(aColor), 0, 0);
          1: bmp.Canvas.Font.Color := aColor;
        end;


          //bmp.Canvas.Font.Color := RGB(0, CalcGrayValue(aColor), 0);
          //bmp.Canvas.Font.Color := aColor;

          bmp.Canvas.TextOut(nx, ny, CHR( Ord('0') + Random(2) ));
          bmp.Canvas.TextOut(nx, ny, CHR( Ord('!') + Random(65) ));
        inc(nx, FntW); end; inc(ny, FntH); nx := 0; end;
  end;
  Image1.Picture.Bitmap.Assign(bmp); Image1.Invalidate;
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
 if FontDialog1.Execute then aFont.Assign(FontDialog1.Font);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin


    Image1.Picture.SaveToFile('test2.bmp');
end;

end.
