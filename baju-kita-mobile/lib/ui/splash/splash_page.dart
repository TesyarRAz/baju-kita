import 'package:bajukita/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> iconAnimation;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    iconAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(animationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home,
          (route) => false,
        );
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: AnimatedBuilder(
          animation: iconAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: iconAnimation.value,
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/about.jpg',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
