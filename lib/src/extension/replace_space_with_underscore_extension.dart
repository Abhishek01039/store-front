extension ReplaceSpaceWithUnderscore on String {
  String get text => this.replaceAll(' ', '_');
}
