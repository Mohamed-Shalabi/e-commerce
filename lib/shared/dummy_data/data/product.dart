import 'dart:convert';

import 'package:e_commerce/shared/utils/assets_manager.dart';

final allProductsData = <Map<String, dynamic>>[
  product1,
  product2,
  product3,
  product4,
  product5,
  product6,
  product7,
];

final wishlistData = <Map<String, dynamic>>[];

final product1 = <String, dynamic>{
  'id': 1,
  'title': 'Pencil',
  'description': 'This is a great pencil made in Egypt.',
  'images': json.encode(
    <String>[ImageAssets.pencilImage],
  ),
  'price': 5,
  'quantity': 5,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 1,
};

final product2 = <String, dynamic>{
  'id': 2,
  'title': 'Pen',
  'description': 'This is a great pen made in Egypt.',
  'images': json.encode(
    <String>[
      ImageAssets.penImage1,
      ImageAssets.penImage2,
      ImageAssets.penImage3,
    ],
  ),
  'price': 10,
  'quantity': 4,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 1,
};

final product3 = <String, dynamic>{
  'id': 3,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 1,
};

final product4 = <String, dynamic>{
  'id': 4,
  'title': 'Asus Rog Strix',
  'description': 'This is a great Asus laptop made in China.',
  'images': json.encode(
    <String>[
      ImageAssets.asusRogStrixImage,
      ImageAssets.asusRogStrixImage,
    ],
  ),
  'price': 25000,
  'quantity': 3,
  'components': json.encode(
    <String>['laptop', 'mouse', 'keyboard'],
  ),
  'category_id': 2,
};

final product5 = <String, dynamic>{
  'id': 5,
  'title': 'Asus Rog Zephyrus',
  'description': 'This is a great Asus laptop made in China.',
  'images': json.encode(
    <String>[
      ImageAssets.asusRogZephyrusImage,
      ImageAssets.asusRogZephyrusImage,
      ImageAssets.asusRogZephyrusImage,
      ImageAssets.asusRogZephyrusImage,
    ],
  ),
  'price': 45000,
  'quantity': 1,
  'components': json.encode(
    <String>[
      'laptop',
      'mouse',
      'keyboard',
      'laptop bag',
    ],
  ),
  'category_id': 2,
};

final product6 = <String, dynamic>{
  'id': 6,
  'title': 'Asus TUF Dash',
  'description': 'This is a great Asus laptop made in China.',
  'images': json.encode(
    <String>[ImageAssets.asusTufDashImage],
  ),
  'price': 20000,
  'quantity': 11,
  'components': json.encode(
    <String>[
      'laptop',
      'mouse',
      'keyboard',
      'laptop bag',
    ],
  ),
  'category_id': 2,
};

final product7 = <String, dynamic>{
  'id': 7,
  'title': 'Samson C10u pro usb',
  'description': 'This is a great Samson mic made in China.',
  'images': json.encode(
    <String>[ImageAssets.samsonImage],
  ),
  'price': 2350,
  'quantity': 3,
  'components': json.encode(
    <String>['microphone', 'usb cable', 'stand'],
  ),
  'category_id': 3,
};
