import 'package:udemy_flutter/models/list_technical_model.dart';
import 'package:udemy_flutter/services/list_technical_api.dart';



class TechnicalController {
  Future<List<TechnicalUser>> getTechnicalUsers() {
    return TechnicalApi.fetchTechnicalUsers();
  }
}
