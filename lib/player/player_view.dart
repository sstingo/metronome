import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerView extends StatefulWidget {
  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  PlatformFile? _file;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.library_music_outlined),
            onPressed: () async {
              FilePickerResult? result =
                  await FilePicker.platform.pickFiles(type: FileType.audio);

              if (result != null) {
                setState(() {
                  _file = result.files.single;
                  _audioPlayer.setFilePath(_file!.path!);
                });

                print(result.files.single.path);
              }
            },
          )
        ],
        title: _file != null ? Text(_file!.name) : Text('預設'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 9,
            child: Placeholder(),
          ),
          Flexible(
            flex: 2,
            child: ControlButton(file: _file, audioPlayer: _audioPlayer),
          ),
        ],
      ),
    );
  }
}

class ControlButton extends StatefulWidget {
  final PlatformFile? file;
  final AudioPlayer audioPlayer;

  const ControlButton({this.file, required this.audioPlayer});

  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return widget.file == null
        ? Text('請選擇音檔')
        : Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("00:00"),
                  ),
                  Expanded(
                    child: Slider(
                        value: 0,
                        // value: widget.audioPlayer.position.inSeconds /
                        //     widget.audioPlayer.duration!.inSeconds,
                        onChanged: null),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text("00:00"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.skip_previous),
                  //   onPressed: () {},
                  // ),

                  IconButton(
                    icon: Icon(Icons.replay_10),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    onPressed: () {
                      if (_isPlaying) {
                        _pause();
                      } else {
                        _play();
                      }
                      setState(() => {_isPlaying = !_isPlaying});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_10),
                    onPressed: () {},
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.skip_next),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ],
          );
  }

  void _play() {
    widget.audioPlayer.play();
  }

  void _pause() {
    widget.audioPlayer.pause();
  }

  // String _getPassedTime() {
  //   return
  // }

  // String _getTotalTime() {
  //   return
  // }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
  }
}

// Future<void> _select(PlatformFile? file) async {
//   if (file != null) {
//     await _audioPlayer.setFilePath(file.path!);
//   } else {
//     await _audioPlayer.setAsset('assets/What_If_We.wav');
//   }
// }
