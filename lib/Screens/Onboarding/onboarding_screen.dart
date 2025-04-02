import 'package:flutter/material.dart';
import 'package:jop_project/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:jop_project/Providers/locale_provider.dart';
import 'package:jop_project/Screens/Onboarding/onboarding_contents.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/size_config.dart';
import '../../components/custom_animated_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Colors.white,
    Colors.white,
    Colors.white,
    // Color(0xffDAD3C8),
    // Color(0xffFFE5DE),
    // Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: kPrimaryColor,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) =>
                          setState(() => _currentPage = value),
                      itemCount: contents.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                contents[i].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w600,
                                  fontSize: (width <= 550) ? 30 : 35,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                // Wrap the Image.asset with Expanded
                                child: Image.asset(
                                  contents[i].image,
                                  // Remove fixed height here, let it be flexible
                                ),
                              ),
                              SizedBox(
                                height: (height >= 840) ? 20 : 10,
                              ),
                              Text(
                                contents[i].desc,
                                style: TextStyle(
                                  color: kOnboardingTextColor,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.bold,
                                  fontSize: (width <= 550) ? 20 : 25,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (int index) => _buildDots(
                              index: index,
                            ),
                          ),
                        ),
                        _currentPage + 1 == contents.length
                            ? Padding(
                                padding: const EdgeInsets.all(30),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    localeProvider.setSeenOnboarding(true);
                                    // if (!localeProvider
                                    //     .isLodingSeenOnboarding) {
                                    //   Navigator.pushReplacement(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const WelcomeScreen(),
                                    //       ));
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 10)
                                        : EdgeInsets.symmetric(
                                            horizontal: width * 0.2,
                                            vertical: 25),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 18 : 22),
                                  ),
                                  child: Text(l10n.startnow),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _controller.jumpToPage(2);
                                      },
                                      style: TextButton.styleFrom(
                                        elevation: 0,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: (width <= 550) ? 13 : 17,
                                        ),
                                      ),
                                      child: Text(
                                        l10n.skip,
                                        style: const TextStyle(
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                        elevation: 0,
                                        padding: (width <= 550)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 25),
                                        textStyle: TextStyle(
                                            fontSize: (width <= 550) ? 13 : 17),
                                      ),
                                      child: const Icon(Icons.arrow_forward),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
              if (localeProvider.isLodingSeenOnboarding) ...[
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: const Color.fromARGB(63, 158, 158, 158),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AnimatedProgressBar(),
                        Text('يرجى الإنتظار ...',
                            style: AppTheme.lightTheme.textTheme.bodyLarge)
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        );
      }),
    );
  }
}
