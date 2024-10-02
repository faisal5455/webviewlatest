import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length < 2) {
    print('Usage: dart tool/change_version.dart <version_code> <version_name>');
    exit(1);
  }

  final int versionCode = int.tryParse(arguments[0]) ?? 0;
  final String versionName = arguments[1];

  if (versionCode == 0) {
    print('Invalid versionCode. Please provide a valid integer.');
    exit(1);
  }

  // Assuming the script is being run from the project root
  final String projectPath = Directory.current.path;

  changeVersion(projectPath, versionCode, versionName);
}

void changeVersion(String projectPath, int versionCode, String versionName) {
  final File gradleFile = File('$projectPath/android/app/build.gradle');

  if (!gradleFile.existsSync()) {
    print('Error: build.gradle file not found at $projectPath/android/app/');
    exit(1);
  }

  // Read the contents of the build.gradle file
  String gradleContent = gradleFile.readAsStringSync();

  // Regular expressions to match versionCode and versionName
  final versionCodeRegex = RegExp(r'versionCode\s*=\s*\d+');
  final versionNameRegex = RegExp(r'versionName\s*=\s*"[^"]+"');

  // Update the versionCode and versionName
  gradleContent = gradleContent.replaceFirst(
      versionCodeRegex, 'versionCode = $versionCode');
  gradleContent = gradleContent.replaceFirst(
      versionNameRegex, 'versionName = "$versionName"');

  // Write the updated content back to the build.gradle file
  gradleFile.writeAsStringSync(gradleContent);

  print(
      'Android version updated to versionCode: $versionCode, versionName: $versionName');
}
