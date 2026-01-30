import 'package:get/get.dart';

import '../../../ApiModel/seller/AttributeAddProductModel.dart';
import '../../../ApiService/seller/attributes_add_product_service.dart';

class AttributesAddProductController extends GetxController {
  AttributeAddProductModel? attributeAddProduct;
  var isLoading = true.obs;

  RxMap<String, List<String>> selectedValuesByType = <String, List<String>>{}.obs;

  void toggleSelection(String value, String type) {
    if (selectedValuesByType[type]?.contains(value) ?? false) {
      selectedValuesByType[type]?.remove(value);
    } else {
      if (selectedValuesByType[type] == null) {
        selectedValuesByType[type] = <String>[value];
      } else {
        selectedValuesByType[type]?.add(value);
      }
    }
  }

  getAttributesData() async {
    try {
      isLoading(true);
      var data = await AttributesAddProductApi().productAttributes();
      attributeAddProduct = data;
    } catch (e) {
      Exception(e);
    } finally {
      isLoading(false);
    }
  }
}
