class EnvConfig {
  final String environment;
  final bool enableLogging;

  EnvConfig({required this.environment, required this.enableLogging});

  factory EnvConfig.fromEnvironment(String environment) {
    switch (environment) {
      case 'production':
        return EnvConfig(environment: environment, enableLogging: false);
      case 'developemnt':
      default:
        return EnvConfig(environment: environment, enableLogging: true);
    }
  }
}
