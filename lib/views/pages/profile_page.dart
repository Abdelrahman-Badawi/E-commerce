import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logOut(AuthController model, context) async {
    try {
      await model.logOut();
      Navigator.of(context);
    } catch (e) {
      debugPrint('logOut Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, model, __) => Column(
        children: [
          const Spacer(),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: MainBotton(
                onTap: () {
                  _logOut(model, context);
                },
                text: 'Log Out'),
          ),
        ],
      ),
    );
  }
}
