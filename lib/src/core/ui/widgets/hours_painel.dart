import 'package:flutter/material.dart';
import 'package:inux_barbershop/src/core/ui/constants.dart';

class HoursPainel extends StatelessWidget {
  final List<int>? enableTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;

  const HoursPainel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enableTimes,
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
                TimeButton(
                  label: '${i.toString().padLeft(2, '0')}:00',
                  value: i,
                  onPressed: onHourPressed,
                  enableTimes: enableTimes,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enableTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
    this.enableTimes,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;

    final TimeButton(:enableTimes, :value, :label, :onPressed) = widget;

    final disableTime = enableTimes != null && !enableTimes.contains(value);

    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                selected = !selected;
                onPressed(value);
              });
            },
      child: Container(
        width: 55,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
