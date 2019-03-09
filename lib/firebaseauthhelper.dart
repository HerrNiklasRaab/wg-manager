import 'package:flutter/services.dart';

class FirebaseAuthHelper {
  static String getFirebaseErrorMessage(PlatformException exception) {
      switch (exception.code) {
        case "ERROR_INVALID_EMAIL":
          return "Die E-Mail-Adresse hat ein ungültiges Format.";
        case "ERROR_USER_NOT_FOUND":
          return "Einen User mit dieser E-Mail Adresse gibt es nicht.";
        case "ERROR_WRONG_PASSWORD":
          return "Das eingegebene Passwort ist falsch, oder hast dich mit Facebook oder Google registriert. In diesem Fall, musst du dich auch damit einloggen.";
        case "ERROR_WEAK_PASSWORD":
          return "Das eingegebene Passwort ist zu unsicher, verwende mindestens 6 Zeichen.";
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return "Diese E-Mail-Adresse wird bereits verwendet, wähle eine andere oder melde dich damit an.";
        case "sign_in_failed":
          return "Die Google Anmeldung ist fehlgeschlagen oder abgebrochen worden.";
        case "ERROR_NETWORK_REQUEST_FAILED":
          return "Die Anmeldung ist fehlgeschlagen, möglicherweiße haben Sie keine Internetverbindung.";
        default:
          return exception.message;
      }
  }
}
