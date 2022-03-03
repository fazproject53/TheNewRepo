class CalenderInfo {
  final int id;
  final String typeOfOrder, date, invoices, personalName, time, date2;

  CalenderInfo({
    required this.id,
    required this.typeOfOrder,
    required this.date,
    required this.invoices,
    required this.personalName,
    required this.time,
    required this.date2,
  });
}
///List of Calender info
List<CalenderInfo> calenderList = [
  CalenderInfo(
    id: 1,
    typeOfOrder: "طلب اهداء",
    date:  'يناير\n 27',
    invoices: '012345',
    personalName: 'ريانه عمر',
    time: '',
    date2: '27 يناير'
  ),
  CalenderInfo(
    id: 2,
    typeOfOrder: "طلب اعلان",
    date:  'فبراير\n 27',
    invoices: '012345',
    personalName: 'الاء محمد',
    time: 'مساء',
    date2: '27 يناير'
  ),
  CalenderInfo(
    id: 3,
    typeOfOrder: "طلب مساحة اعلانية",
    date:  'مارش\n 27',
    invoices: '012345',
    personalName: 'الاء خالد',
    time: '',
      date2: '27 يناير'
  ),
  CalenderInfo(
    id: 4,
    typeOfOrder: "طلب اعلان",
    date:  'ابريل\n 27',
    invoices: '012345',
    personalName: 'فايزة النابلسي',
    time: 'صباحا',
      date2: '27 يناير'
  ),
  CalenderInfo(
    id: 5,
    typeOfOrder: "طلب اهداء",
    date:  'يوليو\n 27',
    invoices: '012345',
    personalName: 'ريانه الحربي',
    time: '',
      date2: '27 يناير'
  ),
  CalenderInfo(
    id: 6,
    typeOfOrder: "طلب مساحة اعلانية",
    date:  'يونيو\n 27',
    invoices: '012345',
    personalName: 'يزن وسيم',
    time: '',
      date2: '27 يناير'
  ),
];