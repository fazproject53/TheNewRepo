class CalenderInfo {
  final int id;
  final String typeOfOrder, date, invoices, personalName, time;

  CalenderInfo({
    required this.id,
    required this.typeOfOrder,
    required this.date,
    required this.invoices,
    required this.personalName,
    required this.time,
  });
}
///List of Calender info
List<CelebrityCalenderInfo> calenderList = [
  CelebrityCalenderInfo(
    id: 1,
    typeOfOrder: "طلب اهداء",
    date:  'يناير\n 27',
    invoices: '012345',
    personalName: 'ريانه عمر',
    time: '',
  ),
  CelebrityCalenderInfo(
    id: 2,
    typeOfOrder: "طلب اعلان",
    date:  'فبراير\n 27',
    invoices: '012345',
    personalName: 'الاء محمد',
    time: 'مساء',
  ),
  CelebrityCalenderInfo(
    id: 3,
    typeOfOrder: "طلب مساحة اعلانية",
    date:  'مارش\n 27',
    invoices: '012345',
    personalName: 'الاء خالد',
    time: '',
  ),
  CelebrityCalenderInfo(
    id: 4,
    typeOfOrder: "طلب اعلان",
    date:  'ابريل\n 27',
    invoices: '012345',
    personalName: 'فايزة النابلسي',
    time: 'صباحا',
  ),
  CelebrityCalenderInfo(
    id: 5,
    typeOfOrder: "طلب اهداء",
    date:  'يوليو\n 27',
    invoices: '012345',
    personalName: 'ريانه الحربي',
    time: '',
  ),
  CelebrityCalenderInfo(
    id: 6,
    typeOfOrder: "طلب مساحة اعلانية",
    date:  'يونيو\n 27',
    invoices: '012345',
    personalName: 'يزن وسيم',
    time: '',
  ),
];