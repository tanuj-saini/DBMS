import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/errorModel.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/screens/HomeScreen.dart';
import 'package:whatsapp_complete/screens/LoginPage.dart';
import 'package:whatsapp_complete/screens/bottomNavigator.dart';
import 'package:whatsapp_complete/services/authService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Myapp();
  }
}

class _Myapp extends ConsumerState {
  ErrorModel? errorModel;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authServiceProvider).getUserData();
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        home: user != null ? bottomNav() : LoginScreen());
  }
}

  

  

  // This widget is the root of your application.
 


//  class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => RecommenderBloc()),
//         BlocProvider(create: (context) => ListRecommendedBloc()),
//         BlocProvider(create: (context) => AuthenticationBloc()..add(CheckAuthenticationEvent())),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (context, state) {
//             if (state is AuthenticatedState) {
//               return HomeScreen();
//             } else {
//               return StartScreen();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }