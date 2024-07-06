import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async =>
      _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "whatasapp-shourya",
          "private_key_id": "62efd98e4fa043c65961fb22c6f8d9a2cddd2e68",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZgT+w3RBrbWG3\nX6kMarIa0lab9AWT3cdoMuCJwsdiXQsW8i5NCg6TyOrAZHjuiOobBx8QzfOTghF7\nCMklmbDFPEk5+NF2BgFixL8gIc6KD4HM8djAadRMOGGAcnMuuurGJmcKntwdJo9/\nYH64QczlsHx95tHiE8P4qQ7dNBXiRi6fpfF1Hn7dMCdpCVgr2PADKYt7tO7WBhjF\ngwiSQN8wxFXoV0/grEyIu6FXJFc31Z/AZtu/FvW1BbKTzhBMrm4BUV4F44o9sJmb\nJflGAudkgTMeFaa+ZAvjB76DxK8Ogfq3gqBo6GtNc+5Bcjpw7Amv13q+rzSniyHg\n+NZlj6utAgMBAAECggEAWiOOWaXD4EF8dZpXXKX7GdKBwi/m/9ixgyVSmMT4DHOy\n3NeRCKxaTjS91O3OkEx9eKYC4dv4TfFhfTOu6L5A2/yX/EZ5yAfFG0GeU5qvFdhH\nWr//q/4v1UaoYasMwRkFowjXOzeK0Snh3lAHNCVQ3P+/GA5IfQDj/nFRj6q+Rv87\nJMBc4e+Nc8hkzGq6CuFLcDcUnZwwj9JCd3wjfQ+I5cQTletDelEPUmks5rMGNmP9\n+EFGNKmlbIfbPiUq7WcULdmAakfXdbCvb7kfADgX0rvwOSD8SRL2X/zeQ1dZy69V\n9DO427gUhnhPHVoSxtiHCoYs+mWgs5rWflSK9Q42oQKBgQD1srWOG8CrgNeidJ4I\nFVh005cL/tCqtgWb7gTc9CBeBsKeOcORqkoBvMN5izf7dXEtrm/8ugj1f+qDXjdD\nSkRGG9CDy6WO2piDF2faPYXmyJOh3GCUZF0URxCtW6GRRgBCfrHu8JOqlASg13WJ\nCuWJXtlwXTBQOwxaTbAJyWDPrwKBgQDin+rePNJVBqFuNmcuGlDqnsVZ0Qk7Vxir\nzXolWQcJckXyQLkOKiAlg5NrvNfNTlLCfL61fbQ/yoJXMVzN49tS6AN4ZD2DXZaR\nuPks5SHDDU06fj8DBmj/uaTkXT6qiSfllRhbD6j6WPI6bxp6CueuNZI3URu0mvyc\nW3S/jMoVYwKBgEVosOVubaWFhmU8cJB0B0MpqxgWajhvp3H/cZxB0wr8+endA6SY\n6MNI4ifp7my5Jrny92v72iAQfN2TtiTqTBNKNEOnOiP7GO6fpBUBIFyr+RjWuunw\n2GKsGMgAhMoXbmdah0Wq7OxZWF1fwLJwQ5vlEaQuj0F7DOhN3hdFrnW9AoGBAIs+\nz0U2AdaUeGQLsWI2cTl3zLLfKdj4LwSBAGgqR5SaTjgHZK07XP0v10j/g2l2kotF\nsrg5QKNhfqyse+VV99D9FgTHMrSgsH9hNFlNgG0koyspnvXw3lsiahqW4IZQN99s\nuMZa3OzV8h/NXGtYf/oemHS8tVVHVaeM2jNIAnMZAoGAdtBn6AXMX4K73aGRxL/k\nBo3dIkeZL4cyCGq9CJ87QWMk/bbnLp+HJ2pIddF+LBDjvKkfkZkcb9+PITYczMgP\n29/Bkkunl0LhapPUanz5NVsN2jB9Emj7WdC12USMBiIZgT76QPnzBPPjS8/TMk7L\nQHktInxnHgFG6BIUw5YQ3dc=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-bgvce@whatasapp-shourya.iam.gserviceaccount.com",
          "client_id": "104667074155850380161",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-bgvce%40whatasapp-shourya.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
