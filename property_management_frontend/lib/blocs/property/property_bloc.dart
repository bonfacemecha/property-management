import 'package:flutter_bloc/flutter_bloc.dart';
import 'property_event.dart';
import 'property_state.dart';
import '../../models/property_model.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<LoadProperties>((event, emit) async {
      emit(PropertyLoading());
      // Dummy data
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      emit(PropertyLoaded([
        Property(id: '1', name: 'Villa Sunrise', address: '123 Main St', price: 250000),
        Property(id: '2', name: 'Oceanview Apartment', address: '456 Beach Ave', price: 300000),
       Property(id: '3', name: 'Oceanview Apartment2', address: '456 Beach2 Ave', price: 300000),

      ]));
    });

    on<AddProperty>((event, emit) {
      if (state is PropertyLoaded) {
        final currentState = state as PropertyLoaded;
        final updatedList = List<Property>.from(currentState.properties)..add(event.property);
        emit(PropertyLoaded(updatedList));
      }
    });

    on<DeleteProperty>((event, emit) {
      if (state is PropertyLoaded) {
        final currentState = state as PropertyLoaded;
        final updatedList = currentState.properties.where((p) => p.id != event.propertyId).toList();
        emit(PropertyLoaded(updatedList));
      }
    });
  }
}
