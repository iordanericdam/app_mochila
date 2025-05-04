//Toma una fecha de inicio y fin, y devuelve un texto que indica el estado del viaje.
String getCountdownText(DateTime startDate, DateTime endDate) {
  final now = DateTime.now();

  if (now.isAfter(endDate)) {
    return 'Viaje terminado';
  }

  final int daysLeft = startDate.difference(now).inDays;

  if (daysLeft > 0) {
    return 'Faltan $daysLeft días';
  } else if (daysLeft == 0) {
    return '¡Es hoy!';
  } else {
    return 'Ya comenzó';
  }
}
