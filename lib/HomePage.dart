import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_list_makeing_app/signIn.dart';
import 'Walkthrough-screens/Page1.dart';
import 'Walkthrough-screens/Page2.dart';
import 'Walkthrough-screens/Page3.dart';
import 'Walkthrough-screens/Page4.dart';
import 'login-screen.dart';

class HomePage extends StatelessWidget {
	final _controller = PageController();
	bool isLastPage = false;

@override
Widget build(BuildContext context) {
	return Scaffold(
		//backgroundColor: Colors.deepPurple[200],
		body: Column(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				// page view
				SizedBox(
					height: 550,
					child: PageView(
						onPageChanged: (index) {
						setState(() => isLastPage = index == 4);
						//after spalsh screen login page loading
						Timer(Duration(seconds: 3), () {
							Navigator.of(context)
									.pushReplacement(MaterialPageRoute(builder: (_) => SignInScreen()));
						});
						},
						controller: _controller,
						children: const [
							Page1(),
							Page2(),
							Page3(),
							Page4(),
						],
					),
				),

				// dot indicators
				SmoothPageIndicator(
					controller: _controller,
					count: 4,
					effect: JumpingDotEffect(
						activeDotColor: Colors.deepPurple,
						dotColor: Colors.deepPurple.shade100,
						dotHeight: 30,
						dotWidth: 30,
						spacing: 16,
						//verticalOffset: 50,
						jumpScale: 3,
					),
				),
			],
		),
		bottomSheet: Container(
			padding: const EdgeInsets.symmetric(horizontal: 30),
			height: 40,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					TextButton(onPressed: () => _controller.jumpToPage(0) ,
							child: const Text('Skip')),
					TextButton(onPressed: () => _controller.nextPage(
							duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
							child: const Text('Continue'),
					)
				],
			),
		),
	);
}

  void setState(bool Function() param0) {}
}