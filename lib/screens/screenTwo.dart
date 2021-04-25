import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_dream/fun/functions.dart';
import 'package:provider/provider.dart';
import 'package:good_dream/models/DataProvider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with AutomaticKeepAliveClientMixin {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size screenSize = MediaQuery.of(context).size;
    return Consumer<DataProvider>(
      builder: (context, cart, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FlexColorScheme.light(
            scheme: FlexScheme.red,
            onSecondary: Colors.white,
            scaffoldBackground: Color(0xFF20124d),
          ).toTheme,
          darkTheme: FlexColorScheme.dark(
            scheme: FlexScheme.red,
          ).toTheme,
          themeMode: cart.basketItems3.isEmpty
              ? ThemeMode.system
              : cart.basketItems3[0].themeMode,
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.black),
                title: Text('Active sounds'),
              ),
            ),
            body: ListView(
              children: <Widget>[
                Center(
                  child: cart.count == 0 ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('No active sounds',
                      style: TextStyle(
                         fontSize: 28,
                          color: Colors.white
                      ),),
                  ) : null,
                ),
                Container(
                 // width: 50.0,
                  height: screenSize.height,
                  //   color: Colors.black12,
                  child: ListView.builder(
                      itemCount: cart.basketItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                     Padding(
                                       padding: const EdgeInsets.only(left: 8.0),
                                       child: Image(
                                    height: 50.0,
                                    width: 50.0,
                                    image: AssetImage(
                                    cart.basketItems[index].picOff,
                                    ),
                                  ),
                                     ),
                                PlayerBuilder.volume(
                                    player: cart.basketItems[index].player,
                                    builder: (context, _vol) {
                                      return Slider(
                                          activeColor: Colors.white,
                                          value: _vol,
                                          min: 0,
                                          max: 1,
                                          divisions: 50,
                                          onChanged: (v) {
                                            setState(() {
                                              cart.basketItems[index].player
                                                  .setVolume(v);
                                            });
                                          });
                                    }),
                                IconButton(
                                  icon: Icon(Icons.delete_forever,
                                  color: Colors.white,),
                                  iconSize: 48.0,
                                  onPressed: () {
                                    // Pause sounds with page one
                                    cart.basketItems[index].player.pause();
                                    cart.basketItems[index].isFav = false;
                                    cart.remove(cart.basketItems[index]);
                                //    cart.remove2(cart.basketItems2[index]);
                                    //    cart.remove2(cart.basketItems2[index]);
                                    if (cart.count == 0) {
                                      foregroundServiceStop();
                                    }
                                  },
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                ),

                // TODO Flat button piano
               /* Container(
                  width: 50.0,
                  height: screenSize.height / 1.6,
                  // color: Colors.black45,
                  child: GridView.builder(
                      itemCount: cart.basketItems2.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8, crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TextButton(
                              ///  padding: EdgeInsets.all(40),
                              onPressed: () {
                                // Pause sounds with page one
                                cart.basketItems2[index].player.pause();
                                cart.basketItems2[index].isFav = false;
                                cart.remove2(cart.basketItems2[index]);
                                if (cart.count == 0 && cart.count2 == 0) {
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
                                            cart.basketItems2[index].player
                                                .setVolume(v);
                                          });
                                        }),
                                  );
                                }),
                          ],
                        );
                      }),
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }

  @override

  bool get wantKeepAlive => true;
}
