import 'package:blood_glucose/data/remote/resource.dart';
import 'package:blood_glucose/data/repo/model/filter_data_request.dart';

import 'model/samples_data_model.dart';

abstract class BloodGlucoseRepository{

 Future<Resource> loadSamples();

 Future<Resource<SamplesDataModel>> filterData( FilterDataRequest request); 
}



