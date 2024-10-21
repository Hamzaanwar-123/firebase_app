import 'package:flutter/material.dart';

class ParentModel {
  final String parentName;
  final List<Category> categories;

  ParentModel({
    required this.parentName,
    required this.categories,
  });
}

class Category {
  final String categoryName;
  final List<Item> items;

  Category({
    required this.categoryName,
    required this.items,
  });
}

class Item {
  final String itemName;
  final double price;

  Item({
    required this.itemName,
    required this.price,
  });
}

// Dummy data function
ParentModel getDummyData() {
  return ParentModel(
    parentName: "Electronics Store",
    categories: [
      Category(
        categoryName: "Mobile Phones",
        items: [
          Item(itemName: "iPhone 13", price: 999.990000),
          Item(itemName: "Samsung Galaxy S21", price: 849.99),
          Item(itemName: "Google Pixel 6", price: 599.99),
        ],
      ),
      Category(
        categoryName: "Laptops",
        items: [
          Item(itemName: "MacBook Pro", price: 1299.99),
          Item(itemName: "Dell XPS 13", price: 999.99),
          Item(itemName: "HP Spectre x360", price: 1099.99),
        ],
      ),
      Category(
        categoryName: "Tablets",
        items: [
          Item(itemName: "iPad Pro", price: 799.99),
          Item(itemName: "Samsung Galaxy Tab S7", price: 649.990000),
          Item(itemName: "Microsoft Surface Pro", price: 899.99),
        ],
      ),
      Category(
        categoryName: "New",
        items: [
          Item(itemName: "iPad Pro", price: 799.99),
          Item(itemName: "Samsung Galaxy Tab S7", price: 649.99),
          Item(itemName: "Microsoft Surface Pro", price: 899.99),
        ],
      ),
    ],
  );
}



class NestedListViewExample extends StatelessWidget {
  
  final ParentModel data = getDummyData();

  NestedListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.parentName),
      ),
      body: ListView.builder(
        itemCount: data.categories.length,
        itemBuilder: (context, index) {
          final category = data.categories[index];

          // return Column(
          //   children: [
          //     Text(data.categories[index].categoryName),
          //     ListView.builder(
          //       itemCount: data.categories[index].items.length,
          //       shrinkWrap: true,
          //       itemBuilder: (context, itemIndex) {
          //         return Text(data.categories[index].items[itemIndex].itemName);
          //       },
          //     )
          //   ],
          // );

          return ExpansionTile(
            title: Text(category.categoryName),
            children: category.items.map((item) {
              return ListTile(
                title: Text(item.itemName),
                subtitle: Text("\$ ${item.price.toStringAsFixed(2)}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}