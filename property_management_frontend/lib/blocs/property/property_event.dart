import 'package:equatable/equatable.dart';
import '../../models/property_model.dart';

abstract class PropertyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProperties extends PropertyEvent {}

class AddProperty extends PropertyEvent {
  final Property property;

  AddProperty(this.property);

  @override
  List<Object?> get props => [property];
}

class DeleteProperty extends PropertyEvent {
  final String propertyId;

  DeleteProperty(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}
