unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JPEG, ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Menus,
  Bumpmapping, PngImage, GIFImg, ShellApi;

type
  TForm1 = class(TForm)
    FontDialog1: TFontDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    SaveDialog1: TSaveDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    RadioButton3: TRadioButton;
    GroupBox2: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PopupMenu1: TPopupMenu;
    Invert1: TMenuItem;
    FlipX1: TMenuItem;
    FlipY1: TMenuItem;
    Resample1: TMenuItem;
    Highlight1: TMenuItem;
    Blur1: TMenuItem;
    Sepia1: TMenuItem;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    N1: TMenuItem;
    Clear1: TMenuItem;
    N2: TMenuItem;
    Rotate1: TMenuItem;
    BumpMap1: TMenuItem;
    ReloadPicture1: TMenuItem;
    N3: TMenuItem;
    Trz1: TMenuItem;
    N4: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Invert1Click(Sender: TObject);
    procedure FlipX1Click(Sender: TObject);
    procedure FlipY1Click(Sender: TObject);
    procedure Resample1Click(Sender: TObject);
    procedure Highlight1Click(Sender: TObject);
    procedure Blur1Click(Sender: TObject);
    procedure Sepia1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Rotate1Click(Sender: TObject);
    procedure BumpMap1Click(Sender: TObject);
    procedure ReloadPicture1Click(Sender: TObject);
    procedure Trz1Click(Sender: TObject);
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
  XPos: Single;
  YPos: Single;

type      // Resample Bitmap
  PBitmap = ^TBitmap;
  TLine = array[0..MaxInt div SizeOf(TRGBQUAD) - 1] of TRGBQUAD;
  PLine = ^TLine;

type
  TMyhelp = array[0..0] of TRGBQuad;  // Turn Bitnap

implementation

{$R *.dfm}
procedure BitmapFileToPNG(const Source, Dest: String);
var
  Bitmap: TBitmap;
  PNG: TPNGObject;
begin
  Bitmap := TBitmap.Create;
  PNG := TPNGObject.Create;
  {In case something goes wrong, free booth Bitmap and PNG}
  try
    // Load Bitmap File
    Bitmap.LoadFromFile(Source);
    //Convert data into png
    PNG.Assign(Bitmap);

    // Set Png Tranzparent
    if Form1.Trz1.Checked = true then begin
      PNG.TransparentColor := clBlack;
      PNG.Transparent := true;
    end;

    // Create Png Image File
    PNG.SaveToFile(Dest);
  finally
    Bitmap.Free;
    PNG.Free;
  end
end;

function DeleteFile(const AFile: string): boolean;
var
 sh: SHFileOpStruct;
