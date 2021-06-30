import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc2/ProductBloc.dart';
import 'package:good_dream/bloc2/product.dart';

void main() {
 BlocProvider<ProductBloc>(
      create: (context)=>ProductBloc(),
   child: Menu2(),
  );
}


class Menu2 extends StatefulWidget {
  const Menu2({
    Key? key,
//    this.setDarkMode,
  }) : super(key: key);
//  final ValueChanged<bool>? setDarkMode;

  @override
  _Menu2State createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> with AutomaticKeepAliveClientMixin {

  final dataStorage = GetStorage();

  void initState() {
    super.initState();
    //  themeMode = ThemeMode.light;
    intCheck = 1;
    switchThemeMode();
    dataStorage.read('intCheck');
    checkStorage();
    //   arrays4[0].checkThemeMode = themeMode;
    //   cart.add3(arrays4[0]);

    log("intCheck***$intCheck");
    //  switchThemeMode();
    //   arrays4[0].checkThemeMode = ThemeMode.light;
    //   dataStorage.read('key');
    //    dataStorage.read('key2');
    /* if(dataCount.read('key') != null) {
       dataCount.read('key');
    }*/
    //   log("initState controller ${dataStorage.read('key')}");
    //  log("initState themeMode ${themeMode = controller.dataStorage.read('key')}");
  }

  checkStorage() {

    if(themeMode == ThemeMode.light) {
      intCheck = 0;
    } else if (themeMode == ThemeMode.dark){
      intCheck = 1;
    } else {intCheck = 2;}
    dataStorage.write('intCheck', intCheck);
    log("intCheck $intCheck");
  }

  void switchThemeMode(){
    switch(intCheck){
      case 0 :
        themeMode = ThemeMode.light;
        print('ThemeMode.light*');
        break;
      case 1 :
        themeMode = ThemeMode.dark;
        print('ThemeMode.dark*');
        break;
      case 2 :
        themeMode = ThemeMode.system;
        print('ThemeMode.system*');
    }
  }

  late int intCheck;

  // late ThemeMode themeMode;
  late ThemeMode themeMode;
//  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),

      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(12),
            child: FutureBuilder<List<Product>>(
              future: Product.loadData(),
              builder: (context, snap){
                if (snap.connectionState == ConnectionState.done)
                  return ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index)=>Card(
                        child: ListTile(
                          onTap: (){},
                          title: Container(
                            height: 300,
                            child: Column(
                              children: [

                                Expanded(
                                    flex: 2,
                                    child: Image(image: NetworkImage(snap.data![index].picurl!))
                                ),
                                SizedBox(height: 15),
                                Expanded(child: Text(snap.data![index].name!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                Expanded(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text('${snap.data![index].price}\$',
                                        style: TextStyle(
                                            color: snap.data![index].off! > 0 ? Colors.red : Colors.black,
                                            decoration: snap.data![index].off! > 0 ? TextDecoration.lineThrough : TextDecoration.none, fontWeight: FontWeight.bold
                                        )
                                    ),
                                    SizedBox(width: 15),
                                    snap.data![index].off! > 0
                                        ? Text('${(snap.data![index].price! - (snap.data![index].price!*snap.data![index].off!)).toStringAsFixed(2)}\$', style: TextStyle(fontWeight: FontWeight.bold),)
                                        : Container()
                                  ],
                                )),
                                IconButton(
                                    icon: Icon(CupertinoIcons.shopping_cart),
                                    onPressed: ()=>BlocProvider.of<ProductBloc>(context).add(AddToCart(product: snap.data![index]))
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      )
                  );
                return Center(child: CupertinoActivityIndicator());
              },
            )
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



