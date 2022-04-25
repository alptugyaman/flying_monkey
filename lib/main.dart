import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'core/init/navigation/navigation_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'view/splash/view/splash_view.dart';

Future<void> main() async {
  await _init();

  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
          theme: ThemeData.dark(),
          home: const SplashView(),
          // theme: ThemeData.dark(),
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          navigatorKey: NavigationManager.instance.navigatorKey,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//       stream: task.snapshotEvents,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final snap = snapshot.data!;
//           final progress = snap.bytesTransferred / snap.totalBytes;
//           final percentage = (progress * 100).toStringAsFixed(2);

//           return Text(
//             '$percentage %',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
// }

