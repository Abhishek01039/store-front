extension ReplaceUnderscoreWithSpace on String {
  String get text => this.replaceAll('_', ' ');
}
