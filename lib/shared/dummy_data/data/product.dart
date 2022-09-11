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
  product8,
  product9,
  product10,
  product11,
  product12,
  product13,
  product14,
  product15,
  product16,
  product17,
  product18,
  product19,
  product20,
  product21,
  product22,
  product23,
  product24,
  product25,
  product26,
  product27,
  product28,
  product29,
  product30,
  product31,
  product32,
  product33,
  product34,
  product35,
  product36,
  product37,
  product38,
  product39,
  product40,
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
  'category_id': 12,
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
  'category_id': 5,
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

final product8 = <String, dynamic>{
  'id': 8,
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
  'category_id': 7,
};

final product9 = <String, dynamic>{
  'id': 9,
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
  'category_id': 4,
};

final product10 = <String, dynamic>{
  'id': 10,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 5,
};

final product11 = <String, dynamic>{
  'id': 11,
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
  'category_id': 6,
};

final product12 = <String, dynamic>{
  'id': 12,
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

final product13 = <String, dynamic>{
  'id': 13,
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
  'category_id': 11,
};

final product14 = <String, dynamic>{
  'id': 14,
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
  'category_id': 9,
};

final product15 = <String, dynamic>{
  'id': 15,
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
  'category_id': 4,
};

final product16 = <String, dynamic>{
  'id': 16,
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
  'category_id': 10,
};

final product17 = <String, dynamic>{
  'id': 17,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 5,
};

final product18 = <String, dynamic>{
  'id': 18,
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
  'category_id': 8,
};

final product19 = <String, dynamic>{
  'id': 19,
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
  'category_id': 9,
};

final product20 = <String, dynamic>{
  'id': 20,
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
  'category_id': 6,
};
final product21 = <String, dynamic>{
  'id': 21,
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
  'category_id': 4,
};

final product22 = <String, dynamic>{
  'id': 22,
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
  'category_id': 11,
};

final product23 = <String, dynamic>{
  'id': 23,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 10,
};

final product24 = <String, dynamic>{
  'id': 24,
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
  'category_id': 12,
};

final product25 = <String, dynamic>{
  'id': 25,
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
  'category_id': 4,
};

final product26 = <String, dynamic>{
  'id': 26,
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

final product27 = <String, dynamic>{
  'id': 27,
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
  'category_id': 6,
};

final product28 = <String, dynamic>{
  'id': 28,
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
  'category_id': 5,
};

final product29 = <String, dynamic>{
  'id': 29,
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
  'category_id': 8,
};

final product30 = <String, dynamic>{
  'id': 30,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 9,
};

final product31 = <String, dynamic>{
  'id': 31,
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
  'category_id': 7,
};

final product32 = <String, dynamic>{
  'id': 32,
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
  'category_id': 8,
};

final product33 = <String, dynamic>{
  'id': 33,
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
  'category_id': 9,
};

final product34 = <String, dynamic>{
  'id': 34,
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
  'category_id': 10,
};

final product35 = <String, dynamic>{
  'id': 35,
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
  'category_id': 11,
};

final product36 = <String, dynamic>{
  'id': 36,
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
  'category_id': 12,
};

final product37 = <String, dynamic>{
  'id': 37,
  'title': 'Bag',
  'description': 'This is a great bag made in China.',
  'images': json.encode(<String>[ImageAssets.bagImage, ImageAssets.bagImage]),
  'price': 150,
  'quantity': 12,
  'components': json.encode(
    <String>[],
  ),
  'category_id': 4,
};

final product38 = <String, dynamic>{
  'id': 38,
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
  'category_id': 5,
};

final product39 = <String, dynamic>{
  'id': 39,
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
  'category_id': 6,
};

final product40 = <String, dynamic>{
  'id': 40,
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
  'category_id': 7,
};
