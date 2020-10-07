import 'package:app/commons/helpers/url_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUrlHelper implements UrlHelper {
  @override
  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
      );
    }
  }
}
