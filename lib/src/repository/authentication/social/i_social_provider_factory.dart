import 'package:storefront/src/repository/authentication/social/social_provider_factory.dart';
import 'i_social_provider.dart';

abstract class SocialProviderFactory {
  SocialProvider createInstance(SocialService socialService);
}
