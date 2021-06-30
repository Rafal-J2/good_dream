import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc2/product.dart';

import 'class.dart';


class AddToCart extends BlocEvent {
  Product product;
  AddToCart({required this.product});
}

class DelFromCart extends BlocEvent {
  Product product;
  DelFromCart({required this.product});
}
class ClearCart extends BlocEvent {}
class LoadedState extends BlocState {
  List<Product> products;
  LoadedState({required this.products});
}


class ProductBloc extends Bloc<BlocEvent, BlocState>{
  ProductBloc() : super(LoadingState());

  List<Product> cartProducts = [];

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async*{
    yield LoadingState();
    try{
      if (event is AddToCart)
        cartProducts.add(event.product);
      if (event is DelFromCart)
        cartProducts.remove(event.product);
      if (event is ClearCart)
        cartProducts = [];
      yield LoadedState(products: cartProducts);
    }
    catch(e){
      yield FailedToLoadState(error: e as Exception);
    }
  }
}