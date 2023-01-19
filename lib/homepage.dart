import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:some_client/api/user_api.dart';
import 'package:some_client/screens/cards_screen.dart';
import 'package:some_client/user.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Future<String> _handleUserLogin() async {
    User user = User();
    String uuid = await user.getUserUUID();
    uuid = '4a53b8d3-b83b-431a-848d-dc554f9a0d7e';
    if (uuid.isNotEmpty) {
      debugPrint("User already has UUID $uuid");
      if (await authenticateUser(uuid)) {
        return uuid;
      }
    }
    uuid = user.generateUserUUID();
    await signUpUser(uuid);
    return uuid;
  }

  // Should get array of available cards and load them into the cards screen

  @override
  Widget build(BuildContext context) {
    final userUUID = useState<String>('');
    useEffect(() {
      _handleUserLogin().then((uuid) {
        userUUID.value = uuid;
      });
      return null;
    }, []);
    return Scaffold(
      body: userUUID.value.isNotEmpty
          ? CardsScreen(
              userUUID: userUUID.value, merchantId: "63c44d6716dea371c849c2fa")
          : const CircularProgressIndicator(),
    );
  }
}
