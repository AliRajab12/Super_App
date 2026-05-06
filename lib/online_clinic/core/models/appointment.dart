enum Month { jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec }

class Appointment {
  Month month;
  List<int> visitDays;
  Appointment({
    required this.month,
    required this.visitDays,
  });

  static List<Appointment> generateFakeData() {
    final List<Appointment> list = [];
    list.add(Appointment(month: Month.aug, visitDays: [1, 2, 5]));
    list.add(Appointment(month: Month.feb, visitDays: [25]));
    list.add(Appointment(month: Month.oct, visitDays: [5, 7, 9, 10]));
    list.add(Appointment(month: Month.jul, visitDays: [25]));
    list.add(Appointment(month: Month.dec, visitDays: [11, 22, 31]));
    list.add(Appointment(month: Month.may, visitDays: [1, 8, 9, 10, 15, 19, 22]));
    return list;
  }
}
