import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:good_dream/fun/functions.dart';
import 'package:provider/provider.dart';
import 'package:good_dream/models/DataProvider.dart';
import 'package:shimmer/shimmer.dart';


class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // List<Product> get products => items;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Consumer<DataProvider>(
      builder: (context, cart, child) {
        return MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Active sounds'),
            ),
            body:  ListView(
              children: <Widget>[
                Container(
                  width: 50.0,
                height: screenSize.height / 2,
                  color: Colors.black12,
                  child: GridView.builder(
                      itemCount: cart.basketItems.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.8,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            FlatButton(
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                // Pause sounds with page one
                                cart.basketItems[index].player
                                    .pause();
                                cart.basketItems[index].isFav = false;
                            //   cart.basketItems2[index].id = true;
                                cart.remove(cart.basketItems[index]);
                          //    cart.remove2(cart.basketItems2[index]);
                                if(cart.count == 0 && cart.count2 == 0) {
                                  foregroundServiceStop();
                                }
                              },
                              child: Image(
                                height: 50.0,
                                image: AssetImage(
                                    cart.basketItems[index].picOff),
                              ),
                            ),
                            PlayerBuilder.volume(
                                player: cart.basketItems[index].player,
                                builder: (context, volume) {
                                  return Slider(
                                      activeColor: Colors.white,
                                      value: volume,
                                      min: 0,
                                      max: 1,
                                      divisions: 50,
                                      onChanged: (v) {
                                        setState(() {
                                          cart.basketItems[index]
                                              .player
                                              .setVolume(v);
                                        });
                                      });
                                }),
                          ],
                        );               
                      }),

               //   child: GridView.builder(gridDelegate: null, itemBuilder: null)
                ),
                // TODO Flat button piano
                Container(
                  width: 50.0,
                  height: screenSize.height / 1.6,
                  color: Colors.black45,
                  child: GridView.builder(
                      itemCount: cart.basketItems2.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.8,
                          crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            FlatButton(
                              padding: EdgeInsets.all(40),
                              onPressed: () {
                                // Pause sounds with page one
                                cart.basketItems2[index].player
                                    .pause();
                                cart.basketItems2[index].isFav = false;
                                   cart.remove2(cart.basketItems2[index]);
                                if(cart.count == 0 && cart.count2 == 0) {
                                  foregroundServiceStop();
                                }
                              },

                              child: Shimmer.fromColors(
                                highlightColor: Colors.white,
                                baseColor: Colors.black26,
                                child: Image(
                                  height: 75.0,
                                  image: AssetImage(
                                      cart.basketItems2[index].picOff),
                                ),
                              ),
                            ),
                            PlayerBuilder.volume(
                                player: cart.basketItems2[index].player,
                                builder: (context, volume) {
                                  return Shimmer.fromColors(
                                    highlightColor: Colors.black12,
                                    baseColor: Colors.white,
                                    child: Slider(
                                        activeColor: Colors.grey,
                                        value: volume,
                                        min: 0,
                                        max: 1,
                                        divisions: 100,
                                        onChanged: (v) {
                                          setState(() {
                                            cart.basketItems2[index]
                                                .player
                                                .setVolume(v);
                                          });
                                        }),
                                  );
                                }),
                          ],

                        );
                     
                      }),

                  //   child: GridView.builder(gridDelegate: null, itemBuilder: null)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
