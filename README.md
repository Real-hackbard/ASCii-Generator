# ASCii-Generator:

</br>

```ruby
Compiler    : Delphi10 Seattle, 10.1 Berlin, 10.2 Tokyo, 10.3 Rio, 10.4 Sydney, 11 Alexandria, 12 Athens
Components  : GIFImg.pas, PNGImage.pas, Bumpmapping.pas
Discription : Generate Image to ASCii Images
Last Update : 10/2025
License     : Freeware
```

</br>


With the ASCII Generator, you can convert your images to ASCII. Images can be rendered in Monochrome, full color, or Grayscale. The tool uses all TrueType fonts ([TryTypeFonts](https://en.wikipedia.org/wiki/TrueType)) files installed on your Windows system, as well as the specific font settings.

</br>

![ASCii Generator_c64](https://github.com/user-attachments/assets/53a86363-c673-4d86-8ae0-9545734279a0)

</br>

TrueType was known during its development stage, first by the codename "Bass" and later on by the codename "Royal". The system was developed and eventually released as TrueType with the launch of [Mac System 7](https://en.wikipedia.org/wiki/System_7) in May 1991. The initial TrueType outline fonts, four-weight families of Times Roman, Helvetica, Courier, and the pi font "Symbol" replicated the original PostScript fonts of the Apple LaserWriter. Apple also replaced some of their [Bitmap Fonts](https://en.wikipedia.org/wiki/Computer_font#BITMAP) used by the graphical user-interface of previous Macintosh System versions (including Geneva, Monaco and New York) with scalable TrueType outline-fonts. For compatibility with older systems, Apple shipped these fonts, a TrueType [Extension](https://en.wikipedia.org/wiki/Extension_(Mac_OS)) and a TrueType-aware version of [Font/DA](https://en.wikipedia.org/wiki/Typography_of_Apple_Inc.) Mover for [System 6](https://en.wikipedia.org/wiki/System_6). For compatibility with the Laserwriter II, Apple developed fonts like ITC Bookman and ITC Chancery in TrueType format.

### Features:
* Import Formats (*.BMP; *.JPG); *.PNG; *.GIF)
* Export Formats (*.BMP; *.JPG); *.PNG; *.GIF)
* Load System TTF Files
* Select TColors
* Set RGB Colors
* [Bumpmap](https://en.wikipedia.org/wiki/Bump_mapping) (RGB) on Image
* [Invert](https://en.wikipedia.org/wiki/Negative_(photography)) Image
* [Highlight](https://en.wikipedia.org/wiki/Clipping_(photography)) Image
* [Sepia](https://en.wikipedia.org/wiki/Photographic_print_toning) Effect (10%)
* [Resample](https://en.wikipedia.org/wiki/Image_scaling) Image (1%)
* [Blur](https://en.wikipedia.org/wiki/Gaussian_blur) (1%)
* Flip Image (X, Y)
* Rotate Image 90°
* Export Tranzparent Images
* Select Custom ASCii Term

</br>

### Colors:
The various color calculations are somewhat more complex than with a single primary color. Here, both the entire RGB color set and each individual RGB channel can be defined, in all possible colors.

The colors can be modified as desired.
```pascal
// The entire RGB output.
// Main Color Calculation for (RGB)
function CalcGrayValue(Color: Cardinal): byte;
  var c: TRGBTRIPLE; // h: Byte;
  begin
    c.rgbtRed   := GetRValue(Color);
    c.rgbtGreen := GetGValue(Color);
    c.rgbtBlue  := GetBValue(Color);
    Result := round((c.rgbtRed + c.rgbtGreen + c.rgbtBlue) / 3);
  end;

Or each individual RGB channel

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
```


