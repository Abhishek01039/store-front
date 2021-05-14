class EnvironmentConfig {
  EnvironmentConfig._();

  /// There are two Environment [dev] and [prod]
  ///
  /// Default Environment is [prod] as of now.
  /// Once App will be live then the default Environment will be [dev]
  static const String ENV_NAME =
      String.fromEnvironment('ENV', defaultValue: 'PROD');
}
