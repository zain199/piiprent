import 'package:piiprent/helpers/enums.dart';

// Laviin
// const String companyId = 'ba3bd324-e8ec-4095-9c14-5ab702fa16c5';
// const String clientId = 'wCGDXWbZFxhULVjnPYMxXkujONUHYHJnlH3mNKNM';
// const String apiUrl = 'https://api.r3sourcertest.com';
// const String formId = 'cede0726-1646-4940-aadc-56b91403d110';
// const String origin = 'https://laviin.r3sourcertest.com';
// const String googleApiKey = 'AIzaSyBqirIAPcDQ3kNaDyAk_qgFOn_oQmkMTg4';

// Piiprent
const String companyId = 'bbeed8cd-1b64-4c88-b0ae-5723bdd44ac3';
const String clientId = 'wCGDXWbZFxhULVjnPYMxXkujONUHYHJnlH3mNKNM';
const String apiUrl = 'https://api.piipai.com';
const String formId = '58558379-4d7d-410c-8dad-19ed7d30b72e';
const String origin = 'https://piiprent.piipai.com';
const String googleApiKey = 'AIzaSyBqirIAPcDQ3kNaDyAk_qgFOn_oQmkMTg4';

const int listLimit = 5;

const Map<String, String> languageMap = {
  'EN': 'en',
  'EE': 'ee',
  'RU': 'ru',
  'FI': 'fi'
};

const Map<int, String> TimesheetStatus = {
  0: "New",
  1: "Pre-Shift check pending",
  2: "Pre-Shift check confirmed",
  3: "Pre-Shift check failed",
  4: "Submit pending",
  5: "Approval pending",
  6: "Supervisor modified",
  7: "Approved",
};

const Map<int, String> Residency = {
  1: "Citizen",
  2: "Permanent Resident",
  3: "Temporary Resident",
  0: "Unknown",
};

const Map<TimesheetTime, String> TimesheetTimeKey = {
  TimesheetTime.Start: 'shift_started_at',
  TimesheetTime.BreakStart: 'break_started_at',
  TimesheetTime.BreakEnd: 'break_ended_at',
  TimesheetTime.End: 'shift_ended_at',
};
