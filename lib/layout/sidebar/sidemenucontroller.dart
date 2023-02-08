import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SideMenuController extends GetxController {
  static SideMenuController instance = Get.find();
  var activeItem = "ProjectHome".obs;
  var projectId = GetStorage();
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  getProjectId(String pid){
    projectId.write('projectId', pid);
  }
}
