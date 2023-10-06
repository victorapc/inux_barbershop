import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/constants.dart';

class HoursPainel extends StatelessWidget {
  final int startTime;
  final int endTime;

  const HoursPainel({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os horários de atendimento',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // Widget que faz a quebra automático dos outros widgets.
          Wrap(
            spacing: 8,
            runSpacing: 16,
            children: [
              for (int i = startTime; i <= endTime; i++)
                TimeButton(label: '${i.toString().padLeft(2, '0')}:00')
            ],
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatelessWidget {
  final String label;

  const TimeButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: ColorsConstants.grey,
          ),
        ),
      ),
    );
  }
}
