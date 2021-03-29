class ReportChatAction{
  final String reportID;
  // List of all actions moderator chooses
  final List<String> actionsTaken;
  final String actionReason;
  final String updateToReporter;
  final String moderatorID;
  final DateTime actionDate;

  ReportChatAction({
    this.reportID, this.actionsTaken, this.actionReason, this.updateToReporter, this.moderatorID, this.actionDate
  });
}