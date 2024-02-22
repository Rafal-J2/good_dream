import 'package:flutter/material.dart';
import 'package:good_dream/sounds/mechanical_sounds.dart';
import 'package:good_dream/models/data_provider.dart';
import 'package:provider/provider.dart';
import '../sounds/water_sounds.dart';
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
                      if (waterSounds[0].isControlActive!) {
                        mix1();
                        cart.add(waterSounds[0]);
                        waterSounds[0].isControlActive =
                            waterSounds[0].isControlActive;
                        debugPrint('arrays[0]');
                      }

                      if (waterSounds[1].isControlActive!) {
                        mix2();
                        cart.add(waterSounds[1]);
                        waterSounds[1].isControlActive =
                            waterSounds[1].isControlActive;
                        debugPrint('arrays[1]');
                      }

                      if (waterSounds[2].isControlActive!) {
                        mix3();
                        cart.add(waterSounds[2]);
                        waterSounds[2].isControlActive =
                            waterSounds[2].isControlActive;
                        debugPrint('arrays[2]');
                      }
                    } else {
                      debugPrint("Else it's work -------");
                      waterSounds[0].player!.pause();
                      waterSounds[1].player!.pause();
                      waterSounds[2].player!.pause();

                      cart.remove(waterSounds[0]);
                      cart.remove(waterSounds[1]);
                      cart.remove(waterSounds[2]);

                      waterSounds[0].isControlActive = false;
                      waterSounds[1].isControlActive = false;
                      waterSounds[2].isControlActive = false;
                    }
                  },
                  child: Image(
                    image: AssetImage(mechanicalSounds[index].mainAppIcons!),
                  ),
                ),
                Text(
                  mechanicalSounds[index].iconTitleText!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          });
    });
  }
}
