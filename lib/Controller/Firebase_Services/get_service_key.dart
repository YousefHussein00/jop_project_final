import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    try {
      final scopes = [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/firebase.database',
        'https://www.googleapis.com/auth/firebase.messaging',
      ];

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "jop-project-6e8d3",
            "private_key_id": "5aed98cc3d44c459cae064f0408157c3389d697d",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCmcyvko54ZPOE7\nIcinmion3ukwYSqMUWL3pey0ys2sIKdUljpswSSVs/fCq4bg/GRHYkiBktTdF4k4\nPeK6f+LPzhel8OiWQq7/7aqWIgh6ouQ6SynKtSPq3iQLDo0GcpoG17Ykit7rlHy/\nuUXMO05b6iJQiAUCXV699UhQW69nF4jD+VURrzxFBU3sD49zW0D+LPPuIQbidjjh\nSBaWr5U3ON06AVsK1j9skrDgbSZqSTJ2pxffuKKfZeHQ5GUO5w08Tqeezs3NlTO5\nFEZkszsEAurO/DN93BPQCFPDUkiQDZYQ93dWwbkUAHPj0xRb9pmKCnbYqsJsSl4T\nvI+L/9m1AgMBAAECggEAArx3Rurpo8CRyJxlkAZuFaRfG6HSm+aP70JAVzh+PmDL\nCg5DfPDaiRt27Ib6pfgq2IGPxObaWPK/brfrDOXNSgfj8PZk3GjRjPjQimdE0b9G\na9mQdk9D/Thpn0TooefVtbHAwhkGURkVHpG3yVkFkL096H+pQBYI2Kvk5G1IFN8S\nBCqckHusWQi9yGWF3VfHVZbF579PSzOeIGq32eWwkMm1F+IPpqtpQU4RM8R5a09i\nPXiAS+HrGHxk7Ue1zCPukvxFTTmglDkBI7TheqHhGErlAS4luKo+IhTpzRlOI6Dr\n3wZcz5K3WwYl6GQIHzOIEDvbpK57J98seQxdNrc+gQKBgQDjiUXAIhI8G/jxDgRD\nYPM07eZKd5ZqAT8mZ48pjmoN/aGfdFMofQZajdjEkJOYV8dB4D8TeWJL4ELtr2+h\nZLSKsKgaD8X2gCjl/abuK4zLhm53Y5gle9e+ur8nJzDX9oQ7igw6cfMpCqGxoU4R\nE6EYFEVMPpsfKA1W50pAPGpoOwKBgQC7RaQzQAg1iWxTucYB4s7bQ2s3wVeDkfL0\nXkYrTUqlXm/S8FY6njF+/zRCDd4GhQKFnLmoHE5YE4j0XdHQsMG03LeX+b6XLf9O\ng4BjvrBSdalezsK7R7p6tYMuqpmzOrXUNAMKDr21U3fiSkvcfpg3D3PFFmNR6lac\nCCD673mWzwKBgA4E+T07XDBD8PS5Tl3wbUvHlLbl42iopwFwxAtlcPdntzuh6TXH\nbkrKDp8d4Voznl1aucgzZHEUYktO0ev5zn31IIZqjmH/x4VUOaLXIBeyMsA8bLVy\nifqAeyKocYP89mzMtrArMTZIJ2pQbAT1VqmrJhHqkZg72YaPPa3ziwLdAoGATOyG\nTib3OEaCoMGmfA/WOGqxF+3rLLg+u/IdkJvnFZZ9CICAawOgATKDHL7lfHgWWRvP\nhyZZaAReNUJ0dOymJMyk/WAw0ZirTmzlyBMEClsafz8e7h7AkrcMc5bQG7b6CXhz\n5yW290yZ6fHqx1+Y1sUaINLZaUSA3wbXxTupDjECgYBbR4AO4tN/ouzH3TZ9uo6G\nPhnXQQMQ/U4PVrPvl3fko9oo1IEghSoo5zhO9n+JM3kvRPWWMxN4hg+nhzp0eq83\noh6cpvY1YKqGB4/3zY/qMgY9AgRD8lgyfhggslLhHx5KbchfQ0JpZ6FXbSDVVgpD\n2cU1uOlGWm2W24viJIKKUQ==\n-----END PRIVATE KEY-----\n",
            "client_email":
                "firebase-adminsdk-fbsvc@jop-project-6e8d3.iam.gserviceaccount.com",
            "client_id": "110256562604526174216",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40jop-project-6e8d3.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          },
        ),
        scopes,
      );
      final accessServerKey = client.credentials.accessToken.data;
      return accessServerKey;
    } catch (e) {
      return e.toString();
    }
  }
}
