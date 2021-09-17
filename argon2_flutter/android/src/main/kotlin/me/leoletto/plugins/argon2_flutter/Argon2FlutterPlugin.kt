package me.leoletto.plugins.argon2_flutter

import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result




/** Argon2FlutterPlugin */
class Argon2FlutterPlugin: FlutterPlugin, MethodCallHandler {
  private val tag = "[ Argon2Flutter ]"
  private lateinit var channel : MethodChannel
  private var argonHandler: Argon2Handler? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "argon2_flutter")
    channel.setMethodCallHandler(this)
    argonHandler = Argon2Handler()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.d(tag, "${call.method} request received")
    when (call.method){
      "hash" -> {
        val args = call.arguments as ArrayList<*>
        val map = args[0] as HashMap<*, *>
        val params = HashParams(
          map["pass"] as String,
          map["salt"] as String,
          map["iterations"] as Int,
          map["memory"] as Int,
          map["hashLen"] as Int,
          map["parallelism"] as Int,
          argonHandler!!.mapModeToType(map["mode"]),
          argonHandler!!.mapModeToVersion(map["version"])
        )

        val hash = argonHandler!!.hash(params)

        result.success(hashMapOf(
          "encoded" to hash.encodedOutputAsString(),
          "rawHashBytes" to hash.rawHashAsByteArray(),
          "rawHash" to hash.rawHashAsHexadecimal()
        ))
      }
      else -> result.notImplemented()
    }


  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    if(argonHandler != null)
        argonHandler = null
  }
}
