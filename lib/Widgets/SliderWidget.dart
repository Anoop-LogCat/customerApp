import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {

  List<Slide> slide = List();

  @override
  void initState() {
    super.initState();
    slide.add(
      new Slide(
        backgroundImage: 'assets/small_shops_slider.jpg',
        backgroundOpacity: 0
      ),
    );
    slide.add(
      new Slide(
        backgroundImage: 'assets/Girls vector slider.png',
        backgroundOpacity: 0
      ),
    );
    slide.add(
      new Slide(
        backgroundImage: 'assets/Girls vector slider.png',
        backgroundOpacity: 0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slide,
      isShowNextBtn: false,
      isShowSkipBtn: false,
      isShowDoneBtn: false,
    );
  }
}