extension XString on String {
  String lastChars(int n) {
    if (length <= n) return this;
    return substring(length - n);
  }
}
