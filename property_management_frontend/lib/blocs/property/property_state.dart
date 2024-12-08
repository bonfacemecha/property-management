import 'package:equatable/equatable.dart';
import '../../models/property_model.dart';

abstract class PropertyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyLoaded extends PropertyState {
  final List<Property> properties;

  PropertyLoaded(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyError extends PropertyState {
  final String message;

  PropertyError(this.message);

  @override
  List<Object?> get props => [message];
}
