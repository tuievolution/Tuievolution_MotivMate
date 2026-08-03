import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Shadow> _buildShadows(String effectId, Color effectColor) {
  final double baseAlpha = effectColor.a;

  Color c(double multiplier) => effectColor.withValues(alpha: (baseAlpha * multiplier).clamp(0.0, 1.0));

  switch (effectId) {
    case 'shadow': // Sadece "Gölge" (Şiddetini slider ile siz ayarlayacaksınız)
      return [Shadow(color: c(1.0), blurRadius: 4, offset: const Offset(2, 2))];
    case 'neon':
      return [
        Shadow(color: c(1.0), blurRadius: 4),
        Shadow(color: c(0.8), blurRadius: 12),
        Shadow(color: c(0.6), blurRadius: 24),
      ];
    case 'cloud':
      return [
        Shadow(color: c(0.6), blurRadius: 16),
        Shadow(color: c(0.4), blurRadius: 32),
        Shadow(color: c(0.2), blurRadius: 64),
      ];
    case 'retro':
      return List.generate(
        6,
        (i) => Shadow(
          color: c(1.0 - i * 0.15),
          blurRadius: 0,
          offset: Offset((i + 1) * 1.5, (i + 1) * 1.5),
        ),
      );
    case 'outline': 
      return [
        Shadow(offset: const Offset(-1.5, -1.5), color: c(1.0)),
        Shadow(offset: const Offset(1.5, -1.5), color: c(1.0)),
        Shadow(offset: const Offset(1.5, 1.5), color: c(1.0)),
        Shadow(offset: const Offset(-1.5, 1.5), color: c(1.0)),
      ];
    case 'emboss':
      return [
        Shadow(color: Colors.white.withValues(alpha: baseAlpha * 0.6), blurRadius: 1, offset: const Offset(-1, -1)),
        Shadow(color: c(1.0), blurRadius: 1, offset: const Offset(1, 1)),
      ];
    case 'none':
    default:
      return [];
  }
}

TextStyle _getGoogleFont(String fontFamily, {TextStyle? textStyle}) {
  switch (fontFamily) {
    case 'Balsamiq Sans': return GoogleFonts.balsamiqSans(textStyle: textStyle);
    case 'Berkshire Swash': return GoogleFonts.berkshireSwash(textStyle: textStyle);
    case 'Black Ops One': return GoogleFonts.blackOpsOne(textStyle: textStyle);
    case 'Caveat': return GoogleFonts.caveat(textStyle: textStyle);
    case 'Chakra Petch': return GoogleFonts.chakraPetch(textStyle: textStyle);
    case 'Cormorant Garamond': return GoogleFonts.cormorantGaramond(textStyle: textStyle);
    case 'Dancing Script': return GoogleFonts.dancingScript(textStyle: textStyle);
    case 'Exo': return GoogleFonts.exo(textStyle: textStyle);
    case 'Fira Code': return GoogleFonts.firaCode(textStyle: textStyle);
    case 'Great Vibes': return GoogleFonts.greatVibes(textStyle: textStyle);
    case 'Inter': return GoogleFonts.inter(textStyle: textStyle);
    case 'Kalam': return GoogleFonts.kalam(textStyle: textStyle);
    case 'Lato': return GoogleFonts.lato(textStyle: textStyle);
    case 'Merriweather': return GoogleFonts.merriweather(textStyle: textStyle);
    case 'Montserrat': return GoogleFonts.montserrat(textStyle: textStyle);
    case 'Noto Sans': return GoogleFonts.notoSans(textStyle: textStyle);
    case 'Nunito': return GoogleFonts.nunito(textStyle: textStyle);
    case 'Open Sans': return GoogleFonts.openSans(textStyle: textStyle);
    case 'Oswald': return GoogleFonts.oswald(textStyle: textStyle);
    case 'Pacifico': return GoogleFonts.pacifico(textStyle: textStyle);
    case 'Patrick Hand': return GoogleFonts.patrickHand(textStyle: textStyle);
    case 'Playfair Display': return GoogleFonts.playfairDisplay(textStyle: textStyle);
    case 'Poppins': return GoogleFonts.poppins(textStyle: textStyle);
    case 'Rajdhani': return GoogleFonts.rajdhani(textStyle: textStyle);
    case 'Raleway': return GoogleFonts.raleway(textStyle: textStyle);
    case 'Sacramento': return GoogleFonts.sacramento(textStyle: textStyle);
    case 'Ubuntu': return GoogleFonts.ubuntu(textStyle: textStyle);
    case 'Ultra': return GoogleFonts.ultra(textStyle: textStyle);
    case 'Roboto':
    default: return GoogleFonts.roboto(textStyle: textStyle);
  }
}

