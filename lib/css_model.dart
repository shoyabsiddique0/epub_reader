import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CssModel {
  String? after; //after
  Alignment? alignmemt; //align-item
  Color? backgroundColor;
  String? before;
  Border? border;
  Color? color;
  Map? counterIncrement;
  Map? counterReset;
  TextDirection? direction;
  Display? display;
  String? fontFamily;
  List? fontFamilyFallback;
  List? fontFeatureSettings;
  FontSize? fontSize;
  FontStyle? fontStyle;
  FontWeight? fontWeight;
  Height? height;
  int? letterSpacing;
  LineHeight? lineHeight;
  ListStyleImage? listStyleImage;
  ListStylePosition? listStylePosition;
  ListStyleType? listStyleType;
  Margin? margin;
  Marker? marker;
  int? maxLines;
  HtmlPadding? padding;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
  Color? textDecorationColor;
  TextDecorationStyle? textDecorationStyle;
  int? textDecorationThickness;
  TextOverflow? textOverflow;
  List? textShadow;
  TextTransform? textTransform;
  VerticalAlign? verticalAlign;
  WhiteSpace? whiteSpace;
  Width? width;
  int? wordSpacing;
  CssModel({
    this.after,
    this.alignmemt,
    this.backgroundColor,
    this.before,
    this.border,
    this.color,
    this.counterIncrement,
    this.counterReset,
    this.direction,
    this.display,
    this.fontFamily,
    this.fontFamilyFallback,
    this.fontFeatureSettings,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.height,
    this.letterSpacing,
    this.lineHeight,
    this.listStyleImage,
    this.listStylePosition,
    this.listStyleType,
    this.margin,
    this.marker,
    this.maxLines,
    this.padding,
    this.textAlign,
    this.textDecoration,
    this.textDecorationColor,
    this.textDecorationStyle,
    this.textDecorationThickness,
    this.textOverflow,
    this.textShadow,
    this.textTransform,
    this.verticalAlign,
    this.whiteSpace,
    this.width,
    this.wordSpacing,
  });

  CssModel copyWith({
    String? after,
    Alignment? alignmemt,
    Color? backgroundColor,
    String? before,
    Border? border,
    Color? color,
    Map? counterIncrement,
    Map? counterReset,
    TextDirection? direction,
    Display? display,
    String? fontFamily,
    List? fontFamilyFallback,
    List? fontFeatureSettings,
    FontSize? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Height? height,
    int? letterSpacing,
    LineHeight? lineHeight,
    ListStyleImage? listStyleImage,
    ListStylePosition? listStylePosition,
    ListStyleType? listStyleType,
    Margin? margin,
    Marker? marker,
    int? maxLines,
    HtmlPadding? padding,
    TextAlign? textAlign,
    TextDecoration? textDecoration,
    Color? textDecorationColor,
    TextDecorationStyle? textDecorationStyle,
    int? textDecorationThickness,
    TextOverflow? textOverflow,
    List? textShadow,
    TextTransform? textTransform,
    VerticalAlign? verticalAlign,
    WhiteSpace? whiteSpace,
    Width? width,
    int? wordSpacing,
  }) {
    return CssModel(
      after: after ?? this.after,
      alignmemt: alignmemt ?? this.alignmemt,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      before: before ?? this.before,
      border: border ?? this.border,
      color: color ?? this.color,
      counterIncrement: counterIncrement ?? this.counterIncrement,
      counterReset: counterReset ?? this.counterReset,
      direction: direction ?? this.direction,
      display: display ?? this.display,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontFeatureSettings: fontFeatureSettings ?? this.fontFeatureSettings,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      height: height ?? this.height,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      lineHeight: lineHeight ?? this.lineHeight,
      listStyleImage: listStyleImage ?? this.listStyleImage,
      listStylePosition: listStylePosition ?? this.listStylePosition,
      listStyleType: listStyleType ?? this.listStyleType,
      margin: margin ?? this.margin,
      marker: marker ?? this.marker,
      maxLines: maxLines ?? this.maxLines,
      padding: padding ?? this.padding,
      textAlign: textAlign ?? this.textAlign,
      textDecoration: textDecoration ?? this.textDecoration,
      textDecorationColor: textDecorationColor ?? this.textDecorationColor,
      textDecorationStyle: textDecorationStyle ?? this.textDecorationStyle,
      textDecorationThickness:
          textDecorationThickness ?? this.textDecorationThickness,
      textOverflow: textOverflow ?? this.textOverflow,
      textShadow: textShadow ?? this.textShadow,
      textTransform: textTransform ?? this.textTransform,
      verticalAlign: verticalAlign ?? this.verticalAlign,
      whiteSpace: whiteSpace ?? this.whiteSpace,
      width: width ?? this.width,
      wordSpacing: wordSpacing ?? this.wordSpacing,
    );
  }

  Map<String, CssModel> mapCssToModel(
      Map<String, Map<String, String>> cssData) {
    Map<String, CssModel> resultMap = {};
    cssData.forEach((key, value) {
      CssModel cssModel = CssModel();
      value.forEach((key, value) {
        if (key == "after") {
          cssModel.after = value;
        }
        if (key == "before") {
          cssModel.before = value;
        }
        if (key == "align-content") {
          if (value == "center") {
            cssModel.alignmemt = Alignment.center;
          }
          if (value == "flex-start") {
            cssModel.alignmemt = Alignment.centerLeft;
          }
          if (value == "flex-end") {
            cssModel.alignmemt = Alignment.centerRight;
          }
          if (value == "baseline") {
            cssModel.alignmemt = Alignment.bottomCenter;
          }
        }
        if (key == "background-color") {
          cssModel.backgroundColor = parseCssColor(value);
        }
        if (key == "border") {
          cssModel.border = parseCssBorder(value);
        }
        if (key == "color") {
          cssModel.color = parseCssColor(value);
        }
        if (key == "direction") {
          if (value == "ltr") {
            cssModel.direction = TextDirection.ltr;
          }
          if (value == "rtl") {
            cssModel.direction = TextDirection.rtl;
          }
        }
        if (key == "display") {
          if (value == "block") {
            cssModel.display = Display.block;
          }
          if (value == "inline") {
            cssModel.display = Display.inline;
          }
          if (value == "inline-block") {
            cssModel.display = Display.inlineBlock;
          }
          if (value == "list-item") {
            cssModel.display = Display.listItem;
          }
        }
        if (key == "font-size") {
          if (value == "medium") {
            cssModel.fontSize = FontSize.medium;
          }
          if (value == "xx-small") {
            cssModel.fontSize = FontSize.xxSmall;
          }
          if (value == "x-small") {
            cssModel.fontSize = FontSize.xSmall;
          }
          if (value == "small") {
            cssModel.fontSize = FontSize.small;
          }
          if (value == "large") {
            cssModel.fontSize = FontSize.large;
          }
          if (value == "x-large") {
            cssModel.fontSize = FontSize.xLarge;
          }
          if (value == "xx-large") {
            cssModel.fontSize = FontSize.xxLarge;
          }
          if (value == "larger") {
            cssModel.fontSize = FontSize.larger;
          }
          if (value == "smaller") {
            cssModel.fontSize = FontSize.smaller;
          }
          if (value.contains(RegExp(r'\d'))) {
            if (value.contains("%")) {
              double size = double.parse(value.substring(0, value.length - 1));
              cssModel.fontSize = FontSize(size, Unit.percent);
            }
            if (value.contains("rem")) {
              double size = double.parse(value.substring(0, value.length - 3));
              cssModel.fontSize = FontSize(size, Unit.rem);
            }
            String unit = value.substring(value.length - 2);
            double size = double.parse(value.substring(0, value.length - 2));
            cssModel.fontSize = FontSize(
                size,
                unit == "px"
                    ? Unit.px
                    : unit == "em"
                        ? Unit.em
                        : Unit.auto);
          }
        }
        if (key == "font-style") {
          if (value == "normal") {
            cssModel.fontStyle = FontStyle.normal;
          } else if (value == "italic") {
            cssModel.fontStyle = FontStyle.italic;
          } else {
            cssModel.fontStyle = FontStyle.normal;
          }
        }
        if (key == "font-weight") {
          if (value == "normal") {
            cssModel.fontWeight = FontWeight.normal;
          }
          if (value == "bold") {
            cssModel.fontWeight = FontWeight.bold;
          }
          if (value == "bolder") {
            cssModel.fontWeight = FontWeight.w800;
          }
          if (value == "lighter") {
            cssModel.fontWeight = FontWeight.w300;
          }
          if (value.contains(RegExp(r'\d'))) {
            var weight = int.parse(value);
            if (weight == 100) {
              cssModel.fontWeight = FontWeight.w100;
            } else if (weight == 200) {
              cssModel.fontWeight = FontWeight.w200;
            } else if (weight == 300) {
              cssModel.fontWeight = FontWeight.w300;
            } else if (weight == 400) {
              cssModel.fontWeight = FontWeight.w400;
            } else if (weight == 500) {
              cssModel.fontWeight = FontWeight.w500;
            } else if (weight == 600) {
              cssModel.fontWeight = FontWeight.w600;
            } else if (weight == 700) {
              cssModel.fontWeight = FontWeight.w700;
            } else if (weight == 800) {
              cssModel.fontWeight = FontWeight.w800;
            } else if (weight == 900) {
              cssModel.fontWeight = FontWeight.w900;
            } else {
              cssModel.fontWeight = FontWeight.w500;
            }
          }
        }
        if (key == "height") {
          if (value == "auto") {
            cssModel.height = Height.auto();
          } else {
            if (value.contains(RegExp(r'\d'))) {
              if (value.contains("%")) {
                double size =
                    double.parse(value.substring(0, value.length - 1));
                cssModel.height = Height(size, Unit.percent);
              }
              if (value.contains("rem")) {
                double size =
                    double.parse(value.substring(0, value.length - 3));
                cssModel.height = Height(size, Unit.rem);
              }
              String unit = value.substring(value.length - 2);
              double size = double.parse(value.substring(0, value.length - 2));
              cssModel.height = Height(
                  size,
                  unit == "px"
                      ? Unit.px
                      : unit == "em"
                          ? Unit.em
                          : Unit.auto);
            }
          }
        }
        if(key == "letter-spacing"){
          cssModel.letterSpacing = int.tryParse(value.substring(0, value.indexOf(RegExp(r'[A-Za-z]'))));
        }
      });
    });
    return resultMap;
  }

  Color parseCssColor(String cssColor) {
    cssColor = cssColor.trim();

    if (cssColor.startsWith('#')) {
      if (cssColor.length == 7) {
        return Color(int.parse(cssColor.substring(1), radix: 16) + 0xFF000000);
      } else if (cssColor.length == 9) {
        return Color(int.parse(cssColor.substring(1), radix: 16));
      }
    }

    if (cssColor.startsWith('rgb')) {
      final List<String> parts = cssColor
          .substring(cssColor.indexOf('(') + 1, cssColor.indexOf(')'))
          .split(',')
          .map((part) => part.trim())
          .toList();

      if (parts.length == 3 || parts.length == 4) {
        final int r = int.parse(parts[0]);
        final int g = int.parse(parts[1]);
        final int b = int.parse(parts[2]);
        final int a =
            parts.length == 4 ? (double.parse(parts[3]) * 255).toInt() : 255;

        return Color.fromARGB(a, r, g, b);
      }
    }

    return Colors.transparent;
  }

  Border parseCssBorder(String cssBorder) {
    final List<String> parts = cssBorder.split(' ');
    final BorderSide borderSide = BorderSide(
      color: parts.length >= 3 ? parseCssColor(parts[2]) : Colors.black,
      width: parts.length >= 2 ? double.parse(parts[1]) : 1.0,
      style: parts.length >= 1 ? parseBorderStyle(parts[0]) : BorderStyle.solid,
    );

    return Border.all(
      color: borderSide.color,
      width: borderSide.width,
      style: borderSide.style,
    );
  }

  BorderStyle parseBorderStyle(String style) {
    switch (style) {
      case 'dotted':
        return BorderStyle.solid;
      case 'dashed':
        return BorderStyle.solid;
      case 'solid':
        return BorderStyle.solid;
      case 'double':
        return BorderStyle.none;
      default:
        return BorderStyle.none;
    }
  }
}
