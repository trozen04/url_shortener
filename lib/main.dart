import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_project/ApiServices/shrink_zap_bloc.dart';
import 'package:url_shortener_project/Screens/Splash.dart';
import 'Widgets/ReviewService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShrinkZapBloc>(create: (context) => ShrinkZapBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(
          onAppStart: () => const ReviewService().handleReviewFlow(),  // ✅ This is all you need now!
        ),
      ),
    );
  }
}