begin
 ZeroMemory(@sh, sizeof(sh));
 with sh do
   begin
   Wnd := Application.Handle;
   wFunc := fo_Delete;
   pFrom := PChar(AFile +#0);
   fFlags := fof_Silent or fof_NoConfirmation;
   end;
 result := SHFileOperation(sh) = 0;
end;

procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := TBitmap.Create;
  Jpg := TJPEGImage.Create;
  try
    // Convert Bitmap to Jpg
    Bmp.LoadFromFile(BmpFileName);
    Jpg.Assign(Bmp);

    // Set JPG Tranzparent
    if Form1.Trz1.Checked = true then begin
      JPG.Transparent := true;
    end;

    // Create Jpg Image File
    Jpg.SaveToFile(JpgFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

procedure LoadPngToBmp(var Dest: TBitmap; AFilename: TFilename);
type
  TRGB32 = packed record
    B, G, R, A : Byte;
  end;
  PRGBArray32 = ^TRGBArray32;
  TRGBArray32 = array[0..0] of TRGB32;
type
  TRG24 = packed record
    rgbtBlue, rgbtGreen, rgbtRed : Byte;
  end;
  PRGBArray24 = ^TPRGBArray24;
  TPRGBArray24 = array[0..0] of TRG24;
type
  TByteArray = Array[Word] of Byte;
  PByteArray = ^TByteArray;
  TPByteArray = array[0..0] of TByteArray;
var
  BMP : TBitmap;
  PNG: TPNGObject;
  x, y: Integer;
  BmpRow: PRGBArray32;
  PngRow : PRGBArray24;
  AlphaRow: PByteArray;
begin
  Bmp := TBitmap.Create;
  PNG := TPNGObject.Create;
  try
    if AFilename <> '' then
    begin
      // Load Png Picture
      PNG.LoadFromFile(AFilename);
      // Set Pixel to 32 Bit
      BMP.PixelFormat := pf32bit;
      // Set Bitmap Dimensions
      BMP.Height := PNG.Height;
      BMP.Width := PNG.Width;

      // Calculate Tranzaprent
      if ( PNG.TransparencyMode = ptmPartial ) then
      begin
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);
          AlphaRow := PByteArray(PNG.AlphaScanline[Y]);

          // Calculate RGB Colors
          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := Byte(AlphaRow[X]);
            end;
          end;
        end;
      end else
      begin
        // Copy Bitmap Pixels to Png Pixels
        for Y := 0 to BMP.Height-1 do
        begin
          BmpRow := PRGBArray32(BMP.ScanLine[Y]);
          PngRow := PRGBArray24(PNG.ScanLine[Y]);

          // Calculate Pixel Dimensions
          for X := 0 to BMP.Width - 1 do
          begin
            with BmpRow[X] do
            begin
              with PngRow[X] do
              begin
                R := rgbtRed; G := rgbtGreen; B := rgbtBlue;
              end;
              A := 255;
            end;
          end;
        end;
      end;
      Dest.Assign(BMP);
    end;
  finally
    Bmp.Free;
    PNG.Free;
  end;
end;

 procedure JpegToBmp(const Filename: String);
 var
  jpeg: TJPEGImage;
  bmp: TBitmap;
 begin jpeg:=TJPEGImage.Create;
   try
   // Load Jpg File
   jpeg.LoadFromFile(Filename);
    bmp:=TBitmap.Create;
     try
      // Copy Picture to Bitmap
      bmp.Assign(jpeg);
      // Save & Convert to Bitmap
      bmp.SaveToFile(ChangeFileExt(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp', '.bmp'));
     finally
      bmp.free;
     end;
   finally
    jpeg.free;
   end;
end;


procedure BitmapDrehen_90Grad(const Bitmap: TBitmap);
var P: PRGBQuad;
    //^THelpRGB;  // When you Calculate RGB New
    x,y,b,h : Integer;
    RowOut: ^TMyHelp;
    help: TBitmap;
begin
  Bitmap.PixelFormat := pf32bit;
  help := TBitmap.Create;
  try
    help.PixelFormat := pf32bit;
    b := bitmap.Height;
    h := bitmap.Width;
    help.Width := b;
    help.height := h;
    // Get Bitmap Pixels
    for y := 0 to (h-1) do
    begin
      rowOut := help.ScanLine[y];
      P  := Bitmap.scanline[bitmap.height-1];
      inc(p,y);
      for x := 0 to (b-1) do
      begin
        rowout[x] := p^;
        inc(p,h);
      end;
    end;
  finally
    bitmap.Assign(help);
  end;
end;

function bmptosepia(const bmp: TBitmap; depth: Integer): Boolean;
var
color,color2:longint;
r,g,b,rr,gg:byte;
h,w:integer;
begin
  Screen.Cursor := crHourGlass;
  for h := 0 to bmp.height do
  begin
    for w := 0 to bmp.width do
    begin
  //first convert the bitmap to greyscale
    color:=colortorgb(bmp.Canvas.pixels[w,h]);
    r:=getrvalue(color);
    g:=getgvalue(color);
    b:=getbvalue(color);
    color2:=(r+g+b) div 3;
    bmp.canvas.Pixels[w,h]:=RGB(color2,color2,color2);
  //then convert it to sepia
    color:=colortorgb(bmp.Canvas.pixels[w,h]);
    r:=getrvalue(color);
    g:=getgvalue(color);
    b:=getbvalue(color);
    rr:=r+(depth*2);
    gg:=g+depth;
    if rr <= ((depth*2)-1) then
    rr:=255;
    if gg <= (depth-1) then
    gg:=255;
    bmp.canvas.Pixels[w,h]:=RGB(rr,gg,b);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure BmpGBlur(Bmp: TBitmap; radius: Single);
Type
  TRGB = Packed Record b, g, r: Byte End;
  TRGBs = Packed Record b, g, r: Single End;
  TRGBArray = Array[0..0] of TRGB;
Var
  MatrixRadius: Byte;
  Matrix : Array[-100..100] of Single;

  Procedure CalculateMatrix;
  Var x: Integer; Divisor: Single;
  Begin
    Screen.Cursor := crHourGlass;
    radius:=radius+1; // der mittel/nullpunkt muss mitgerechnet werden
    MatrixRadius:=Trunc(radius);
    If Frac(radius)=0 Then Dec(MatrixRadius);
    Divisor:=0;
    For x:=-MatrixRadius To MatrixRadius Do Begin
      Matrix[x]:=radius-abs(x);
      Divisor:=Divisor+Matrix[x];
    End;
    For x:=-MatrixRadius To MatrixRadius Do
      Matrix[x]:=Matrix[x]/Divisor;
  End;

Var
  BmpSL : ^TRGBArray;
  BmpRGB : ^TRGB;
  BmpCopy : Array of Array of TRGBs;
  BmpCopyRGB : ^TRGBs;
  R, G, B : Single;
  BmpWidth, BmpHeight: Integer;
  x, y, mx : Integer;
Begin
  Bmp.PixelFormat:=pf24bit;
  If radius<=0 Then radius:=1 Else If radius>99 Then radius:=99; // radius bereich 0 < radius < 99
  CalculateMatrix;
  BmpWidth:=Bmp.Width;
  BmpHeight:=Bmp.Height;
  SetLength(BmpCopy,BmpHeight,BmpWidth);
  // Alle Bildpunkte ins BmpCopy-Array schreiben und gleichzeitig HORIZONTAL blurren
  For y:=0 To Pred(BmpHeight) Do Begin
    BmpSL:=Bmp.Scanline[y];
    BmpCopyRGB:=@BmpCopy[y,0];
    For x:=0 to Pred(BmpWidth) Do Begin
      R:=0; G:=0; B:=0;
      For Mx:=-MatrixRadius To MatrixRadius Do Begin
        If x+mx<0 Then
          BmpRGB:=@BmpSL^[0] // erster Pixel
        Else If x+mx>=BmpWidth Then
          BmpRGB:=@BmpSL^[Pred(BmpWidth)] // letzter Pixel
        Else
          BmpRGB:=@BmpSL^[x+mx];
        B:=B+BmpRGB^.b*Matrix[mx];
        G:=G+BmpRGB^.g*Matrix[mx];
        R:=R+BmpRGB^.r*Matrix[mx];
      End;
      BmpCopyRGB^.b:=B; // Farbwerte werden im Typ Single zwischengespeichert !
      BmpCopyRGB^.g:=G;
      BmpCopyRGB^.r:=R;
      Inc(BmpCopyRGB);
    End;
  End;
  // Alle Bildpunkte zurück ins Bmp-Bitmap schreiben und gleichzeitig VERTIKAL blurren
  For y:=0 To Pred(BmpHeight) Do Begin
    BmpRGB:=Bmp.ScanLine[y];
    For x:=0 to Pred(BmpWidth) Do Begin
      R:=0; G:=0; B:=0;
      For mx:=-MatrixRadius To MatrixRadius Do Begin
        If y+mx<=0 Then
          BmpCopyRGB:=@BmpCopy[0,x] // erster Pixel
        Else If y+mx>=BmpHeight Then
          BmpCopyRGB:=@BmpCopy[Pred(BmpHeight),x] // letzter Pixel
        Else
          BmpCopyRGB:=@BmpCopy[y+mx,x];
        B:=B+BmpCopyRGB^.b*Matrix[mx];
        G:=G+BmpCopyRGB^.g*Matrix[mx];
        R:=R+BmpCopyRGB^.r*Matrix[mx];
      End;
      BmpRGB^.b:=Round(B);
      BmpRGB^.g:=Round(G);
      BmpRGB^.r:=Round(R);
      Inc(BmpRGB);
    End;
  End;
  Screen.Cursor := crDefault;
End;

procedure Highlight(aSource, ATarget: TBitmap; AColor: TColor);
//alters ASource to ATarget by making it appear as if
//looked through
//colored glass as given by AColor
//ASource, ATarget must have been created.
//Isn't as slow as it looks.
//Physics courtesy of a post by K.H. Brenner
var i, j: Integer;
  s, t: pRGBTriple;
  r, g, b: byte;
  cl: TColor;
begin
  Screen.Cursor := crHourGlass;
  cl := ColorToRGB(AColor);
  r := GetRValue(cl);
  g := GetGValue(cl);
  b := GetBValue(cl);
  aSource.PixelFormat := pf24bit;
  ATarget.PixelFormat := pf24bit;
  ATarget.Width := aSource.Width;
  ATarget.Height := aSource.Height;
  for i := 0 to aSource.Height - 1 do
  begin
    s := ASource.Scanline[i];
    t := ATarget.Scanline[i];
    for j := 0 to aSource.Width - 1 do
    begin
      t^.rgbtBlue := (b * s^.rgbtBlue) div 255;
      t^.rgbtGreen := (g * s^.rgbtGreen) div 255;
      t^.rgbtRed := (r * s^.rgbtRed) div 255;
      inc(s);
      inc(t);
    end;
  end;
  Screen.Cursor := crDefault;
end;

function ResampleSubBitmap(Bitmap: TBitmap; XPos, YPos, Width, Height: Integer): TRGBQuad;
var
  r, g, b: Cardinal;
  Line: PLine;
  x, y, z: Integer;
begin
  z := (Width * Height);
  r := 0;
  g := 0;
  b := 0;

  //Grenzüberschreitungen abfangen
  if (YPos + Height) >= Bitmap.Height then Height := (Bitmap.Height - YPos) - 1;
  if (XPos + Width) >= Bitmap.Width then Width := (Bitmap.Width - XPos) - 1;

  //Für jedes Pixel die Werte lesen und aufaddieren
  for y := YPos to YPos + Height do
  begin
    Line := Bitmap.ScanLine[y];
    for x := XPos to XPos + Width do
    begin
      r := r + Line[x].rgbRed;
      g := g + Line[x].rgbGreen;
      b := b + Line[x].rgbBlue;
      Inc(z);
    end;
  end;

  if (z = 0) then z := 1;
  //Mittelwert bestimmen und kleine Helligkeitskorrektur
  r := Round((r / z) * 1.4);
  if (r > 255) then r := 255;
  g := Round((g / z) * 1.4);
  if (g > 255) then g := 255;
  b := Round((b / z) * 1.4);
  if (b > 255) then b := 255;

  Result.rgbRed   := r;
  Result.rgbGreen := g;
  Result.rgbBlue  := b;
end;

function ResampleBitmap(Bitmap: TBitmap; NewWidth, NewHeight: Integer): Boolean;
var
  Temp: TBitmap;
  Line: PLine;
  x, y: Integer;
  Blockheight, Blockwidth: Cardinal;
  BlockPosX, BlockPosY: Single;
  BlockDiffX, BlockDiffY: Single;
  XPos, YPos: Single;
  DiffX, Diffy: Single;
begin
  Screen.Cursor := crHourGlass;
  Result := True;

  //Create working bitmap
  Temp := TBitmap.Create;

  //Everything must be 32 bit
  Bitmap.PixelFormat := pf32Bit;
  Temp.PixelFormat   := pf32Bit;

  //New height of our bitmap
  Temp.Height := NewHeight;
  Temp.Width  := NewWidth;

  //Split the old image into blocks, each of which averages the color
  //of a new pixel
  //Block increment per new pixel
  BlockDiffY := (Bitmap.Height / NewHeight);
  BlockDiffX := (Bitmap.Width / NewWidth);
  //Size of a block
  BlockHeight := Trunc(BlockDiffY);
  BlockWidth  := Trunc(BlockDiffY);

  //Pixel increment in the new image
  DiffX := 1;
  DiffY := 1;

  //Initialize all
  BlockPosY := 0;
  YPos      := 0;
  //Each column
  for y := 0 to NewHeight - 1 do
  begin
    BlockPosX := 0;
    XPos      := 0;
    //Each line
    Line := Temp.ScanLine[Trunc(YPos)];
    for x := 0 to NewWidth - 1 do
    begin
      //From a given block of the old bitmap, calculate the mean value of
      //Determine color
      Line[Trunc(XPos)] := ResampleSubBitmap(Bitmap,
        Round(BlockPosX), Round(BlockPosY), Blockwidth, BlockHeight);

      //One block/pixel further
      BlockPosX := BlockPosX + BlockDiffX;
      XPos      := XPos + DiffX;
    end;
    //One block/pixel further
    BlockPosY := BlockPosY + BlockDiffY;
    YPos      := YPos + DiffY;
  end;
  //Overwrite old bitmap with new one
  Bitmap.Assign(Temp);

  //Share auxiliary bitmap
  Temp.Free;
  Screen.Cursor := crDefault;
end;

procedure MirrorV(AImage: TImage);
var
  lBmp: TBitmap;
begin
  lBmp := TBitmap.Create;
  try
    Screen.Cursor := crHourGlass;
    lBmp.Assign(AImage.Picture.Graphic);
    StretchBlt(lBmp.Canvas.Handle,
                 0,
                 0,
                 lBmp.Width,
                 lBmp.Height,
               lBmp.Canvas.Handle,
                 0,
                 lBmp.Height,
                 lBmp.Width,
                 -lBmp.Height,
               SRCCOPY);

    AImage.Picture.Assign(lBmp);;
  finally
    lBmp.Free;
  end;
  Screen.Cursor := crDefault;
end;

procedure MirrorH(AImage: TImage);
var
  lBmp: TBitmap;
begin
  Screen.Cursor := crHourGlass;
  lBmp := TBitmap.Create;
  try
    lBmp.Assign(AImage.Picture.Graphic);
    StretchBlt(lBmp.Canvas.Handle,
                 0,
                 0,
                 lBmp.Width,
                 lBmp.Height,
               lBmp.Canvas.Handle,
                 lBmp.Width,
                 0,
                -lBmp.Width,
                 lBmp.Height,
               SRCCOPY);

    AImage.Picture.Assign(lBmp);;
  finally
    lBmp.Free;
  end;
  Screen.Cursor := crDefault;
end;

 function InvertBitmap(MyBitmap: TBitmap): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
begin
  MyBitmap.PixelFormat := pf24Bit;
  for y := 0 to MyBitmap.Height - 1 do
  begin
    ByteArray := MyBitmap.ScanLine[y];
    for x := 0 to MyBitmap.Width * 3 - 1 do
    begin
      ByteArray[x] := 255 - ByteArray[x];
    end;
  end;
  Result := MyBitmap;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure TForm1.Blur1Click(Sender: TObject);
begin
  BmpGBlur(Image1.Picture.Bitmap, 1);
  Image1.Invalidate;
end;

procedure TForm1.BumpMap1Click(Sender: TObject);
begin
  // Load Bumpmapping RGB functions
  Bump_Init(Image1.Picture.Bitmap, SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value);
  //Position des Lichtpunktes ändern
  XPos := XPos + 0.02;
  YPos := YPos + 0.01;

  //Limit to 2Pi
  if (XPos > 2 * PI) then XPos := XPos - 2 * PI;
  if (YPos > 2 * PI) then YPos := YPos - 2 * PI;

  //And spend
  with Image1.Picture do
    Bump_Do(Bitmap,
      trunc(Sin(XPos) * (Bitmap.Width shr 1) + (Bitmap.Width shr 1)),
      trunc(Sin(YPos) * (Bitmap.Height shr 1) + (Bitmap.Height shr 1))
      )
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Bitmap : TBitmap;
begin
   OpenDialog1.Filter := 'Picture (*.BMP; *.JPG; *.PNG; *.GIF)|*.bmp;*.jpg;*.png;*.gif';

   if OpenDialog1.Execute then begin

    // Load Bitmap File
    if ExtractFileExt(OpenDialog1.FileName) = '.bmp' then begin
      try
        Picture.LoadFromFile(OpenDialog1.FileName);
        Image1.Picture.Bitmap.Width  := Picture.Width;
        Image1.Picture.Bitmap.Height := Picture.Height;
        Image1.Picture.Bitmap.PixelFormat := pf24Bit;
        Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
        StatusBar1.Panels[1].Text := 'X-' + IntToStr(Image1.Height) + ' - ' +
                                     'Y-' + IntToStr(Image1.Width);

        StatusBar1.Panels[3].Text := ExtractFileExt(OpenDialog1.FileName);
        StatusBar1.Panels[5].Text := ExtractFileName(OpenDialog1.FileName);
        // Create Backup File
        Image1.Picture.Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        Trz1.Checked := false;
      except
      end;
    end;

    // Load & Convert Jpg File to Bitmap
    if ExtractFileExt(OpenDialog1.FileName) = '.jpg' then begin
      try
        Image1.Picture.Bitmap.Width  := Picture.Width;
        Image1.Picture.Bitmap.Height := Picture.Height;
        Image1.Picture.Bitmap.PixelFormat := pf24Bit;
        Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
        StatusBar1.Panels[3].Text := ExtractFileExt(OpenDialog1.FileName);
        StatusBar1.Panels[5].Text := ExtractFileName(OpenDialog1.FileName);
        // Convert Jpg to Bitmap File
        JpegToBmp(OpenDialog1.Filename);
        // Load Bitmap Backup to Image
        Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        StatusBar1.Panels[1].Text := 'X-' + IntToStr(Image1.Height) + ' - ' +
                                     'Y-' + IntToStr(Image1.Width);
        Trz1.Checked := false;
      except
      end;
    end;

    // Load & Convert Png File to Bitmap
    if ExtractFileExt(OpenDialog1.FileName) = '.png' then begin
      try
        Bitmap := TBitmap.Create;
        // Convert Png to Bitmap Image
        LoadPngToBmp(Bitmap, OpenDialog1.FileName);
        // Save Png Picture Pixel to Bitmap
        Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');

        Image1.Picture.Bitmap.Width  := Picture.Width;
        Image1.Picture.Bitmap.Height := Picture.Height;
        Image1.Picture.Bitmap.PixelFormat := pf24Bit;
        Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
        StatusBar1.Panels[3].Text := ExtractFileExt(OpenDialog1.FileName);
        StatusBar1.Panels[5].Text := ExtractFileName(OpenDialog1.FileName);

        // Load Bitmap Backup to Image
        Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        Picture.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        StatusBar1.Panels[1].Text := 'X-' + IntToStr(Image1.Height) + ' - ' +
                                     'Y-' + IntToStr(Image1.Width);
        Trz1.Checked := false;
      except
      end;
    end;

    // Load Gif File
    if ExtractFileExt(OpenDialog1.FileName) = '.gif' then begin
      try
        Picture.LoadFromFile(OpenDialog1.FileName);
        Image1.Picture.Bitmap.Width  := Picture.Width;
        Image1.Picture.Bitmap.Height := Picture.Height;
        Image1.Picture.Bitmap.PixelFormat := pf24Bit;
        Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
        StatusBar1.Panels[1].Text := 'X-' + IntToStr(Image1.Height) + ' - ' +
                                     'Y-' + IntToStr(Image1.Width);

        StatusBar1.Panels[3].Text := ExtractFileExt(OpenDialog1.FileName);
        StatusBar1.Panels[5].Text := ExtractFileName(OpenDialog1.FileName);
        // Create Backup File
        Image1.Picture.Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
        Trz1.Checked := false;
      except
      end;
    end;
   END;
   StatusBar1.SetFocus;
end;

procedure TForm1.FlipX1Click(Sender: TObject);
begin
  MirrorH(Image1);
end;

procedure TForm1.FlipY1Click(Sender: TObject);
begin
  MirrorV(Image1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;
  aFont := TFont.Create;

  bmp := TBitmap.Create;
  Picture := TPicture.Create;


  FontDialog1.Font.Name := 'Terminal';
  FontDialog1.Font.Size := 5;
  // Load Fonts
  aFont.Assign(FontDialog1.Font);
end;

procedure TForm1.Highlight1Click(Sender: TObject);
var
  Img : TImage;
begin
  try
    // Create Image
    Img := TImage.Create(self);
    // Copy Image in TImage Component
    Img.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
    // Change Color to Highlight
    Highlight(Img.Picture.Bitmap, Image1.Picture.Bitmap, clSilver);
  finally
    Image1.Invalidate;
    Img.Free;
  end;
end;

procedure TForm1.Invert1Click(Sender: TObject);
begin
  // Invert Image
  Image1.Picture.Bitmap := InvertBitmap(Image1.Picture.Bitmap);
  Image1.Refresh;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Button2.Click;
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Button2.Click;
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  Button2.Click;
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  Button2.Click;
end;

procedure TForm1.ReloadPicture1Click(Sender: TObject);
begin
  Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                         'Data\temp\_temp.bmp');
end;

procedure TForm1.Resample1Click(Sender: TObject);
begin
  // Resample Image
  ResampleBitmap(Image1.Picture.Bitmap, Image1.Picture.Bitmap.Width,
                 Image1.Picture.Bitmap.Height);
end;

procedure TForm1.Rotate1Click(Sender: TObject);
begin
  BitmapDrehen_90Grad(Image1.Picture.Bitmap);
end;

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  Result := R + G shl 8 + B shl 16;
end;

procedure TForm1.Sepia1Click(Sender: TObject);
begin
  // Calculate Sepia Effect to Image
  bmptosepia(image1.picture.bitmap, 10);
  Image1.Invalidate;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  R, G, B: Byte;
  i : integer;
begin
  // Select Font Color TColor zo RGB
  if ColorDialog1.Execute then begin
    for i := 0 to 4 do begin
    RadioGroup1.Buttons[i].Checked := false;
    end;

    TColor2RGB(ColorDialog1.Color, r, g, b);
    SpinEdit1.Value := R;
    SpinEdit2.Value := G;
    SpinEdit3.Value := B;
    Shape1.Brush.Color := ColorDialog1.Color;
    Button2.Click;
  end;
end;

procedure TForm1.Trz1Click(Sender: TObject);
begin
  Trz1.Checked := not Trz1.Checked;
  Button2.Click;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FntH, FntW: Integer;
  MaxCharH, MaxCharW: Integer;
  X, Y, nx, ny: Integer;
  aColor: TColor;
  c: Byte;

  // Main Color Calculation for (RGB)
function CalcGrayValue(Color: Cardinal): byte;
  var c: TRGBTRIPLE; // h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color);
    c.rgbtGreen := GetGValue(Color);
    c.rgbtBlue  := GetBValue(Color);
    Result := round((c.rgbtRed + c.rgbtGreen + c.rgbtBlue) / 3);
  end;

  // Calculate Red (R) for Select TColor
function CalcRed(Color: Cardinal): byte;      // red
var c: TRGBTRIPLE;  h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color); c.rgbtGreen := GetGValue(Color);
    c.rgbtBlue  := GetBValue(Color);
    h := HiByte(c.rgbtRed * SpinEdit1.Value + c.rgbtGreen * 0 + c.rgbtBlue * 0);
    Result := RGB(h + Round((c.rgbtRed - h) / 255),
                  h + Round((c.rgbtGreen - h) / 255),
                  h + Round((c.rgbtBlue - h) / 255));
end;

  // Calculate Green (G) for Select TColor
function CalcGreen(Color: Cardinal): byte;     // green
var c: TRGBTRIPLE;  h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color); c.rgbtGreen := GetGValue(Color);
    c.rgbtBlue  := GetBValue(Color);
    h := HiByte(c.rgbtRed * 0 + c.rgbtGreen * SpinEdit2.Value + c.rgbtBlue * 0);
    Result := RGB(h + Round((c.rgbtRed - h) / 255),
                  h + Round((c.rgbtGreen - h) / 255),
                  h + Round((c.rgbtBlue - h) / 255));
end;

  // Calculate Blue (B) for Select TColor
function CalcBlue(Color: Cardinal): byte;     // blue
var c: TRGBTRIPLE;  h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color); c.rgbtGreen := GetGValue(Color);
    c.rgbtBlue  := GetBValue(Color);
    h := HiByte(c.rgbtRed * 0 + c.rgbtGreen * 0 + c.rgbtBlue * SpinEdit3.Value);
    Result := RGB(h + Round((c.rgbtRed - h) / 255),
                  h + Round((c.rgbtGreen - h) / 255),
                  h + Round((c.rgbtBlue - h) / 255));
