import 'package:flutter/material.dart';
import '../config/theme.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final String status;

  const StatusBadge({
    Key? key,
    required this.label,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'upcoming':
        return AppTheme.warningColor;
      case 'approved':
      case 'completed':
      case 'active':
        return AppTheme.successColor;
      case 'rejected':
      case 'cancelled':
      case 'locked':
        return AppTheme.errorColor;
      case 'in progress':
        return AppTheme.secondaryColor;
      case 'reimbursed':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }
}
