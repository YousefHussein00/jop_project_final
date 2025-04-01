import 'package:flutter/material.dart';
import 'package:jop_project/constants.dart';

class BackgroundProfile extends StatelessWidget {
  final Widget child;
  final String title;
  final bool isButtom;
  final bool isProfileImage;
  final String? imageSrc;
  final List<Widget>? actions;
  final VoidCallback? onExportPDF;
  final VoidCallback? onSave;

  const BackgroundProfile({
    super.key,
    required this.child,
    required this.title,
    this.isButtom = false,
    this.actions,
    this.onExportPDF,
    this.isProfileImage = false,
    this.imageSrc,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 252, 252, 252),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(defaultPadding),
                                  topRight: Radius.circular(defaultPadding),
                                  bottomLeft: Radius.circular(defaultPadding),
                                  bottomRight: Radius.circular(defaultPadding),
                                )),
                            child: SafeArea(child: child)),
                        if (isProfileImage)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            // child: CircleAvatar(

                            //   radius: 80,
                            //   backgroundImage: imageSrc == null
                            //       ? const AssetImage(
                            //           'assets/images/profile.png',
                            //         )
                            //       : NetworkImage(imageSrc!),
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:
                                      //  imagePath != null && imagePath != ''
                                      //     ?
                                      Image.network(
                                    imageSrc ?? '',
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? (loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!)
                                                  .toStringAsFixed(2)
                                              : ''),
                                          // const CircularProgressIndicator(),
                                        ],
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/profile.png',
                                      );
                                    },
                                  ),
                                  // : const Icon(
                                  //     Icons.person,
                                  //     size: 50,
                                  //   ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isButtom && onSave != null)
              Positioned(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    // width: SizeConfig.screenW! / 1.5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 71, 130),
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: onSave,
                        child: const Text(
                          'حفظ',
                          // 'اكمال ادخال البيانات',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ),
            if (isButtom && onExportPDF != null)
              Positioned(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        side: const BorderSide(color: Colors.white),
                      ),
                      onPressed: onExportPDF,
                      icon:
                          const Icon(Icons.picture_as_pdf, color: Colors.white),
                      label: const Text(
                        'حفظ بياناتي PDF',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
