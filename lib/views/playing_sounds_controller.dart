import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_dream/bloc/media_control/media_control_cubit.dart';
import 'package:lottie/lottie.dart';

class PlayingSoundsController extends StatefulWidget {
  final AudioHandler audioHandler;
  const PlayingSoundsController({super.key, required this.audioHandler});
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
        final mediaControlCubit = context.read<MediaControlCubit>();
        final selectedCount = mediaControlCubit.selectedCount;
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
              ...state.selectedSounds.map((item) {
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
                          image: AssetImage(item.enableIcon!),
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
                                item.iconTitleText!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                            StreamBuilder<double>(
                              stream: item.player.volumeStream,
                              builder: (context, snapshot) {
                                double currentVolume = snapshot.data ??
                                    0.5; 
                                return Slider(
                                  activeColor: Colors.orange,
                                  value: currentVolume,
                                  min: 0,
                                  max: 1,
                                  divisions: 50,
                                  onChanged: (volume) {
                                    setState(() {
                                      item.player.setVolume(volume);
                                    });
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            item.player.pause();
                            item.isControlActive = false;
                            context.read<MediaControlCubit>().removeSound(item);
                            if (context
                                    .read<MediaControlCubit>()
                                    .selectedCount ==
                                0) {
                              widget.audioHandler.stop();
                            }
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
