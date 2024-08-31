// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'routes.dart';
//
// class EnvironmentsBadge extends StatelessWidget {
//   final Widget child;
//   EnvironmentsBadge({required this.child});
//   @override
//   Widget build(BuildContext context) {
//     var env = ConfigEnvironments.getEnvironments()['env'];
//     return env != Environments.PRODUCTION
//         ? Banner(
//       location: BannerLocation.topStart,
//       message: env!,
//       color: env == Environments.QAS ? Colors.blue : Colors.purple,
//       child: child,
//     )
//         : SizedBox(child: child);
//   }
// }
//
// class Nav {
//   static List<GetPage> routes = [
//     GetPage(
//       name: Routes.HOME,
//       page: () => const HomeScreen(),
//       binding: HomeControllerBinding(),
//     ),
//     GetPage(
//         name: Routes.SPLASH,
//         page: () => const SplashScreen(),
//         binding: SplashControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.PAPER_HISTORY,
//         page: () => const PaperHistoryScreen(),
//         binding: PaperHistoryControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.CONTACT_US,
//         page: () => const ContactUsScreen(),
//         binding: ContactUsControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.ABOUT,
//         page: () => const AboutScreen(),
//         binding: AboutControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.TEACHERS_PROFILE,
//         page: () => const TeachersProfileScreen(),
//         binding: TeachersProfileControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.ONBOARD,
//         page: () => OnboardScreen(),
//         binding: OnboardControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.LEARNING,
//         page: () => const LearningScreen(),
//         binding: LearningControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.AUTH,
//         page: () => const AuthScreen(),
//         binding: AuthControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.STANDARD,
//         page: () => const StandardScreen(),
//         binding: StandardControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.LEARNING,
//         page: () => const LearningScreen(),
//         binding: LearningControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.STANDARD_WISE_SEM,
//         page: () => const StandardWiseSemScreen(),
//         binding: StandardWiseSemControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.VIEW_CHAPTER,
//         page: () => ViewChapterScreen(),
//         binding: ViewChapterControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.MY_SUBSCRIPTION,
//         page: () => const MySubscriptionScreen(),
//         binding: MySubscriptionControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     GetPage(
//         name: Routes.OUR_OTHER_APP,
//         page: () => const OurOtherAppScreen(),
//         binding: OurOtherAppControllerBinding(),
//         transition: Transition.cupertinoDialog,
//         transitionDuration: const Duration(milliseconds: 950)),
//     // GetPage(
//     //   name: Routes.REGISTER_TO_PURCHASE_BOOK,
//     //   page: () => const RegisterToPurchaseBookScreen(),
//     //   binding: RegisterToPurchaseBookControllerBinding(),
//     // ),
//     GetPage(
//       name: Routes.QUESTION_TYPE,
//       page: () => const QuestionTypeScreen(),
//       binding: QuestionTypeControllerBinding(),
//     ),
//     GetPage(
//       name: Routes.DOWNLOAD_MANAGER,
//       page: () => const DownloadManagerScreen(),
//       binding: DownloadManagerControllerBinding(),
//     ),
//
//     GetPage(
//       name: Routes.CUSTOM_PAPER,
//       page: () => const CustomPaperScreen(),
//       binding: CustomPaperControllerBinding(),
//     ),
//     GetPage(
//       name: Routes.QUESTION_SELECTION,
//       page: () => QuestionSelectionScreen(),
//       binding: QuestionSelectionControllerBinding(),
//     ),
//   ];
// }
