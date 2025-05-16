import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import '../main.dart'; // Import main.dart to access myAppKey

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> _filteredProducts;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // ... (initState, dispose, _performSearch, _clearSearch methods remain the same) ...
  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(mockProducts);
    _searchController.addListener(() {
      _performSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredProducts = List.from(mockProducts);
      } else {
        _filteredProducts = mockProducts.where((product) {
          final productName = product.name.toLowerCase();
          final productDescription = product.description.toLowerCase();
          return productName.contains(_searchQuery) ||
                 productDescription.contains(_searchQuery);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 800) {
      crossAxisCount = 3;
    }

    // Access the public themeMode
    final currentThemeMode = myAppKey.currentState?.themeMode ?? ThemeMode.light;
    final isDarkMode = currentThemeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amazons - Browse Gadgets'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Tooltip(
            message: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            child: Switch(
              value: isDarkMode,
              onChanged: (value) {
                myAppKey.currentState?.changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Colors.grey[100],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notification_add_outlined),
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wi-Fi status: Connected (mock)')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      // ... (rest of your HomePage body remains the same) ..
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search gadgets by name or description...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
              ),
            ),
          ),
          if (_filteredProducts.isEmpty && _searchQuery.isNotEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No gadgets found for "$_searchQuery"',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _clearSearch,
                      child: const Text('Clear Search'),
                    )
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.54,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(product: _filteredProducts[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}

