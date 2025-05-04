

// Toma una fecha de inicio y devuelve un texto que indica cuántos días faltan para esa fecha
String getCountdownText(DateTime startDate) {
  final int daysLeft = startDate.difference(DateTime.now()).inDays;

  if (daysLeft > 0) {
    return 'Faltan $daysLeft días';
  } else if (daysLeft == 0) {
    return '¡Es hoy!';
  } else {
    return 'Ya comenzó';
  }
}