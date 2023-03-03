import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class RecordItem extends StatefulWidget {
  RecordItem({
    this.timeColor = Colors.grey,
    this.url = 'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
  });

  String url;

  Color timeColor;



  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {

  AudioPlayer audioPlayer= AudioPlayer();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = false;


  @override
  void initState() {
    sedAudio();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
        setState(() {
          position = event;
          debugPrint('Position : ${position.inSeconds}');
        });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
        debugPrint('Duration : ${duration.inSeconds}');

      });
    });

    super.initState();
  }

  Future sedAudio ()async{
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.setSourceUrl(widget.url);
  }


  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: ()async{
            if(isPlaying){
              await audioPlayer.pause();
            }else{
             await audioPlayer.resume();
            }
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor: defaultColorFour,
            child: Icon(
              isPlaying?Icons.pause:Icons.play_arrow,
              color: Colors.white,size: 13,),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          child: Slider(
            onChanged: (val)async{
              await audioPlayer.seek(Duration(seconds: val.toInt()));
            },
            value: position.inSeconds.toDouble(),
            max: duration.inSeconds.toDouble(),
            min: 0,
            activeColor: defaultColorThree,
            inactiveColor: Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 1,
            height: 15,
            color: defaultColorFour,
          ),
        ),
        Text(
          formatTime(position),
          style: TextStyle(
            color: widget.timeColor,fontSize: 9
          ),
        ),
      ],
    );
  }

  String formatTime(Duration duration){
    String twoDigits(int n)=>n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inSeconds.remainder(60));

    return[
      if(duration.inHours >0)hours,
      minutes,
      second,
    ].join(':');
  }
}
