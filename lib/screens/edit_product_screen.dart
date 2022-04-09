import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final imgCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var product =
      Product(description: '', id: '', imageUrl: '', title: '', price: 0.0);
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    imgCtrl.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(product);
    Navigator.of(context).pop();
    // print(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add product"),
        actions: [
          IconButton(
            onPressed: () => _saveForm(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                // autovalidateMode: AutovalidateMode.always,  // run-time
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a value";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  product = Product(
                      id: product.id,
                      title: newValue as String,
                      description: product.description,
                      price: product.price,
                      imageUrl: product.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_descriptionNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a price";
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0.0) {
                    return "Please enter a valid price";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  product = Product(
                      id: product.id,
                      title: product.title,
                      description: product.description,
                      price: double.parse(newValue!),
                      imageUrl: product.imageUrl);
                },
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                // textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a value";
                  }
                  if (value.length <= 10) {
                    return "Min. 10 characters required";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  product = Product(
                      id: product.id,
                      title: product.title,
                      description: newValue!,
                      price: product.price,
                      imageUrl: product.imageUrl);
                },
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: imgCtrl.text.isEmpty
                        ? const Center(child: Text('Image'))
                        : FittedBox(
                            child: Image.network(
                              imgCtrl.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: imgCtrl,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a value";
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return "Enter valid URL";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        product = Product(
                            id: product.id,
                            title: product.title,
                            description: product.description,
                            price: product.price,
                            imageUrl: newValue!);
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
