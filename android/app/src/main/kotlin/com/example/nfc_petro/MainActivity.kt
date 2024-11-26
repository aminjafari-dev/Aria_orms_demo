package com.dpsha.ariacorms
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.app.PendingIntent
import android.content.Intent

class MainActivity: FlutterActivity(), NfcAdapter.ReaderCallback {
    private val CHANNEL = "com.dpsha.ariacorms/nfc"
    private lateinit var channel: MethodChannel
    private var nfcAdapter: NfcAdapter? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "startNfcScan" -> {
                    startNfcScan(result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        nfcAdapter = NfcAdapter.getDefaultAdapter(this)
    }

    private fun startNfcScan(result: MethodChannel.Result) {
        if (nfcAdapter == null) {
            result.error("NFC_UNAVAILABLE", "NFC is not available on this device.", null)
            return
        }

        val intent = Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_MUTABLE)

        nfcAdapter?.enableReaderMode(this, this,
            NfcAdapter.FLAG_READER_NFC_A or
                    NfcAdapter.FLAG_READER_NFC_B or
                    NfcAdapter.FLAG_READER_NFC_F or
                    NfcAdapter.FLAG_READER_NFC_V,
            null)

        result.success(null)
    }

    override fun onTagDiscovered(tag: Tag?) {
        tag?.let {
            val id = it.id
            val hexId = id.joinToString("") { byte -> "%02x".format(byte) }
            runOnUiThread {
                channel.invokeMethod("onNfcDetected", hexId)
            }
        }
    }

    override fun onPause() {
        super.onPause()
        nfcAdapter?.disableReaderMode(this)
    }
}
