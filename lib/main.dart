import 'package:delivery_application/src/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void initCategoryData() {
  // var categoryData = [
  //   {'name': 'Pizza', 'url': 'general-settings/category/pizza-slice.png'},
  //   {'name': 'Mexicana', 'url': 'general-settings/category/taco.png'},
  //   {'name': 'Sushi', 'url': 'general-settings/category/sushi.png'},
  //   {'name': 'Postres', 'url': 'general-settings/category/cake.png'},
  //   {'name': 'Saludable', 'url': 'general-settings/category/diet.png'}
  // ];

  // for (var i = 0; i < categoryData.length; i++) {
  //   final databaseReference = FirebaseDatabase.instance.reference().child("general-settings/category").push();
  //   databaseReference.update({
  //     'name': categoryData[i]['name'],
  //     'image': {
  //       'url': categoryData[i]['url'],
  //     },
  //   });
  // }
}

void initProductData() {
  // var productData = [
  //   {
  //     'name': 'Pizzas Luis',
  //     'description': '',
  //     'url': 'products/pizzapepperoni0.jpg'
  //   },
  //   {
  //     'name': 'Que tacos!',
  //     'description': '',
  //     'url': 'products/tacos-mexicanos.jpg'
  //   },
  //   {
  //     'name': 'El gussi',
  //     'description': '',
  //     'url': 'products/hamburguesa-sencilla.jpg'
  //   },
  //   {
  //     'name': 'Gorditas Doña Tota!',
  //     'description': '',
  //     'url': 'products/receta-facil-de-chicharron-con-masa.jpg'
  //   },
  //   {
  //     'name': 'Mariscos Martha',
  //     'description': '',
  //     'url': 'products/Mariscos.jpg'
  //   }
  // ];

  // for (var i = 0; i < productData.length; i++) {
  //   final databaseReference = FirebaseDatabase.instance.reference().child("products/").push();
  //   databaseReference.update(
  //     {
  //       'name': productData[i]['name'],
  //       'description': productData[i]['description'],
  //       'image': {
  //         'url': productData[i]['url'],
  //       },
  //       'modifiers-group': initModifiersGroupData(),
  //       'menu': [
  //         {
  //           'title': 'Ordenar de nuevo',
  //           'children': [
  //             {
  //               'title': 'Tacos blanditos de carnitas',
  //               'description': '',
  //               'price': 29.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Torta mini de carnitas',
  //               'description': '',
  //               'price': 40.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Torta ahogada de carnitas',
  //               'description': '',
  //               'price': 60.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Tacos blanditos de carnitas',
  //               'description': '',
  //               'price': 29.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Torta mini de carnitas',
  //               'description': '',
  //               'price': 40.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Torta ahogada de carnitas',
  //               'description': '',
  //               'price': 60.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //           ],
  //         },
  //         {
  //           'title': 'Tacos dorados',
  //           'children': [
  //             {
  //               'title': 'Taco dorado sencillo',
  //               'description': '',
  //               'price': 15.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Taco dorado de carnitas',
  //               'description': '',
  //               'price': 29.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Taco dorado de camaron',
  //               'description': '',
  //               'price': 55.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Tacos de barbacoa',
  //               'description': '',
  //               'price': 23.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //           ],
  //         },
  //         {
  //           'title': 'Bebidas',
  //           'children': [
  //             {
  //               'title': 'Agua fresca',
  //               'description': '500 mililitros',
  //               'price': 27.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Agua fresca',
  //               'description': '1 litro',
  //               'price': 40.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //             {
  //               'title': 'Refresco',
  //               'description': '355 mililitros',
  //               'price': 26.0,
  //               'url': 'products/Mariscos.jpg',
  //             },
  //           ],
  //         },
  //       ]
  //     },
  //   );
  // }
}

List initModifiersGroupData() {
  return [
    {
      'name': 'Ingredientes',
      'note': '',
      'isMandatory': false,
      'totalModifiers': 2,
      'limitModifier': 1,
      'modifiers': [
        {'name': 'Pepperoni', 'price': 1},
        {'name': 'Hongos', 'price': 1},
        {'name': 'Aceitunas', 'price': 1},
      ]
    },
    {
      'name': 'Salsa',
      'note': '',
      'isMandatory': false,
      'totalModifiers': 2,
      'limitModifier': 1,
      'modifiers': [
        {'name': 'Verde', 'price': 1},
        {'name': 'Roja', 'price': 1},
        {'name': 'Aguacate', 'price': 1},
      ]
    },
    {
      'name': 'Especias',
      'note': '',
      'isMandatory': false,
      'totalModifiers': 2,
      'limitModifier': 1,
      'modifiers': [
        {'name': 'Pimienta', 'price': 1},
        {'name': 'Ajo', 'price': 1},
        {'name': 'Sal', 'price': 1},
      ]
    },
    {
      'name': 'Tamaño',
      'note': '',
      'isMandatory': true,
      'totalModifiers': 2,
      'limitModifier': 1,
      'modifiers': [
        {'name': 'Chico', 'price': 0},
        {'name': 'Normal', 'price': 10},
        {'name': 'Grande', 'price': 15},
      ]
    },
  ];

  // for (var i = 0; i < modifiersGroupsData.length; i++) {
  //   final databaseReference = FirebaseDatabase.instance.reference().child("modifiers-groups/").push();
  //   databaseReference.update({
  //     'name': modifiersGroupsData[i]['name'],
  //     'note': modifiersGroupsData[i]['note'],
  //     'isMandatory': modifiersGroupsData[i]['isMandatory'],
  //     'totalModifiers': modifiersGroupsData[i]['totalModifiers'],
  //     'limitModifier': modifiersGroupsData[i]['limitModifier'],
  //     'modifiers': modifiersGroupsData[i]['modifiers']
  //   });
  // }
}
