class CuisineName {
  static const String sichuan   = 'Sichuan';
  static const String cantonese = 'Cantonese';
  static const String jiangsu   = 'Jiangsu';
  static const String zhejiang  = 'Zhejiang';
  static const String fujian    = 'Fujian';
  static const String hunan     = 'Hunan';
  static const String anhui     = 'Anhui';
  static const String yunnan    = 'Yunnan';

  static const List<String> all = [
    sichuan, yunnan, cantonese, jiangsu,
    zhejiang, fujian, hunan, anhui,
  ];
}

/// Configuration for each cuisine's Wikipedia page and section.
const Map<String, Map<String, dynamic>> cuisineConfig = {
  CuisineName.sichuan:   {'page': 'Sichuan_cuisine', 'section': 6},
  CuisineName.cantonese: {'page': 'Cantonese_cuisine', 'section': 5},
  CuisineName.jiangsu:   {'page': 'Jiangsu_cuisine', 'section': 2},
  CuisineName.zhejiang:  {'page': 'Zhejiang_cuisine', 'section': 2},
  CuisineName.fujian:    {'page': 'Fujian_cuisine', 'section': 3},
  CuisineName.hunan:     {'page': 'Hunan_cuisine', 'section': 3},
  CuisineName.anhui:     {'page': 'Anhui_cuisine', 'section': 2},
  CuisineName.yunnan:    {'page': 'Yunnan_cuisine', 'section': 1},
};