import '../models/product.dart';

const List<Category> categories = [
  Category('Shoes', 'https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/thumbnail.webp'),
  Category('Clothes', 'https://cdn.dummyjson.com/product-images/mens-shirts/man-plaid-shirt/thumbnail.webp'),
  Category('Bags', 'https://cdn.dummyjson.com/product-images/womens-bags/women-handbag-black/thumbnail.webp'),
  Category('Accessories', 'https://cdn.dummyjson.com/product-images/mens-watches/brown-leather-belt-watch/thumbnail.webp'),
  Category('Beauty', 'https://cdn.dummyjson.com/product-images/beauty/red-lipstick/thumbnail.webp'),
];

Category categoryByName(String name) =>
    categories.firstWhere((c) => c.name == name, orElse: () => categories.first);

const List<Product> products = [
  Product(
    id: 'p90',
    name: 'Puma Future Rider Trainers',
    category: 'Shoes',
    description: 'Retro-inspired sneakers designed for comfortable everyday wear, with a sporty silhouette and versatile casual styling.',
    price: 89.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/1.webp', 'https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/2.webp', 'https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/3.webp'],
    isTrending: true,
  ),
  Product(
    id: 'p92',
    name: 'Sports Sneakers Off White Red',
    category: 'Shoes',
    description: 'Comfortable off-white and red sneakers with a modern casual design suitable for daily activities.',
    price: 109.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-shoes/sports-sneakers-off-white-red/1.webp', 'https://cdn.dummyjson.com/product-images/mens-shoes/sports-sneakers-off-white-red/2.webp', 'https://cdn.dummyjson.com/product-images/mens-shoes/sports-sneakers-off-white-red/3.webp'],
    isTrending: false,
  ),
  Product(
    id: 'p85',
    name: 'Man Plaid Shirt',
    category: 'Clothes',
    description: 'Classic plaid shirt with a relaxed fit, easy to style for everyday and smart-casual outfits.',
    price: 34.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-shirts/man-plaid-shirt/1.webp', 'https://cdn.dummyjson.com/product-images/mens-shirts/man-plaid-shirt/2.webp', 'https://cdn.dummyjson.com/product-images/mens-shirts/man-plaid-shirt/3.webp'],
    isTrending: false,
  ),
  Product(
    id: 'p86',
    name: 'Man Short Sleeve Shirt',
    category: 'Clothes',
    description: 'Lightweight short-sleeve shirt offering a breathable, comfortable option for warm days.',
    price: 19.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-shirts/man-short-sleeve-shirt/1.webp', 'https://cdn.dummyjson.com/product-images/mens-shirts/man-short-sleeve-shirt/2.webp', 'https://cdn.dummyjson.com/product-images/mens-shirts/man-short-sleeve-shirt/3.webp'],
    isTrending: true,
  ),
  Product(
    id: 'p175',
    name: 'White Faux Leather Backpack',
    category: 'Bags',
    description: 'Stylish white backpack with a practical interior and a clean look for daily essentials.',
    price: 39.99,
    images: ['https://cdn.dummyjson.com/product-images/womens-bags/white-faux-leather-backpack/1.webp', 'https://cdn.dummyjson.com/product-images/womens-bags/white-faux-leather-backpack/2.webp', 'https://cdn.dummyjson.com/product-images/womens-bags/white-faux-leather-backpack/3.webp'],
    isTrending: false,
  ),
  Product(
    id: 'p176',
    name: 'Women Handbag Black',
    category: 'Bags',
    description: 'Timeless black handbag designed to complement different outfits while carrying your everyday essentials.',
    price: 59.99,
    images: ['https://cdn.dummyjson.com/product-images/womens-bags/women-handbag-black/1.webp', 'https://cdn.dummyjson.com/product-images/womens-bags/women-handbag-black/2.webp', 'https://cdn.dummyjson.com/product-images/womens-bags/women-handbag-black/3.webp'],
    isTrending: true,
  ),
  Product(
    id: 'p93',
    name: 'Brown Leather Belt Watch',
    category: 'Accessories',
    description: 'Elegant wristwatch combining a brown leather strap with a clean, classic dial.',
    price: 89.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-watches/brown-leather-belt-watch/1.webp', 'https://cdn.dummyjson.com/product-images/mens-watches/brown-leather-belt-watch/2.webp', 'https://cdn.dummyjson.com/product-images/mens-watches/brown-leather-belt-watch/3.webp'],
    isTrending: true,
  ),
  Product(
    id: 'p94',
    name: 'Longines Master Collection',
    category: 'Accessories',
    description: 'Refined luxury wristwatch with a timeless silhouette and premium watchmaking style.',
    price: 1499.99,
    images: ['https://cdn.dummyjson.com/product-images/mens-watches/longines-master-collection/1.webp', 'https://cdn.dummyjson.com/product-images/mens-watches/longines-master-collection/2.webp', 'https://cdn.dummyjson.com/product-images/mens-watches/longines-master-collection/3.webp'],
    isTrending: false,
  ),
  Product(
    id: 'p6',
    name: 'Calvin Klein CK One',
    category: 'Beauty',
    description: 'Fresh unisex fragrance with a crisp, clean character, ideal for versatile everyday use.',
    price: 49.99,
    images: ['https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp', 'https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/2.webp', 'https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/3.webp'],
    isTrending: true,
  ),
  Product(
    id: 'p8',
    name: 'Dior J\'adore',
    category: 'Beauty',
    description: 'Elegant floral fragrance with a feminine scent profile and a sophisticated finish.',
    price: 89.99,
    images: ['https://cdn.dummyjson.com/product-images/fragrances/dior-j\'adore/1.webp', 'https://cdn.dummyjson.com/product-images/fragrances/dior-j\'adore/2.webp', 'https://cdn.dummyjson.com/product-images/fragrances/dior-j\'adore/3.webp'],
    isTrending: false,
  ),
];

Product? productById(String id) {
  for (final p in products) {
    if (p.id == id) return p;
  }
  return null;
}
