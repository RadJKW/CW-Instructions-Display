import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart' as mat;

class DartVLCExample extends StatefulWidget {
  const DartVLCExample({Key? key}) : super(key: key);

  @override
  DartVLCExampleState createState() => DartVLCExampleState();
}

class DartVLCExampleState extends State<DartVLCExample> {
  Player player = Player(id: 0);
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(0, 0);
  List<Media> medias = <Media>[];
  List<Device> devices = <Device>[];
  TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();
  double bufferingProgress = 0.0;
  Media? metasMedia;

  String videoPath =
      '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/crepePaper.wmv';

  @override
  void initState() {
    super.initState();
    if (mounted) {
      player.currentStream.listen((current) {
        setState(() => this.current = current);
      });
      player.positionStream.listen((position) {
        setState(() => this.position = position);
      });
      player.playbackStream.listen((playback) {
        setState(() => this.playback = playback);
      });
      player.generalStream.listen((general) {
        setState(() => this.general = general);
      });
      player.videoDimensionsStream.listen((videoDimensions) {
        setState(() {
          this.videoDimensions = videoDimensions;
        });
      });
      player.bufferingProgressStream.listen(
        (bufferingProgress) {
          setState(() {
            this.bufferingProgress = bufferingProgress;
          });
        },
      );
    }
    // medias.add(Media.file(File(videoPath.replaceAll('"', ''))));
    // player.open(Playlist(medias: medias, playlistMode: PlaylistMode.single));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    devices = Devices.all;
    Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
    equalizer.setPreAmp(10.0);
    equalizer.setBandAmp(31.25, 10.0);
    player.setEqualizer(equalizer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: <Widget>[
      mat.Material(
        child: Video(
          playlistLength: medias.length,
          player: player,
          width: player.videoDimensions.width.toDouble(),
          height: player.videoDimensions.height.toDouble(),
          // width: MediaQuery.of(context).size.width * 0.9,
          // height: MediaQuery.of(context).size.height * 0.75,
          volumeThumbColor: Colors.blue,
          volumeActiveColor: Colors.blue,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Card(
        backgroundColor: FluentTheme.of(context).focusTheme.glowColor,
        child: TextBox(
            controller: controller,
            header: 'Path to media',
            padding: const EdgeInsetsDirectional.only(start: 30),
            placeholder: videoPath,
            outsideSuffix: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: IconButton(
                    icon: const Icon(
                      FluentIcons.box_play_solid,
                      size: 30,
                    ),
                    onPressed: () async{
                      // if controller.text is not empty
                      // then set videoPath to controller.text
                      // else open the playlist with videoPath
                      if (controller.text.isNotEmpty) {
                          videoPath = controller.text;
                        }
                        controller.text = videoPath;
                      setState(() {
                        
                        medias.clear();
                        medias.add(Media.file(File(videoPath)));
                        player.open(Playlist(
                            medias: medias, playlistMode: PlaylistMode.single));
                      });
                    }))),
      ),
    ]);
  }
}
