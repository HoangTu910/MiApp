// ignore: library_prefixes
import 'dart:math' as Math;

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Health'),
        // ignore: deprecated_member_use
        backgroundColor: Colors.white,
        // ignore: deprecated_member_use
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProgressIndicator(),
                    _buildHealthMetrics(),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      crossAxisCount: 2,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      children: [
                        _buildDashboardItem(
                          icon: Icons.bed,
                          label: 'Sleep',
                          value: '7h 30m',
                          color: Colors.purple,
                        ),
                        _buildDashboardItem(
                          icon: Icons.favorite,
                          label: 'Heart Rate',
                          value: '72 BPM',
                          color: Colors.red,
                        ),
                        _buildDashboardItem(
                          icon: Icons.water_drop,
                          label: 'Blood Pressure',
                          value: '120/80',
                          color: Colors.red.shade400,
                        ),
                        _buildDashboardItem(
                          icon: Icons.air,
                          label: 'Blood Oxygen',
                          value: '98%',
                          color: Colors.red.shade300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 215,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Average per hour',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressMetric(
                icon: Icons.monitor_heart,
                progress: 0.62, // Daily steps progress (6,243 / 10,000 steps)
                color: Colors.red,
                label: "Heart rate",
                value: "72",
              ),
              _buildProgressMetric(
                icon: Icons.local_fire_department,
                progress: 0.53, // Daily calorie goal progress (534 / 1,000 cal)
                color: Colors.orange,
                label: "Calories",
                value: "534",
              ),
              _buildProgressMetric(
                icon: Icons.timer,
                progress: 0.53, // Daily active minutes (32 / 60 minutes)
                color: Colors.green,
                label: "Active min",
                value: "32",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMetric({
    required IconData icon,
    required double progress,
    required Color color,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: progress,
            color: color,
            // ignore: deprecated_member_use
            backgroundColor: color.withOpacity(0.2),
            strokeWidth: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthMetrics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color:
                  _isHealthConditionGood()
                      ? Colors.green.shade100
                      : Colors.red.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isHealthConditionGood() ? Icons.check_circle : Icons.warning,
                  color: _isHealthConditionGood() ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _isHealthConditionGood()
                      ? 'Good Condition'
                      : 'Need Attention',
                  style: TextStyle(
                    color: _isHealthConditionGood() ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(Icons.local_fire_department, '534', 'Calories'),
                _buildMetric(Icons.directions_walk, '6,243', 'Steps'),
                _buildMetric(Icons.access_time, '32', 'Active Min'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isHealthConditionGood() {
    // Add your condition logic here
    // For example, check if steps > 5000 && activeMinutes > 30
    return true;
  }

  Widget _buildMetric(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class SemiCircleProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15;

    final center = Offset(size.width / 2, size.height);
    final radius = size.height;

    // Draw three arcs with different colors
    paint.color = Colors.blue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -Math.pi,
      Math.pi / 3,
      false,
      paint,
    );

    paint.color = Colors.green;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -2 * Math.pi / 3,
      Math.pi / 3,
      false,
      paint,
    );

    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -Math.pi / 3,
      Math.pi / 3,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
