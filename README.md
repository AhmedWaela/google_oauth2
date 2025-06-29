
# google_oauth2_flutter

A Flutter package that enables OAuth 2.0 authorization with Google to obtain access tokens and interact with Google APIs on behalf of the user.

✅ Supports:
- **Android**
- **Web**
- **Windows**

> 🔒 This package simplifies the Google OAuth 2.0 flow across platforms.

---

## 🛠 Features

- Easy Google Sign-In with OAuth 2.0
- Custom success, failure, and loading UI support
- Built-in handling of `access_token`, `id_token`, and authorization code
- Works on both mobile (Android) and desktop (Windows), as well as the web

---

## 🚀 Usage

### 1. Sign in with Google (Android & Windows)

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      return GoogleOAuthView(
        setup: GoogleAuthSetup(
          clientId: clientId,
          clientSecret: clientSecret,
          redirectUri: redirectUri,
          scopes: scopes,
          loginHint: loginHint,
          onSuccess: (tokens) {
            // Handle tokens here
          },
          onError: (error) {
            // Handle error here
          },
          appBarTitle: 'Sign in with Google',
          centerTitle: true,
          loadingWidget: CircularProgressIndicator(),
          failureWidget: Text('Login failed'),
          successWidget: Text('Login successful'),
        ),
      );
    },
  ),
);
````

---

### 2. Google Sign-In Flow (Web Only)

```dart
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    WebGoogleAuth.listenToRequestUrl(
      setup: GoogleAuthSetup(
        clientId: dotenv.env["GoogleClientId"]!,
        clientSecret: dotenv.env["GoogleClientSecret"]!,
        redirectUri: redirectUri,
        onSuccess: (tokens) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(tokens.accessToken),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            WebGoogleAuth.startSignin(
              setup: GoogleAuthSetup(
                clientId: dotenv.env["GoogleClientId"]!,
                clientSecret: dotenv.env["GoogleClientSecret"]!,
                redirectUri: redirectUri,
              ),
            );
          },
          icon: Icon(Icons.login),
        ),
      ),
    );
  }
}
```

---

## 📚 Learn More

Read this article to understand the Google OAuth 2.0 flow in detail:
👉 [How to Access Google APIs via OAuth 2.0](https://medium.com/@ahmedwael99104/how-to-access-google-apis-via-oauth-2-0-23028813c40f)

---