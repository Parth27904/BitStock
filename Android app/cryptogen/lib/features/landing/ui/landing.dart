import 'package:carousel_slider/carousel_slider.dart';
import 'package:cryptogen/features/navbar/ui/navBar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}


class _LandingState extends State<Landing> {
  int activeIndex = 0;
  final urlImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/CryptoGEN.gif'),fit: BoxFit.cover)
      ),
      child: Column(
        children: [
          const SizedBox(height: 250,),
          Center(
            child: SizedBox(
              height: 400,
              width: 500,
              child: Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: urlImages.length,
                      options: CarouselOptions(height: 300,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      onPageChanged: (index,reason){
                        setState(() {
                          activeIndex = index;
                        });
                      }),
                      itemBuilder: (context,index,realIndex){
                        final urlImage = urlImages[index];
                        return buildImage(urlImage,index);
                      },
                  ),
                  const SizedBox(height: 10,),
                  buildIndicator(),
                ],
              ),
            ),
          ),
          Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.orange,),
              borderRadius: BorderRadius.circular(25)
            ),
            child: TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavBar()));
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Get Started',style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20
                    ),),
                    Icon(Icons.arrow_forward,
                    color: Colors.orange,
                    size: 25,)
                  ],
                )),
          )
        ],
      ),
    );
  }
  Widget buildImage(String urlImage, int index) => Container(
    height: 200,
    width: 500,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    color: Colors.transparent,
    child: Image.asset(urlImage,fit: BoxFit.fill,),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      effect: const JumpingDotEffect(
        dotWidth: 20,
        dotHeight: 20,
        activeDotColor: Colors.orange,
        dotColor: Colors.black
      ),
  );
}

