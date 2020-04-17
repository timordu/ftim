package com.dugang.ftim

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry.Registrar


class FtimPlugin : FlutterPlugin {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            FtimPlugin().setMethodChannel(registrar.context().applicationContext, registrar.messenger())
        }
    }

    private var methodChannelHandler: MethodChannelHandler? = null

    private fun setMethodChannel(context: Context, binaryMessenger: BinaryMessenger) {
        methodChannelHandler = MethodChannelHandler(context, binaryMessenger)
    }


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setMethodChannel(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannelHandler = null
    }
}
