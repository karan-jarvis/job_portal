import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/job_listing/logic.dart';
import 'package:job_portal/screens/job_listing/model.dart';

void showHomeBottomSheet({
  required BuildContext context,
  required Photo photo,
  required int index,
}) {
  HomeController controller = Get.find();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height *
            0.7, // Set the height to half of the screen
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50), // Space for the logo
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                photo.title.split(' ').take(2).join(' '),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Silicon Valley, CA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Tech-based company and the producer",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Position",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Senior UI/UX Designer",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      18, // Increase the font size of the description
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '''Applicants must have at least up to 10 years of design experience and must be familiar with some design tools. We are seeking a responsible for developing high-quality software solutions.''',
                                style: TextStyle(
                                  fontSize: 16, // Increase the font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white,
                                ],
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
            Positioned(
              top: 0,
              left: 20,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    photo.thumbnailUrl, // Replace with your image URL or asset
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20, // Stick the button to the bottom of the screen
              left: 30,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  if (controller.bottomId.contains(index)) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Already Applied For This Job'),
                        backgroundColor: Colors.grey,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    controller.updateIconColor(index);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Job Applied Successfully'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: controller.bottomId.contains(index)
                        ? Colors.grey
                        : Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      controller.bottomId.contains(index)
                          ? "Already Applied"
                          : "APPLY NOW",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
