# flutterex

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


페이스북 hash key
private fun getHashKey() {
var packageInfo: PackageInfo? = null
try {
packageInfo =
packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
} catch (e: PackageManager.NameNotFoundException) {
e.printStackTrace()
}
if (packageInfo == null) Log.e("KeyHash", "KeyHash:null")
for (signature in packageInfo!!.signatures) {
try {
val md = MessageDigest.getInstance("SHA")
md.update(signature.toByteArray())
Log.d(
"KeyHash",
Base64.encodeToString(md.digest(), Base64.DEFAULT)
)
} catch (e: NoSuchAlgorithmException) {
Log.e(
"KeyHash",
"Unable to get MessageDigest. signature=$signature",
e
)
}
}
}

new