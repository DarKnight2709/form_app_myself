import 'package:flutter/material.dart';
import 'package:form_app_myself/screens/autofill.dart';
import 'package:form_app_myself/screens/form_widgets.dart';
import 'package:form_app_myself/screens/mock/mock_http.dart';
import 'package:form_app_myself/screens/sign_in_with_http.dart';
import 'package:form_app_myself/screens/validation.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

final demos = [
  Demo(
    name: 'Sign in with http',
    path: 'sign_in_with_http',
    builder: (context) =>  SignInWithHttp(
      client: httpClient,
    ),
  ),
  Demo(
    name: 'Autofill',
    path: 'autofill',
    builder: (context) =>  Autofill(),
  ),
  Demo(
    name: 'Form widgets',
    path: 'form_widgets',
    builder: (context) => const FormWidgets(),
  ),
  Demo(
    name: 'Validation',
    path: 'validation',
    builder: (context) => const Validation(),
  )

];

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
    for(final demo in demos)
      GoRoute(
        name: demo.name,
        path: demo.path,
        builder: (context, state) => demo.builder(context)
        
      )
  ])
]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form Samples"),
        ),
        body: ListView.builder(
          itemCount: demos.length,
          itemBuilder: (context, index) => DemoTile(demo: demos[index]),
        ));
  }
}

class DemoTile extends StatelessWidget {
  final Demo demo;
  const DemoTile({super.key, required this.demo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demo.name),
      onTap: () => context.go('/${demo.path}')
    );
  }
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Form App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: router,
    );
  }
}

class Demo{
  final String name;
    final String path;
  final WidgetBuilder builder;

  Demo({required this.name, required this.path, required this.builder});
}