end;

begin
  Screen.Cursor := crHourGlass;
  // Set Dimension to Image
  Image1.Picture.Bitmap.Width  := Picture.Width;
  Image1.Picture.Bitmap.Height := Picture.Height;
  Image1.Picture.Bitmap.PixelFormat := pf24Bit;

  // Tranzparent Image
  if Trz1.Checked = true then begin
    Image1.Transparent := true;
    // Tranzparent Color for Bitmap is Black
    bmp.TransparentColor := clBlack;
    bmp.Transparent := true;
    end else begin
    Image1.Transparent := false;
    bmp.Transparent := false;
  end;

  // Draw Picture to Image
  Image1.Picture.Bitmap.Canvas.Draw(0, 0, Picture.Graphic);
  bmp.Width       := Image1.Picture.Width;
  bmp.Height      := Image1.Picture.Height;
  // Best Pixel Format is 24 Bit
  bmp.PixelFormat := pf24Bit;
  bmp.Canvas.Brush.Style := bsSolid;
  // Background Color
  bmp.Canvas.Brush.Color := clBlack;
  // Copy Image Color to TBitmap
  bmp.Canvas.FillRect(RECT(0,0,bmp.Width,bmp.Height));
  bmp.Canvas.Brush.Style := bsClear;
  // Copy Font Set to TBitmap
  bmp.Canvas.Font := aFont;

  With Image1.Picture.Bitmap do
  begin
    Canvas.Font.Assign(aFont);
    FntH := Canvas.TextHeight('X');
    FntW := Canvas.TextWidth('X');
    MaxCharH := (Height-1) div FntH;
    MaxCharW := (Width-1) div FntW;
    c := 1;
    nx := 0; ny := 0; for y := 0 to MaxCharH do
    begin  for x := 0 to MaxCharW do
      begin
      // Copy Generate Pixels onto TBitmap
      aColor := Canvas.Pixels[nx, ny];

          // Calcualte Colors
         Case RadioGroup1.ItemIndex of
          0: bmp.Canvas.Font.Color := RGB(CalcGrayValue(aColor), 0, 0); // Red
          1: bmp.Canvas.Font.Color := RGB(0, CalcGrayValue(aColor), 0); // Green
          2: bmp.Canvas.Font.Color := RGB(0, 0, CalcGrayValue(aColor)); // Blue
          3: bmp.Canvas.Font.Color := RGB(CalcGrayValue(aColor), CalcGrayValue(aColor), CalcGrayValue(aColor));
          4: bmp.Canvas.Font.Color := aColor; // Calculate RGB Complete to Font
        end;

        // Calculate Individuall TColor to RGB on Font
        if (RadioGroup1.Buttons[0].Checked = false) and
           (RadioGroup1.Buttons[1].Checked = false) and
           (RadioGroup1.Buttons[2].Checked = false) and
           (RadioGroup1.Buttons[3].Checked = false) and
           (RadioGroup1.Buttons[4].Checked = false) then begin
            bmp.Canvas.Font.Color := RGB(CalcRed(aColor),
                                     CalcGreen(aColor),
                                     CalcBlue(aColor));
          end;

          // ASCii Art
          if RadioButton1.Checked = true then begin  // ASCii
            bmp.Canvas.TextOut(nx, ny, CHR( Ord('0') + Random(2) ));
            bmp.Canvas.TextOut(nx, ny, CHR( Ord('!') + Random(65) ));
          end;

          // Binary Art
          if RadioButton2.Checked = true then begin  // Binary
            bmp.Canvas.TextOut(nx, ny, CHR( Ord('0') + Random(2) ));
          end;

          // Custom Char Art
          if RadioButton3.Checked = true then begin   // Char
            if c < length(Edit1.Text) then inc(c)
            else
            c := 1;
            bmp.Canvas.TextOut(nx, ny, Edit1.Text[c] );
          end;

          inc(nx, FntW);
      end;
      inc(ny, FntH);
      nx := 0; end;
  end;
  Image1.Picture.Bitmap.Assign(bmp);
  Image1.Invalidate;
  Screen.Cursor := crDefault;
  StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 if FontDialog1.Execute then begin
   aFont.Assign(FontDialog1.Font);
   StatusBar1.Panels[7].Text := FontDialog1.Font.Name;
   StatusBar1.Panels[9].Text := IntToStr(FontDialog1.Font.Size);
   Button2.Click;
 end;

 StatusBar1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  GIF: TGIFImage;
  Ext: TGIFGraphicControlExtension;
  Bitmap : TBitmap;
