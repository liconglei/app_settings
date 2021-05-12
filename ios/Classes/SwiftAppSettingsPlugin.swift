import Flutter
import UIKit

/// base64 encode/decode for String
extension String {
    // Base64 encode
    func encodBase64() -> String?
    {
        let strData = self.data(using: String.Encoding.utf8)
        let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String
    }
    
    // Base64 decode
    func decodeBase64() -> String?
    {
        let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue) as String?
        return decodedString
    }
}

/// Swift app settings plugin with method channel call handler.
public class SwiftAppSettingsPlugin: NSObject, FlutterPlugin {

  /// Private method to open device settings window
    private func openSettings( {
    let openSettingsURLBase64String = "QXBwLVByZWZzOnJvb3Q9V0lGSQ==";
    if let url = URL(string: openSettingsURLBase64String.decodeBase64() ?? UIApplication.openSettingsURLString) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
  }

  /// Public register method for Flutter plugin registrar.
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_settings", binaryMessenger: registrar.messenger())
    let instance = SwiftAppSettingsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /// Public handler method for managing method channel calls.
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      openSettings()
  }
}
