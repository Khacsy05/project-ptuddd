import 'package:flutter/material.dart';
import '../services/drill_timer_service.dart';

class TimerControls extends StatelessWidget {
  final DrillTimerStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;

  const TimerControls({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPrimaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    if (status == DrillTimerStatus.running ||
        status == DrillTimerStatus.resting) {
      return _ActionButton(
        icon: Icons.pause_rounded,
        label: 'TẠM DỪNG',
        color: const Color(0xFFF59E0B),
        textColor: const Color(0xFF000000),
        onPressed: onPause,
      );
    }

    if (status == DrillTimerStatus.paused) {
      return _ActionButton(
        icon: Icons.play_arrow_rounded,
        label: 'TIẾP TỤC',
        color: const Color(0xFF10B981),
        textColor: const Color(0xFF000000),
        onPressed: onResume,
      );
    }

    return _ActionButton(
      icon: Icons.play_arrow_rounded,
      label: status == DrillTimerStatus.completed ? 'TẬP LẠI' : 'BẮT ĐẦU',
      color: const Color(0xFF22C55E),
      textColor: const Color(0xFF000000),
      onPressed: onStart,
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28, color: textColor),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
      ),
    );
  }
}
