import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tictactoe/utils/app_routes.dart';
import 'package:tictactoe/utils/screen_argument.dart';

class IntroductionScreen extends StatelessWidget{
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _introductionBody(context),
    );
  }

  Widget _introductionBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tic Tac Toe",
              style: GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _introductionButton(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        AppRoutes.game,
                        arguments: ScreenArgument<bool>(true)
                      );
                    },
                    label: "VS Bot"
                ),
                _introductionButton(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        AppRoutes.game,
                        arguments: ScreenArgument<bool>(false)
                      );
                    },
                    label: "VS Player 2"
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _introductionButton({required void Function() onTap, required String label}){
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 18.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}