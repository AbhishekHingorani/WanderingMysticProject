import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../data_models/scoped_models/main_model.dart';
import '../../../../data_models/models/list_product.dart';
import './product_list_item.dart';
import '../single_product_detail.dart';

class ProductList extends StatefulWidget {

  MainModel model;

  ProductList(this.model);

  @override
    _ProductListState createState() => new _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
    void initState() {
      widget.model.fetchProducts();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){

      Widget content = Center(child: Text("No Products found"));

      if(model.isProductsLoading){
        content = Center(child: CircularProgressIndicator(),);
      }
      else if(model.products.length > 0 && !model.isProductsLoading){
        //
        content = LazyLoadScrollView(
          onEndOfPage: () {
            setState(() {
              model.addMoreProducts();
            });
          },

          child: GridView.count(
            crossAxisCount: 2,
            children: List<Widget>.generate(model.products.length, (index) {
              return buildListItem(model.products[index], index);
            }),
          ),
        );  
      
      }

      return content;

    },);
  }

  GestureDetector buildListItem(ListProduct product, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => SingleProductDetail(product)
        ));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: ProductListItem(product: product),
      ),
    );
  }
}