import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel? _model;
  ProductEntity? _entity;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Simulated JSON from API
    final json = {
      'id': 101,
      'title': 'Dartz Plus Pro',
      'price': 99.99,
      'category': 'Software',
      'description': 'Advanced Functional Programming tools for Flutter.',
    };

    // 1. Create Model from JSON
    final model = ProductModel.fromJson(json);

    // 2. Map Model -> Entity (Testing the @Mapper enhancements)
    final entity = model.toProductEntity();

    setState(() {
      _model = model;
      _entity = entity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail (Mapping)'),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: _model == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Source: ProductModel (DTO)'),
                  _buildDataRow('id', '${_model?.id}'),
                  _buildDataRow('productName', '${_model?.productName}'),
                  _buildDataRow('price', '\$${_model?.price}'),
                  _buildDataRow('type', '${_model?.type}'),
                  _buildDataRow('internalRef', '${_model?.internalRef}'),
                  const Divider(height: 32),
                  _buildSectionTitle('Target: ProductEntity (Domain)'),
                  const Text(
                    'Mapped using @MapTo and custom constructor .fromApi()',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDataRow('id', '${_entity?.id}'),
                  _buildDataRow('title', '${_entity?.title}', highlight: true),
                  _buildDataRow('price', '\$${_entity?.price}'),
                  _buildDataRow(
                    'category',
                    '${_entity?.category}',
                    highlight: true,
                  ),
                  _buildDataRow('description', '${_entity?.description}'),
                  const SizedBox(height: 32),
                  const Card(
                    color: Colors.amberAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Note: "@MapTo" successfully mapped "productName" -> "title" and "type" -> "category". "@IgnoreMap" skipped "internalRef".',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: highlight ? Colors.blue : null,
                fontWeight: highlight ? FontWeight.bold : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
