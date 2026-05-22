import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:lottie/lottie.dart';

class PlayingSoundsController extends StatefulWidget {
  const PlayingSoundsController({super.key});
  @override
  PlayingSoundsControllerState createState() => PlayingSoundsControllerState();
}

class PlayingSoundsControllerState extends State<PlayingSoundsController>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        final cubit = context.read<MediaControlCubit>();
        final selectedCount = cubit.selectedCount;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.black),
              title: const Text('Active sounds'),
            ),
          ),
          body: ListView(
            children: <Widget>[
              if (selectedCount == 0) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'No active sounds',
                      style: TextStyle(fontSize: 28.0, color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: Lottie.asset('assets/lottieFiles/relax.json'),
                )
              ],
              ...state.activeSounds.map((activeSound) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image(
                          height: 50.0,
                          image: AssetImage(activeSound.clip.enableIcon),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 22.0, top: 12.0),
                              child: Text(
                                activeSound.clip.iconTitleText,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                            Slider(
                              activeColor: Colors.orange,
                              value: activeSound.volume,
                              min: 0,
                              max: 1,
                              divisions: 50,
                              onChanged: (volume) {
                                cubit.setVolume(activeSound.clip.id, volume);
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            cubit.toggleSound('', activeSound.clip);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Image.asset('assets/images/circle_trash.png',
                                height: 35),
                          )),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
