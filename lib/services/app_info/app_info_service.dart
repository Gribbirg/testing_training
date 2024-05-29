import 'package:package_info_plus/package_info_plus.dart';
import 'package:testing_training/services/app_info/abstract_app_info_service.dart';
import 'package:version/version.dart';

class AppInfoService extends AbstractAppInfoService {
  final PackageInfo _packageInfo;

  AppInfoService({required PackageInfo packageInfo})
      : _packageInfo = packageInfo;

  @override
  Version get appVersion => Version.parse(_packageInfo.version);
}
