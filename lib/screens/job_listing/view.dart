import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/utils/colors.dart';

import 'logic.dart';

class JobListingPage extends StatefulWidget {

  JobListingPage({super.key});

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  final HomeController homeController = Get.put(HomeController());

  // final logic = Get.put(JobListingLogic());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          leading: const Icon(Icons.view_list),
          title: Obx(
            () {
              return homeController.isSearch.value
                  ? SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (value) =>
                            homeController.filterPhotos(value),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (homeController.isSearch.value) {
                  homeController.isSearch.value = false;
                  homeController.filterPhotos("");
                } else {
                  homeController.isSearch.value = true;
                }
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Find your dream Job today",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (homeController.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: homeController.filteredPhotos.length,
                      itemBuilder: (context, index) {
                        final photo = homeController.filteredPhotos[index];
                        final truncatedTitle =
                            photo.title.split(' ').take(2).join(' ');
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                _showBottomSheet(
                                    context: context, id: index, photo: photo);
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Image.network(
                                      photo.thumbnailUrl,
                                      height: 20,
                                    )),
                                title: Text(truncatedTitle),
                                subtitle: Text(
                                  photo.url,
                                  maxLines: 1,
                                ),
                                trailing: Obx(() {
                                  return Icon(
                                    Icons.stop_circle,
                                    color:
                                        homeController.bottomId.contains(index)
                                            ? Colors.green
                                            : Colors.indigo,
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet({
  required BuildContext context,
  required var photo,
  required int id,
}) {
  HomeController controller = Get.find();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    photo.title.split(' ').take(2).join(' '),
                    style: const TextStyle(
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        controller.star.value = !controller.star.value;
                        print(controller.star.value);
                      },
                      icon: controller.star.value
                          ? const Icon(
                              Icons.star,
                              color: Colors.orange,
                            )
                          : const Icon(Icons.star_border),
                    );
                  })
                ],
              ),
              Text(
                photo.url,
                maxLines: 1,
              ),
              Text("Flutter Developer"),
              Text("Flutter Developer"),
              Text("Flutter Developer"),
              Text("Flutter Developer"),
              GestureDetector(
                onTap: () {
                  // Update icon color
                  if (controller.bottomId.contains(id)) {
                    Navigator.pop(context);
                    // Show Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Already Applied For This Job'),
                        backgroundColor: Colors.grey,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  } else {
                    controller.updateIconColor(id);

                    // Close the bottom sheet
                    Navigator.pop(context);

                    // Show Snackbar
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
                  height: 55,
                  width: 390,
                  decoration: BoxDecoration(
                    color: controller.bottomId.contains(id)
                        ? Colors.grey
                        : Colors.blue, // Replace with your actual button color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      controller.bottomId.contains(id)
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
            ],
          ),
        ),
      );
    },
  );
}
