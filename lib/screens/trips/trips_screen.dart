import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/trip_controller.dart';
import '../../config/theme.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final TripController tripController = Get.find<TripController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('New Trip'),
                onPressed: () => _showCreateTripDialog(),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => tripController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : tripController.trips.isEmpty
                ? Center(
                    child: Text(
                      'No trips yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tripController.trips.length,
                    itemBuilder: (context, index) {
                      final trip = tripController.trips[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trip.destination,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(trip.status).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    trip.status,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: _getStatusColor(trip.status),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              trip.purpose,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${trip.startDate.month}/${trip.startDate.day} - ${trip.endDate.month}/${trip.endDate.day}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '\$${trip.spent.toStringAsFixed(2)} / \$${trip.budget.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: trip.spent / trip.budget,
                                minHeight: 4,
                                backgroundColor: AppTheme.borderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  (trip.spent / trip.budget) > 0.9
                                      ? AppTheme.errorColor
                                      : AppTheme.successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return AppTheme.secondaryColor;
      case 'In Progress':
        return AppTheme.warningColor;
 n      case 'Completed':
        return AppTheme.successColor;
      case 'Cancelled':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  void _showCreateTripDialog() {
    Get.defaultDialog(
      title: 'Create New Trip',
      content: const Text('Trip creation form coming soon!'),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text('Close'),
      ),
    );
  }
}
