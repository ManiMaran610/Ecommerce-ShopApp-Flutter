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
  TextEditingController _DiscriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editedproducts =
      Product(title: '', description: '', price: 0, imageUrl: '', id: '');
  @override
  void initState() {
    _imageFocusNode.addListener(UpdateImg);

    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final addProduct = Provider.of<Products>(context);
    void _saveForm() {
      if (_form.currentState!.validate()) {
        print(_form.currentState!.validate().toString());
        _form.currentState!.save();
        _editedproducts = Product(
            title: _titleController.text,
            description: _DiscriptionController.text,
            price: double.parse(_priceController.text),
            imageUrl: _imageController.text,
            id: _editedproducts.id);
        addProduct.addproducts(_editedproducts);

        Navigator.of(context).pop();
      }

      print(_editedproducts.title);
      print(_editedproducts.description);
      print(_editedproducts.price);
    }

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
        child: Padding(
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
                  controller: _DiscriptionController,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ImageUrl'),
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
