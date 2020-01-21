declare const enum email_correlationmethod {
  None = 0,
  Skipped = 1,
  XHeader = 2,
  InReplyTo = 3,
  TrackingToken = 4,
  ConversationIndex = 5,
  SmartMatching = 6,
  CustomCorrelation = 7,
}
