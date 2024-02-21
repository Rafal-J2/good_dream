import 'package:flutter/material.dart';
import 'package:good_dream/fun/arrays_3_4.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:provider/provider.dart';
import '../fun/arrays_1_2.dart';
import '../fun/only_mix.dart';

class Mix extends StatelessWidget {
  const Mix({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (
      context,
      cart,
      child,
    ) {
      return GridView.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Column(
              children: [
                TextButton(
                  onPressed: () {
                    isFav = !isFav;
                    if (isFav) {
                      if (arrays2[0].isFav!) {
                        mix1();
                        cart.add(arrays2[0]);
                        arrays2[0].isFav = arrays2[0].isFav;
                        debugPrint('arrays[0]');
                      }

                      if (arrays2[1].isFav!) {
                        mix2();
                        cart.add(arrays2[1]);
                        arrays2[1].isFav = arrays2[1].isFav;
                        debugPrint('arrays[1]');
                      }

                      if (arrays2[2].isFav!) {
                        mix3();
                        cart.add(arrays2[2]);
                        arrays2[2].isFav = arrays2[2].isFav;
                        debugPrint('arrays[2]');
                      }
                    } else {
                      debugPrint("Else it's work -------");
                      arrays2[0].player!.pause();
                      arrays2[1].player!.pause();
                      arrays2[2].player!.pause();

                      cart.remove(arrays2[0]);
                      cart.remove(arrays2[1]);
                      cart.remove(arrays2[2]);

                      arrays2[0].isFav = false;
                      arrays2[1].isFav = false;
                      arrays2[2].isFav = false;
                    }
                  },
                  child: Image(
                    image: AssetImage(arrays4[index].mainAppIcons!),
                  ),
                ),
                Text(
                  arrays4[index].iconTitleText!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          });
    });
  }
}
