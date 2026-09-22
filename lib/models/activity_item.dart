enum ActivityType { payment, agreement, maintenance }

class ActivityItem {
  final String title;
  final String subtitle;
  final ActivityType type;

  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.type,
  });
}
