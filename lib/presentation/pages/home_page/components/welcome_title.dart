import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

import '../../../auth_cubit/auth_cubit.dart';

class WelcomeTitle extends StatefulWidget {
  final bool isReminderNeeded;

  const WelcomeTitle({super.key, required this.isReminderNeeded});

  @override
  State<WelcomeTitle> createState() => _WelcomeTitleState();
}

class _WelcomeTitleState extends State<WelcomeTitle> with TickerProviderStateMixin {
  var _isReminderVisible = false;
  var titleAlignment = Alignment.center;
  late AnimationController _bellAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));


  @override
  void initState() {
    _bellAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  void _runAnimation() async {
    for(int i = 0; i <3; i++) {
      if(mounted) {
        await _bellAnimationController.forward();
        await _bellAnimationController.reverse();
      }
    }
    Future.delayed(const Duration(seconds: 2), (){
      _runAnimation();
    });
  }

  @override
  void dispose() {
    _bellAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future((){
      if(widget.isReminderNeeded) {
        setState(() {
          titleAlignment = Alignment.centerLeft;
        });
      } else{
        setState(() {
          titleAlignment = Alignment.center;
          _isReminderVisible = false;
        });
      }
    });
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 40,
        minHeight: 40
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            alignment: titleAlignment,
            duration: const Duration(milliseconds: 200),
            child: Text(
              'Здравствуйте, ${context.read<AuthCubit>().state.userData!.firstName}!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onEnd: (){
              setState(() {
                _isReminderVisible = true;
                _runAnimation();
              });
            },
          ),
          if(_isReminderVisible)
          Align(
            alignment: Alignment.centerRight,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: -0.1)
              .chain(CurveTween(curve: Curves.elasticIn))
              .animate(_bellAnimationController),
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.add_alert, color: AppColors.primaryAccentRed,),
                onPressed: () {
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
