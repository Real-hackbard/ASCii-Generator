# ASCii-Generator:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![ASCii Generator](https://github.com/user-attachments/assets/8f1237f2-8f67-40c2-b2e5-af3cf749cdf7)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![012026](https://github.com/user-attachments/assets/ae91e595-2dbf-4d94-b953-81e4fd25dcc3)   
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

With the ASCII Generator, you can convert your images to ASCII. Images can be rendered in Monochrome, full color, or Grayscale. The tool uses all TrueType fonts ([TryTypeFonts](https://en.wikipedia.org/wiki/TrueType)) files installed on your Windows system, as well as the specific font settings.

</br>

![ASCii Commodore](https://github.com/user-attachments/assets/699e04c8-4f60-4ca6-9bb2-41f4ed4e00fb)

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

{..}

// Or each individual RGB channel

{..}

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

The calculated colors must be specified in this section.

```pascal
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
```

</br>

### Have Fun with ASCii !
