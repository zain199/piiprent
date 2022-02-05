enum RoleType {
  Candidate,
  Client,
}

enum MessageType {
  Success,
  Error,
}

enum FilterDialogResult {
  Submit,
  Clear,
}

enum TimesheetStatus {
  New,
  PreShiftCheck,
}

enum TimesheetTime {
  Start,
  BreakStart,
  BreakEnd,
  End,
}

Map<String, String> language = {
  'EN': 'en',
  'EE': 'ee',
  'RU': 'ru',
  'FI': 'fi',
};
