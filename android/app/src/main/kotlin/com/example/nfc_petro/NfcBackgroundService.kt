import android.app.Service
import android.content.Intent
import android.os.IBinder
import io.flutter.plugin.common.MethodChannel

class NfcBackgroundService : Service() {
    private lateinit var channel: MethodChannel

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        // Initialize the MethodChannel here if needed
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == "NFC_DETECTED") {
            val nfcData = intent.getStringExtra("nfcData")
            // Send the NFC data to Flutter
            sendNfcDataToFlutter(nfcData)
        }
        return START_STICKY
    }

    private fun sendNfcDataToFlutter(nfcData: String?) {
        // Implement the logic to send data to Flutter
        // This might involve using a broadcast receiver or other IPC mechanism
    }
}
