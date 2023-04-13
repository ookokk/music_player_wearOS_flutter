package com.example.music_player_wear_os

import io.flutter.embedding.android.FlutterActivity
import android.view.MotionEvent
import com.samsung.wearable_rotary.WearableRotaryPlugin



class MainActivity: FlutterActivity() {
    class MainActivity : FlutterActivity() {
        override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
            return when {
                WearableRotaryPlugin.onGenericMotionEvent(event) -> true
                else -> super.onGenericMotionEvent(event)
            }
        }
    }
}
