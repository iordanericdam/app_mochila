//Toma una fecha de inicio y fin, y devuelve un texto que indica el estado del viaje.
String getCountdownText(DateTime startDate, DateTime endDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  if (today.isAfter(endDate)) {
    return 'Viaje terminado';
  }

  final int daysLeft = startDate.difference(today).inDays;
  print(startDate);
  print(today);
  if (daysLeft > 0) {
    return 'Faltan $daysLeft días';
  } else if (daysLeft == 0) {
    return '¡Es hoy!';
  } else {
    return 'Disfrutando del viaje';
  }
}
