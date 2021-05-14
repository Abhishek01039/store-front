extension TwoDigitDecimal on int {
  String? toPrecision() {
    return this.toStringAsFixed(2);
  }
}

extension TwoDigitDecimalFromDouble on num {
  String? toPrecision() {
    return this.toStringAsFixed(2);
  }
}
