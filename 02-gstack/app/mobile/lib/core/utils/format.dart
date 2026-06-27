String formatPrice(num v) {
  final s = v.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${buf.toString()} ₫';
}

String sportLabel(String s) {
  const map = {
    'badminton': 'Cầu lông',
    'mini_football': 'Mini football',
    'tennis': 'Tennis',
  };
  return map[s] ?? s;
}

String statusLabel(String s) {
  const map = {
    'pending': 'Chờ xác nhận',
    'confirmed': 'Đã xác nhận',
    'cancelled': 'Đã hủy',
    'completed': 'Hoàn thành',
  };
  return map[s] ?? s;
}

String roleLabel(String role) {
  const map = {
    'user': 'Người dùng',
    'admin': 'Quản trị viên',
  };
  return map[role] ?? role;
}
