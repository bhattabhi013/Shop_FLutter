import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  const UserProductItem(
      {Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productsData = Provider.of<Products>(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: size.width * 0.14,
        child: Row(
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.edit),
            //   color: Theme.of(context).primaryColor,
            // ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text("Do you want to remove item?"),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('No')),
                            FlatButton(
                                onPressed: () {
                                  productsData.removeProduct(id);
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Yes')),
                          ],
                        ));
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
