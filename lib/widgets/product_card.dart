import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// An improved ProductCard widget that works with the enhanced theme system
/// - More efficient layout with better organization
/// - Uses semantic theme properties for consistent styling
/// - Responsive design with flexible sizing
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key, 
    required this.product,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image
          _buildProductImage(context),
          
          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildProductDetails(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3/2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image with loading and error handling
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: _imageLoadingBuilder,
            errorBuilder: _imageErrorBuilder,
          ),
          
          // Category badge overlay
          Positioned(
            top: 8,
            right: 8,
            child: _buildCategoryBadge(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withOpacity(0.85),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        product.category,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Name
        Text(
          product.name,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        const SizedBox(height: 4),
        
        // Product Description
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
        const Spacer(),
        
        // Price and Add to Cart
        _buildPriceAndAction(context),
      ],
    );
  }

  Widget _buildPriceAndAction(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        // Price display
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const Spacer(),
        
        // Add to cart button
        _buildAddToCartButton(context),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return IconButton(
      onPressed: () => _handleAddToCart(context),
      icon: const Icon(Icons.add_shopping_cart_outlined),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      tooltip: 'Add to cart',
    );
  }

  void _handleAddToCart(BuildContext context) {
    if (onAddToCart != null) {
      onAddToCart!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} added to cart')),
      );
    }
  }

  Widget _imageLoadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            : null,
        strokeWidth: 2.0,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _imageErrorBuilder(BuildContext context, Object exception, StackTrace? stackTrace) {
    final theme = Theme.of(context);
    
    return Container(
      color: theme.colorScheme.surfaceVariant,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined, 
          size: 40, 
          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
        ),
      ),
    );
  }
}