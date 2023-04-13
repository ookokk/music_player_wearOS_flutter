import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

import '../../constants.dart';

class VolumeAndFavorite extends StatefulWidget {
  const VolumeAndFavorite({
    super.key,
  });

  @override
  State<VolumeAndFavorite> createState() => _VolumeAndFavoriteState();
}

class _VolumeAndFavoriteState extends State<VolumeAndFavorite> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  double volume = 25;

  @override
  void initState() {
    rotarySubscription = rotaryEvents.listen(handleRotaryEvent);
    super.initState();
  }

  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }

  void handleRotaryEvent(RotaryEvent event) {
    if (event.direction == RotaryDirection.clockwise) {
      if (volume < 100) {
        setState(() {
          volume++;
        });
      } else {
        if (volume > 0) {
          setState(() {
            volume--;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: WatchShape(builder: (context, shape, _) {
          bool isRound = shape == WearShape.round;
          return Row(
            mainAxisAlignment: isRound
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AmbientMode(builder: (context, mode, _) {
                      return CircularProgressIndicator(
                        value: volume / 100,
                        color: mode == WearMode.ambient
                            ? Colors.transparent
                            : Colors.white,
                        backgroundColor: grayColor,
                        strokeWidth: 1.2,
                      );
                    }),
                    const Icon(
                      CupertinoIcons.speaker_2_fill,
                      color: grayColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
              isRound
                  ? const SizedBox()
                  : Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: grayColor, width: 1.2),
                      ),
                      child: const Icon(
                        CupertinoIcons.heart,
                        color: grayColor,
                        size: 14,
                      ),
                    )
            ],
          );
        }));
  }
}
