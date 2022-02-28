import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget{

  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      {this.onPressed}
      );

  final IconData icon;
  final double size;
  final Gradient gradient;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
          width: size* 1.2,
          height: size*1.2,
          child: IconButton(
            icon: Icon(icon, size : size, color: white,),
             onPressed:(){}
          )
          
          


      ),
      shaderCallback: (Rect bounds){
        final Rect rect = Rect.fromLTRB(0,0,size,size);
        return gradient.createShader(rect);
      },
    );
  }

}