// import 'package:flutter/material.dart';
// import 'package:plimsy/widgets/menus/menu_calculate.dart';
// import 'package:plimsy/widgets/menus/menu_fixed.dart';
// import 'package:plimsy/widgets/menus/menu_liquids.dart';

// class MenuSafety extends StatefulWidget {
//   const MenuSafety({super.key});

//   @override
//   State<MenuSafety> createState() {
//     return _MenuSafety();
//   }
// }

// class _MenuSafety extends State<MenuSafety> with TickerProviderStateMixin {
//   String showSecondMenu = "";

//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     // Imposta l'AnimationController per l'animazione di scorrimento
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0), // Da destra all'interno della Row
//       end: Offset.zero, // Arriva alla posizione normale
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//   }

//   void changeTabMenu(value) {
//     setState(() {
//       if (value == showSecondMenu) {
//         showSecondMenu = "";
//         _controller.reverse();
//       } else if (value == "fixed") {
//         showSecondMenu = "fixed";
//         _controller.forward();
//       } else if (value == "calculate") {
//         showSecondMenu = "calculate";
//         _controller.forward();
//       } else if (value == "liquids") {
//         showSecondMenu = "liquids";
//         _controller.forward();
//       } else {
//         showSecondMenu = "";
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Column(
//       children: [
//         AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Image.asset("assets/img/nav-icon/go-back.png"),
//             ),
//           ),
//           toolbarHeight: height * 0.1,
//           backgroundColor: const Color.fromRGBO(1, 57, 75, 0.6),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const Text(
//                 "Safety Page",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "assets/img/nav-icon/liquid-weights.png",
//                             width: 50,
//                           ),
//                           Text(
//                             "Liquids",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: showSecondMenu == "liquids"
//                                     ? Colors.black
//                                     : Colors.white),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         changeTabMenu("liquids");
//                       },
//                     ),
//                     AnimatedSize(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut,
//                       child: showSecondMenu == "liquids"
//                           ? SlideTransition(
//                               position: _slideAnimation,
//                               child: const MenuLiquids(),
//                             )
//                           : Container(),
//                     ),
//                     SizedBox(
//                       width: width * 0.2,
//                       child: Image.asset(
//                         "assets/img/nav-icon/arrows.png",
//                         width: 25,
//                       ),
//                     ),
//                     InkWell(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "assets/img/nav-icon/solid-weights.png",
//                             width: 50,
//                           ),
//                           Text(
//                             "Fixed weights",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: showSecondMenu == "fixed"
//                                     ? Colors.black
//                                     : Colors.white),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         changeTabMenu("fixed");
//                       },
//                     ),
//                     AnimatedSize(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut,
//                       child: showSecondMenu == "fixed"
//                           ? SlideTransition(
//                               position: _slideAnimation,
//                               child: const MenuFixed(),
//                             )
//                           : Container(),
//                     ),
//                     SizedBox(
//                       width: width * 0.2,
//                       child: Image.asset(
//                         "assets/img/nav-icon/arrows.png",
//                         width: 25,
//                       ),
//                     ),
//                     InkWell(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "assets/img/nav-icon/calculation.png",
//                             width: 50,
//                           ),
//                           Text(
//                             "Calculation",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: showSecondMenu == "calculate"
//                                     ? Colors.black
//                                     : Colors.white),
//                           ),
//                         ],
//                       ),
//                       onTap: () {
//                         changeTabMenu("calculate");
//                       },
//                     ),
//                     AnimatedSize(
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut,
//                       child: showSecondMenu == "calculate"
//                           ? SlideTransition(
//                               position: _slideAnimation,
//                               child: const MenuCalculate(),
//                             )
//                           : Container(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
