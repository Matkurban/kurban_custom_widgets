import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';
import 'package:kurban_custom_widgets/src/model/dio_log_model.dart';

class LoggerListCard extends StatelessWidget {
  const LoggerListCard({
    super.key,
    required this.item,
    this.onTap,
    this.success = const Color(0xFF4CAf50),
    this.error = const Color(0xFFf44336),
  });

  final DioLogModel item;
  final VoidCallback? onTap;
  final Color success;
  final Color error;

  @override
  Widget build(BuildContext context) {
    int statusCode = item.response?.statusCode ?? 0;
    Color statusColor = statusCode == 200 ? success : error;

    return KurbanUniversalCard(
      elevation: 0,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPress: onTap,
      child: Row(
        spacing: 10,
        children: [
          Text(statusCode.toString(), style: TextStyle(color: statusColor)),
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text(
                      item.request.method,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        item.request.path,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  item.request.baseUrl,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getDateTime(item.timestamp)),
                    Text(formatDuration(item.duration)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDateTime(DateTime time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      time.millisecondsSinceEpoch,
    );
    return ' ${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}:${dateTime.second.toString().padLeft(2, "0")}';
  }

  String formatDuration(Duration? duration) {
    if (duration == null) return '';

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    var milliseconds = duration.inMilliseconds.remainder(10000);

    List<String> parts = [];
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0) parts.add('${seconds}s');
    if (milliseconds > 0) parts.add('${milliseconds}ms');
    return parts.join(' ');
  }
}
