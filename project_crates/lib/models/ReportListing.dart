class ReportListing{
  final String reportID;
  final String listingID;
  final String reportTitle;
  final String reportOffense;
  final String reportDescription;
  final String complete;
  final DateTime reportDate;
  final String userID;

  ReportListing({
    this.reportID, this.listingID, this.reportTitle, this.reportOffense,
    this.reportDescription, this.complete, this.reportDate, this.userID
  });
}