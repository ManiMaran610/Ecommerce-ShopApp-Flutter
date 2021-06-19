import 'package:flutter/material.dart';
import 'package:flutter_app1/modals/Products.dart';
import 'package:provider/provider.dart';

import 'Providers/ProviderProducts.dart';

class EditScreen extends StatefulWidget {
  static const routename = '/edit';
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _imageFocusNode = FocusNode();

  TextEditingController _imageController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _discriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool isLoading = false;

  var _editedproducts =
      Product(title: '', description: '', price: 0, imageUrl: '', id: '');
  @override
  void initState() {
    _imageFocusNode.addListener(UpdateImg);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _imageController.removeListener(UpdateImg);
    _imageFocusNode.dispose();
    super.dispose();
  }

  void UpdateImg() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final products = Provider.of<Products>(context, listen: false);
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      setState(() {
        isLoading = true;
      });

      // _editedproducts.id.isNotEmpty
      //     ? products.updateProduct(_editedproducts.id, _editedproducts)
      //     :
      _editedproducts = Product(
          title: _titleController.text,
          description: _discriptionController.text,
          price: int.parse(_priceController.text),
          imageUrl: _imageController.text,
          id: DateTime.now().toString());
      products.addproducts(_editedproducts).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }

    print(_editedproducts.title);
    print(_editedproducts.description);
    print(_editedproducts.price);
  }

  // var _isInit = true;
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     final productId = ModalRoute.of(context)!.settings.arguments as String;
  //     print(productId);
  //     if (productId.isEmpty) {
  //       print('empty');
  //     } else {
  //       final product =
  //           Provider.of<Products>(context, listen: false).findbyId(productId);
  //       _editedproducts = product;
  //       _titleController.text = _editedproducts.title;
  //       _priceController.text = _editedproducts.price.toString();
  //       _discriptionController.text = _editedproducts.description;
  //       _imageController.text = _editedproducts.imageUrl;
  //     }
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Provide a title First ";
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Price'),
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter a Price';
                          }
                          if (int.parse(val) <= 0) {
                            return 'Price should be greater than 0';
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Discription'),
                        controller: _discriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Discription should not be empty';
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            height: 54,
                            width: 95,
                            child: _imageController.text.isEmpty
                                ? Text('Enter Url')
                                : FittedBox(
                                    child: Image.network(_imageController.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'ImageUrl'),
                              keyboardType: TextInputType.url,
                              controller: _imageController,
                              textInputAction: TextInputAction.none,
                              focusNode: _imageFocusNode,
                              onFieldSubmitted: (val) {
                                // _saveForm();
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter a Image Url';
                                }
                                if (!val.contains('http')) {
                                  return 'Enter a valid url';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Chip(label: Text('Submit')),
                        onTap: () {
                          _saveForm();
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
