class ReportChat{
  final String reportID;
  final String chatID;
  final String reportTitle;
  final String reportOffense;
  final String reportDescription;
  final String complete;
  final DateTime reportDate;
  final String userID;

  ReportChat({
    this.reportID, this.chatID, this.reportTitle, this.reportOffense,
    this.reportDescription, this.complete, this.reportDate, this.userID
  });
}