import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data_models/scoped_models/main_model.dart';
import './search_area/product_search_area.dart';
import './product_list/product_list.dart';

class ProductListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return new NestedScrollView(
          //controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                floating: true,
                snap: true,
                pinned: true,
                backgroundColor: Color.fromRGBO(235, 139, 123, 1.0), //Background Color of AppBar when scrolled
                flexibleSpace: FlexibleSpaceBar(
                  background: ProductSearchArea(model),
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.white,
            child: ProductList(model),
          )
      );
    });
  }
}