class QuoteCard extends StatelessWidget {
  final String text;
  final String author;
  final Color cardBackgroundColor;
  final Color quoteTextColor;
  final Color? effectColor;
  final double opacity;
  final double fontSize;
  final String fontFamily;
  final String textEffectId;
  final bool showBackground;

  final bool fillContainer;
  final double borderRadius;
  final double cardBorderThickness;
  final int cardBorderColorValue;
  final double quotePadding;

  const QuoteCard({
    super.key,
    required this.text,
    required this.author,
    required this.cardBackgroundColor,
    required this.quoteTextColor,
    this.effectColor,
    required this.opacity,
    required this.fontSize,
    required this.fontFamily,
    this.textEffectId = 'none',
    this.showBackground = true,
    this.fillContainer = false,
    this.borderRadius = 16,
    this.cardBorderThickness = 0.0,
    this.cardBorderColorValue = 0xFFFFFFFF,
    this.quotePadding = 18,
  });

  @override
  Widget build(BuildContext context) {
    final effColor = effectColor ?? Colors.transparent;
    final shadows = _buildShadows(textEffectId, effColor);

    final clampedFontSize = fontSize.clamp(10.0, 48.0);
    final authorFontSize = (clampedFontSize * 0.45).clamp(10.0, 24.0);

    final baseStyle = _getGoogleFont(fontFamily, textStyle: TextStyle(
      color: quoteTextColor,
      fontSize: clampedFontSize,
      fontWeight: FontWeight.w500,
      height: 1.25,
      shadows: shadows.isEmpty ? null : shadows,
    ));

    final authorStyle = _getGoogleFont(fontFamily, textStyle: TextStyle(
      color: quoteTextColor.withValues(alpha: 0.75),
      fontSize: authorFontSize,
      fontWeight: FontWeight.w500,
      shadows: shadows.isEmpty ? null : shadows,
    ));

    final content = LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: fillContainer ? MainAxisSize.max : MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.format_quote_rounded,
              color: quoteTextColor.withValues(alpha: 0.35),
              size: (clampedFontSize * 0.8).clamp(20.0, 40.0),
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth > 0
                          ? (constraints.maxWidth - (quotePadding * 2) - (showBackground ? borderRadius * 0.6 : 0)).clamp(0.0, double.infinity)
                          : 320,
                    ),
                child: Text(
                  '"$text"',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: baseStyle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '- $author',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: authorStyle,
            ),
          ],
        );
      },
    );

    final decoration = BoxDecoration(
      color: showBackground ? cardBackgroundColor.withValues(alpha: opacity) : Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      // YENİ: Çerçeve SADECE showBackground (kart gösterimi) 'true' ise ve kalınlık 0'dan büyükse çizilir
      border: (showBackground && cardBorderThickness > 0)
          ? Border.all(
              color: Color(cardBorderColorValue),
              width: cardBorderThickness,
            )
          : null,
    );

    if (fillContainer) {
      return Container(
        width: double.infinity,
        decoration: decoration,
        padding: EdgeInsets.all(quotePadding).copyWith(
              left: quotePadding + (showBackground ? borderRadius * 0.3 : 0),
              right: quotePadding + (showBackground ? borderRadius * 0.3 : 0),
            ),
        child: content,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: decoration,
        padding: EdgeInsets.all(quotePadding).copyWith(
              left: quotePadding + (showBackground ? borderRadius * 0.3 : 0),
              right: quotePadding + (showBackground ? borderRadius * 0.3 : 0),
            ),
        child: content,
      ),
    );
  }
}