

enum BuildFlavor { production, development, staging }

BuildEnvironment? get env => _env;
BuildEnvironment? _env;

class BuildEnvironment {

  final String? apiKey;
  final BuildFlavor? flavor;

  BuildEnvironment._init({this.flavor, this.apiKey});

  static void init({required BuildFlavor flavor, String? apiKey}) {

      if (flavor == BuildFlavor.development) {

        _env ??= BuildEnvironment._init(flavor: flavor, apiKey: "");

      } else if ( flavor == BuildFlavor.production) {


      } else if ( flavor == BuildFlavor.staging ) {

        _env ??= BuildEnvironment._init(flavor: flavor, apiKey: "");

      }
  }

}