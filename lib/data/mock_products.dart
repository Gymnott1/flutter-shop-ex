import '../models/product_model.dart'; // Import your Product model

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Nighthawk AX12 Router',
    description: 'Blazing fast Wi-Fi 6 router for demanding networks and gaming.',
    // Using Picsum Photos: https://picsum.photos/
    // The numbers are width/height. The ?random=1 ensures a different image.
    imageUrl: 'https://picsum.photos/seed/router1/400/300',
    price: 299.99,
    category: 'Routers',
  ),
  Product(
    id: '2',
    name: 'MeshForce M3s Wi-Fi System',
    description: 'Whole-home mesh Wi-Fi system for seamless coverage up to 6000 sq ft.',
    imageUrl: 'https://picsum.photos/seed/mesh1/400/300',
    price: 179.00,
    category: 'Mesh Systems',
  ),
  Product(
    id: '3',
    name: 'TP-Link 8 Port Gigabit Switch',
    description: 'Expand your wired network with this reliable and easy-to-use switch.',
    imageUrl: 'https://picsum.photos/seed/switch1/400/300',
    price: 24.99,
    category: 'Switches',
  ),
  Product(
    id: '4',
    name: 'Arris Surfboard SB8200 Modem',
    description: 'DOCSIS 3.1 cable modem for high-speed internet plans.',
    imageUrl: 'https://picsum.photos/seed/modem1/400/300',
    price: 149.99,
    category: 'Modems',
  ),
  Product(
    id: '5',
    name: 'Ubiquiti EdgeRouter X',
    description: 'Advanced SOHO router with powerful features and compact design.',
    imageUrl: 'https://picsum.photos/seed/edgerouter/400/300',
    price: 59.00,
    category: 'Routers',
  ),
  Product(
    id: '6',
    name: 'Netgear Orbi RBK752',
    description: 'Tri-band Mesh WiFi 6 System, reliable coverage for your smart home.',
    imageUrl: 'https://picsum.photos/seed/orbi1/400/300',
    price: 379.99,
    category: 'Mesh Systems',
  ),
  Product(
    id: '7',
    name: 'Ethernet Network Cable 50ft',
    description: 'Cat 6 Ethernet cable for high-speed wired connections.',
    imageUrl: 'https://picsum.photos/seed/cable1/400/300',
    price: 12.99,
    category: 'Accessories',
  ),
  Product(
    id: '8',
    name: 'Raspberry Pi 4 Model B',
    description: 'Versatile single-board computer, perfect for network projects.',
    imageUrl: 'https://picsum.photos/seed/rpi4/400/300',
    price: 75.00,
    category: 'DIY Networking',
  ),
];