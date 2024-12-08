import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/property/property_bloc.dart';
import 'blocs/property/property_event.dart'; // Import PropertyEvent
import 'screens/property_screen.dart';

void main() {
  runApp(PropertyManagementApp());
}

class PropertyManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyBloc()..add(LoadProperties()), // Trigger loading
      child: MaterialApp(
        title: 'Property Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PropertyScreen(),
      ),
    );
  }
}
