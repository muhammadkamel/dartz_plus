import 'package:flutter/material.dart';

import 'screens/async_screen.dart';
import 'screens/basic_usage_screen.dart';
import 'screens/before_after_screen.dart';
import 'screens/chaining_screen.dart';
import 'screens/error_handling_screen.dart';
import 'screens/fp_enhancements_screen.dart';
import 'screens/future_extensions_screen.dart';
import 'screens/get_or_else_screen.dart';
import 'screens/mapper_screen.dart';
import 'screens/real_world_api_screen.dart';
import 'screens/swap_screen.dart';
import 'screens/transformation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dartz Plus Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, '1. Basic Usage', const BasicUsageScreen()),
          _buildNavItem(
            context,
            '2. Error Handling',
            const ErrorHandlingScreen(),
          ),
          _buildNavItem(
            context,
            '3. Transformation (map, bimap)',
            const TransformationScreen(),
          ),
          _buildNavItem(
            context,
            '4. Chaining (flatMap)',
            const ChainingScreen(),
          ),
          _buildNavItem(
            context,
            '5. getOrElse & orElse',
            const GetOrElseScreen(),
          ),
          _buildNavItem(context, '6. Swap', const SwapScreen()),
          _buildNavItem(context, '7. Async Operations', const AsyncScreen()),
          _buildNavItem(
            context,
            '8. Future Extensions',
            const FutureExtensionsScreen(),
            color: Colors.purple.shade100,
          ),
          const Divider(height: 32),
          _buildNavItem(
            context,
            '9. Before vs After',
            const BeforeAfterScreen(),
            color: Colors.orange.shade100,
          ),
          _buildNavItem(
            context,
            '10. FP Enhancements',
            const FPEnhancementsScreen(),
            color: Colors.green.shade100,
          ),
          _buildNavItem(
            context,
            '11. Real World API Example',
            const RealWorldApiScreen(),
            color: Colors.blue.shade100,
          ),
          _buildNavItem(
            context,
            '12. Mapper (AutoMap)',
            const MapperScreen(),
            color: Colors.red.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    Widget screen, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.centerLeft,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
