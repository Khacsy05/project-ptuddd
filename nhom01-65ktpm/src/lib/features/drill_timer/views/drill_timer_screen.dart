import 'package:flutter/material.dart';
import '../models/drill_item.dart';
import '../services/drill_timer_service.dart';
import '../widgets/timer_display.dart';

class DrillTimerScreen extends StatefulWidget {
  final DrillItem drill;

  const DrillTimerScreen({
    super.key,
    required this.drill,
  });

  @override
  State<DrillTimerScreen> createState() => _DrillTimerScreenState();
}

class _DrillTimerScreenState extends State<DrillTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFF8FAFC)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.drill.title,
          style: const TextStyle(
            color: Color(0xFFF8FAFC),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              _buildDrillInfoCard(),
              const Spacer(),
              TimerDisplay(
                formattedTime: widget.drill.formattedDuration,
                progress: 1.0,
                status: DrillTimerStatus.idle,
                currentSet: 1,
                totalSets: widget.drill.sets,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrillInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.drill.category,
                  style: const TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${widget.drill.durationMinutes} phút • ${widget.drill.sets} hiệp',
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (widget.drill.description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              widget.drill.description,
              style: const TextStyle(
                color: Color(0xFFF8FAFC),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
