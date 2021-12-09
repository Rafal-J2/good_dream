class ViewModels {
  final getStorage;
  bool? isFav;
  String? events;
  String? picOff;
  String? picOn;
  String? title;
  String? sounds;
  String? sounds2;
  String? log;
  String? text;
  String? image;
  final gestureDetector;
  final textStyle;
  final padding;
  final player;
  bool? isDarkMode;
  var checkThemeMode;
  var opacityOff;
  var opacityOn;
  double? vol = 0.5;

  ViewModels(
      {
        this.getStorage,
        this.events,
        this.picOff,
        this.title,
        this.isFav,
        this.picOn,
        this.player,
        this.sounds,
        this.sounds2,
        this.log,
        this.opacityOff,
        this.opacityOn,
        this.vol,
        this.padding,
        this.text,
        this.image,
        this.gestureDetector,
        this.textStyle,
        this.isDarkMode,
        this.checkThemeMode});
}
