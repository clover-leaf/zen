class MessageInfo {
  const MessageInfo({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    this.isRead = true,
  });
  
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final bool isRead;
}
