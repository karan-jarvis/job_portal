import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/job_listing/model.dart';
import 'package:job_portal/screens/job_listing/widgets.dart';
import 'package:job_portal/screens/login/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic.dart';

class JobListingPage extends StatefulWidget {
  JobListingPage({super.key});

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.fetchPhotos();
    super.initState();
  }
  // final logic = Get.put(JobListingLogic());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var sharedPref =
                                await SharedPreferences.getInstance();
                            sharedPref.clear();
                            Get.to(() => LoginScreen());
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
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
                              hintText: "Search here",
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
                          Photo photo = homeController.filteredPhotos[index];
                          final truncatedTitle =
                              photo.title.split(' ').take(2).join(' ');
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Card(
                              child: InkWell(
                                onTap: () {
                                  showHomeBottomSheet(
                                      context: context,
                                      index: index,
                                      photo: photo);
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
      ),
    );
  }
}
