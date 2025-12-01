import '../entities/destination_entity.dart';

abstract class DestinationRepository {
  Future<List<DestinationEntity>> getDestinations();
  Future<List<DestinationEntity>> searchDestinations(String query);
  Future<DestinationEntity?> getDestinationById(String id);
}
