import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../data_models/scoped_models/main_model.dart';
import '../../../../data_models/models/package.dart';
import './package_list_item.dart';
import '../../single_package_details/single_package_detail.dart';

class PackageList extends StatefulWidget {

  MainModel model;

  PackageList(this.model);

  @override
    _PackageListState createState() => new _PackageListState();
}

class _PackageListState extends State<PackageList> {

  @override
    void initState() {
      widget.model.fetchPackages();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

      Widget content = Center(child: Text("No Packages found"));

      if(widget.model.isPackagesLoading){
        content = Center(child: CircularProgressIndicator(),);
      }
      else if(widget.model.packages.length > 0 && !widget.model.isPackagesLoading){
        
        content = LazyLoadScrollView(
          onEndOfPage: () {
            setState(() {
              widget.model.addMorePackages();
            });
          },

          child: ListView.builder(
            itemCount: widget.model.packages.length,
            itemBuilder: (context, index) {
              return buildListItem(widget.model.packages[index], index);
            },
          ),
        );  
      
      }

      return content;
  }

  GestureDetector buildListItem(Package package, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => SinglePackageDetails(package)
        ));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: PackageListItem(packageItem: package),
      ),
    );
  }
}