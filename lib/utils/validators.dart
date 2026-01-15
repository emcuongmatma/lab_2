String? validatorPhone(String? value) {
  if (value == null || value.isEmpty) return 'Không được bỏ trống!';
  if (!RegExp(r'^\d+$').hasMatch(value) || (value.length < 6 || value.length > 15 )) return 'Số điện thoại cần nhập 6 - 15 chữ số';
  return null;
}
String? validatorPassword(String? value) {
  if (value == null || value.isEmpty) return 'Không được bỏ trống!';
  return null;
}
String? validatorName(String? value) {
  if (value == null || value.isEmpty) return 'Không được bỏ trống!';
  return null;
}