import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:good_dream/bloc/mediaControlCubit/media_control_cubit_cubit.dart';
import 'package:good_dream/fun/foreground_service.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';

class PlayingSoundsController extends StatefulWidget {
  const PlayingSoundsController({super.key});
  @override
  PlayingSoundsControllerState createState() => PlayingSoundsControllerState();
}

class PlayingSoundsControllerState extends State<PlayingSoundsController>
    with AutomaticKeepAliveClientMixin {
  final dataStorage = GetStorage();
  @override
  void initState() {
    super.initState();
    _switchThemeMode();
  }

  void _switchThemeMode() {
    switch (dataStorage.read('intCheck')) {
      case 0:
        themeMode = ThemeMode.light;
        logger.i('switchThemeMode - ThemeMode.light*');
        break;
      case 1:
        themeMode = ThemeMode.dark;
        logger.i('ThemeMode.dark*');
        break;
      case 2:
        themeMode = ThemeMode.system;
        logger.i('ThemeMode.system*');
    }
  }

  ThemeMode themeMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MediaControlCubit, MediaControlCubitState>(
      builder: (context, state) {
        final mediaControlCubit = context.read<MediaControlCubit>();
        final selectedCount = mediaControlCubit.selectedCount;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: FlexColorScheme.light(
            scheme: FlexScheme.red,
            onSecondary: Colors.white,
            scaffoldBackground: const Color(0xFF20124d),
          ).toTheme,
          darkTheme: FlexColorScheme.dark(
            scheme: FlexScheme.red,
          ).toTheme,
          home: Scaffold(
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
                if (selectedCount == 0)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'No active sounds',
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
                      ),
                    ),
                  ),
                if (selectedCount == 0)
                  Center(
                    child: Lottie.asset('assets/lottieFiles/relax.json'),
                  ),
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
                                padding: const EdgeInsets.only(
                                    left: 22.0, top: 12.0),
                                child: Text(
                                  item.iconTitleText!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                              PlayerBuilder.volume(
                                  player: item.player,
                                  builder: (context, vol) {
                                    return Slider(
                                        activeColor: Colors.orange,
                                        inactiveColor:
                                            Colors.orange.withOpacity(0.3),
                                        value: vol,
                                        min: 0,
                                        max: 1,
                                        divisions: 50,
                                        onChanged: (volume) {
                                          setState(() {
                                            item.player.setVolume(volume);
                                          });
                                        });
                                  }),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              item.player.pause();
                              item.isControlActive = false;
                              context
                                  .read<MediaControlCubit>()
                                  .removeSound(item);
                              if (context
                                      .read<MediaControlCubit>()
                                      .selectedCount ==
                                  0) {
                                foregroundServiceStop();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Image.asset(
                                  'assets/images/circle_trash.png',
                                  height: 35),
                            )),
                      ],
                    ),
                  );
                }),
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
