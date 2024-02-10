import 'package:good_dream/models/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../fun/arrays_1_2.dart';


class TabViewOne extends StatefulWidget {
  const TabViewOne({super.key});

  @override
  State createState() => _State();

}

class _State extends State<TabViewOne> with AutomaticKeepAliveClientMixin {
  final PageStorageBucket bucket = PageStorageBucket();



  @override
  Widget build(BuildContext context) {
   // var cart = Provider.of<DataProvider>(context);
    super.build(context);
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return GridView.builder(
        itemCount: arrays.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0, crossAxisCount: 3),
        itemBuilder: (context, index) {
          //   final shopList = snapshot.data["shop items"];
          return Column(
            children: [
              TextButton(
                ///  padding: EdgeInsets.only(top: 10),
                onPressed: () async {
                  cart.addAll(index);
                },
                child: gridBuldier(index),
              ),
            ],
          );
        },
      );
    });
  }
    Widget gridBuldier(int index) => Column(
          children: [
            Image(
              fit: BoxFit.contain,
              height: 50,
              width: 120,
              image: AssetImage(arrays[index].isFav!
                  ? arrays[index].picOn!
                  : arrays[index].picOff!),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            arrays[index].isFav!
                ? AnimatedOpacity(
                    opacity: arrays[index].isFav!
                        ? arrays[index].opacityOn
                        : arrays[index].opacityOff,
                    duration: const Duration(milliseconds: 800),
                    child: PlayerBuilder.volume(
                        player: arrays[index].player,
                        builder: (context, volume) {
                          return Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Slider(
                                value: volume,
                                min: 0,
                                max: 1,
                                divisions: 50,
                                onChanged: (v) {
                                  setState(() {
                                    arrays[index].player.setVolume(v);
                                  });
                                }),
                          );
                        }),
                  )
                : Text(
                    arrays[index].title!,
                    style: const TextStyle(
                        fontSize: 12.0,
                        //    height: 2.5,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
          ],
        );


  @override
  bool get wantKeepAlive => true;
}
