import 'dart:io';

import 'package:firesbase_test/config/constants/constants.dart';
import 'package:firesbase_test/features/product_list/data/models/product_model.dart';
import 'package:firesbase_test/features/product_list/presentation/bloc/cubit/imageupload_cubit.dart';
import 'package:firesbase_test/features/product_list/presentation/bloc/cubit/product_cubit.dart';
import 'package:firesbase_test/features/product_list/presentation/widgets/custom_appbar.dart';
import 'package:firesbase_test/features/product_list/presentation/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

class ProductCreationScreen extends StatelessWidget {
  ProductCreationScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ValueNotifier<List<File>> selectedImages = ValueNotifier([]);

//List selectedImages= [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomappbarWidget(
            title: 'Add Product',
          )),
      body: ValueListenableBuilder(
          valueListenable: selectedImages,
          builder: (context, imagelist, Child) {
            return BlocBuilder<ImageuploadCubit, ImageuploadState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomtextFormField(
                          label: 'Product Name ',
                          title: 'Product Name:',
                          controller: nameController),
                      CustomtextFormField(
                        label: "Product Size",
                        title: 'Size:',
                        controller: sizeController,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Price"),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.money)),
                        ),
                      ),
                      imagelist.isEmpty
                          ? SizedBox(
                              width: getscreenwidth(context) * .5,
                              height: getScreenHeight(context) * .1,
                              child: const Card(
                                child: Center(child: Text('No image selected')),
                              ))
                          : LimitedBox(
                              maxHeight: 200,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 10,
                                ),
                                itemCount: imagelist.length,
                                itemBuilder: (context, index) => SizedBox(
                                  child: Center(
                                      child: Card(
                                    child:
                                        Image.file(File(imagelist[index].path)),
                                  )),
                                ),
                              ),
                            ),
                      IconButton(
                        onPressed: () async {
                          var images =
                              await BlocProvider.of<ImageuploadCubit>(context)
                                  .UploadImages();
                          selectedImages.value = selectedImages.value + images;
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 40,
                        ),
                      ),
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductUploadLoading) {
                            return const LimitedBox(
                              maxHeight: 30,
                              maxWidth: 30,
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is ProductuploadFailure) {
                            return Text('Upload Failed');
                          }
                          if (state is ProductInitial) {
                            return ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.upload),
                              label: const Text('Create'),
                            );
                          }
                          return ElevatedButton.icon(
                            onPressed: () {

                              if(nameController.text.isEmpty){
                                showflutterToast("please Enter product Name");
                                return;
                              }
                              if(sizeController.text.isEmpty){
                                 showflutterToast("please Enter product size");
                                return;
                              }
                              if(priceController.text.isEmpty){
                                 showflutterToast("please Enter product price");
                                return;
                              }

                              var images = selectedImages.value
                                  .map((e) => File(e.path))
                                  .toList();
                              BlocProvider.of<ProductCubit>(context)
                                  .uploadImagesTofirebase(images)
                                  .then((value) {
                                BlocProvider.of<ProductCubit>(context)
                                    .uploadProductDetails(ProductDetailsModel(
                                        productname: nameController.text,
                                        measurement: sizeController.text,
                                        price: priceController.text,
                                        imageUrls: value));
                              });
                            },
                            icon: const Icon(Icons.upload),
                            label: const Text('Create'),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  getImageFromGallery() async {
    final picker = ImagePicker();

    try {
      final pickedImages = await picker.pickMultiImage(
          maxHeight: 1000, maxWidth: 1000, imageQuality: 100);
      List<XFile> XfilePicked = pickedImages;

      if (XfilePicked.isNotEmpty) {
        XfilePicked.forEach((element) {
          selectedImages.value.add(File(element.path));
        });
      }

      //  print(selectedImages);
    } catch (e) {
      print(e);
    }
  }


    showflutterToast(String message) async {
    await Fluttertoast.showToast(msg: message, textColor: Colors.red);
  }
}