begin
  if SaveDialog1.Execute then begin

    // Create Bitmap Image File
    if SaveDialog1.FilterIndex = 1 then begin
      Image1.Picture.SaveToFile(SaveDialog1.FileName + '.bmp');
    end;

    // Create Jpg Image File
    if SaveDialog1.FilterIndex = 2 then begin
      try
        Image1.Picture.SaveToFile(SaveDialog1.FileName + '.bmp');
        Bmp2Jpeg(SaveDialog1.FileName + '.bmp', SaveDialog1.FileName + '.jpg');
        DeleteFile(SaveDialog1.FileName + '.bmp');
      except
      end;
    end;

    // Create Png Image File
    if SaveDialog1.FilterIndex = 3 then begin
      try
        Image1.Picture.SaveToFile(SaveDialog1.FileName + '.bmp');
        BitmapFileToPNG(SaveDialog1.FileName + '.bmp', SaveDialog1.FileName + '.png');
        DeleteFile(SaveDialog1.FileName + '.bmp');
      except
      end;
    end;

    // Create Gif Image File
    if SaveDialog1.FilterIndex = 4 then begin
      GIF := TGIFImage.Create;
      try
        GIF := TGIFImage.Create;
        Bitmap := TBitmap.Create;

        Image1.Picture.SaveToFile(SaveDialog1.FileName + '.bmp');
        Bitmap.LoadFromFile(SaveDialog1.FileName + '.bmp');

        // Convert bitmap to GIF
        GIF.Assign(Bitmap);

        // Create an extension to set the transparency flag
        if Trz1.Checked = true then begin
          Ext := TGIFGraphicControlExtension.Create(GIF.Images[0]);
          Ext.Transparent := True;
          // Set transparent color to lower left pixel color
          Ext.TransparentColorIndex := GIF.Images[0].Pixels[0, GIF.Height-1];
        end;

        // Set transparent color to lower left pixel color
        //Ext.TransparentColorIndex := GIF.Images[0].Pixels[0, GIF.Height-1];

        GIF.SaveToFile(SaveDialog1.FileName + '.gif');
        DeleteFile(SaveDialog1.FileName + '.bmp');
      finally
      GIF.Free;
      Bitmap.Free;
      end;
    end;

  END;
  StatusBar1.SetFocus;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  Trz1.Checked := false;
  Image1.Invalidate;
end;

end.
