class CodeInfo {
  final int id;
  final String  numberOfUsers, code, typeOfCode, codeGoTo, description, status, duration;
  //final DateTime duration;

  CodeInfo({
    required this.id,
    required this.numberOfUsers,
    required this.code,
    required this.typeOfCode,
    required this.codeGoTo,
    required this.description,
    required this.duration,
    required this.status,
  });
}

//List of codes with info
List<CodeInfo> codeList = [
  CodeInfo(
    id: 1,
    numberOfUsers: "22",
    typeOfCode: "مبلغ ثابت",
    codeGoTo: "اهداء",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
  CodeInfo(
    id: 2,
    numberOfUsers: "50",
    typeOfCode: "نسبة مئوية",
    codeGoTo: "المساحة الاعلانية",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "غير صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
  CodeInfo(
    id: 3,
    numberOfUsers: "100",
    typeOfCode: "نسبة مئوية",
    codeGoTo: "اهداء",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "غير صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
  CodeInfo(
    id: 4,
    numberOfUsers: "65",
    typeOfCode: "مبلغ ثابت",
    codeGoTo: "اهداء",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
  CodeInfo(
    id: 5,
    numberOfUsers: "150",
    typeOfCode: "نسبة مئوية",
    codeGoTo: "اهداء",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "غير صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
  CodeInfo(
    id: 6,
    numberOfUsers: "150",
    typeOfCode: "مبلغ ثابت",
    codeGoTo: "اهداء",
    description: "بمناسبة يوم التأسيس السعودي",
    duration: "من ٢٢-٢-٢٠٢٢ الي ٢٢-٢-٢٠٢٢",
    status: "غير صالح للاستخدام",
    code: "كود الخصم: 123MLx",
  ),
];
