//
//  UnityManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/15.
//

import Foundation
/*
 [:*** Unity Release:]
 */
import UnityFramework

/*
 [:*** Unity Release:]
 */
final class UnityManager: NSObject, UnityFrameworkListener {

    static let shared = UnityManager()

    static let gameObjectName = "NativeManager"
    static let functionName = "SendToUnity"

    private let dataBundleId: String = "com.unity3d.framework"
    private let frameworkPath: String = "/Frameworks/UnityFramework.framework"

    var ufw: UnityFramework?

    var unityRootViewController: UIViewController? {
        get { ufw?.appController().window.rootViewController }
        set { ufw?.appController().window.rootViewController = newValue }
    }

    var unityView: UIView? {
        ufw?.appController().rootViewController.view
    }

    var unityWindow: UIWindow? {
        get { ufw?.appController().window }
        set { ufw?.appController().window = newValue }
    }

    var isInitialized: Bool {
        self.ufw?.appController() != nil
    }

    private override init() {}

    private var hostMainWindow: UIWindow?

    func setHostMainWindow(_ hostMainWindow: UIWindow?) {
        self.hostMainWindow = hostMainWindow
    }

    func launchUnity() {
        if !isInitialized {
            guard let ufw = self.loadUnityFramework() else { return }
            self.ufw = ufw

            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            ufw.setDataBundleId(dataBundleId)
            ufw.register(self)
            ufw.runEmbedded(
                withArgc: CommandLine.argc,
                argv: CommandLine.unsafeArgv,
                appLaunchOpts: appDelegate?.appLaunchOpts
            )

            /*
             최기에 UnityView에 대해서 삭제를 진행한다.
             화면 번뜩이는 문제를 해결 하기 위함.
             */
            unityDidUnload()
        }
    }

    private func loadUnityFramework() -> UnityFramework? {
        let bundlePath: String = Bundle.main.bundlePath + frameworkPath

        let bundle = Bundle(path: bundlePath)

        if bundle?.isLoaded == false {
            bundle?.load()
        }

        let ufw = bundle?.principalClass?.getInstance()

        if ufw?.appController() == nil {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header

            ufw?.setExecuteHeader(machineHeader)
        }
        return ufw
    }

    func callToUnityFunction<T: Codable>(_ functionName: UnityCallFunctionName, _ value: T) {
        let unityInfo = UnityInfoWrapper(functionName: functionName, value: value)
        callUnity(unityInfo: unityInfo)
    }

    func callToUnityFunction(_ functionName: UnityCallFunctionName) {
        let unityInfo = UnityInfoWrapper<EmptyResultDto>(functionName: functionName)
        callUnity(unityInfo: unityInfo)
    }

    private func callUnity<T>(unityInfo: UnityInfoWrapper<T>) {
        let jsonData = try? JSONEncoder().encode(unityInfo)
        let jsonStr = String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
//        print("📺 \(jsonStr)")
        ufw?.sendMessageToGO(withName: UnityManager.gameObjectName,
                             functionName: UnityManager.functionName,
                             message: jsonStr)
    }

    func getUnityData(jsonStr: String?) -> (functionName: String?, data: Data) {
        let data = jsonStr?.data(using: .utf8) ?? Data()
        let json = try? JSONDecoder().decode(UnityInfoWrapper<FromUnityEmpty>.self, from: data)
        return (json?.type, data)
    }

    func registUnityToNative(_ delegate: NativeCallsProtocol) {
        NSClassFromString("FrameworkLibAPI")?.registerAPIforNativeCalls(delegate)
    }

    func unityDidUnload(completeDelegate: @escaping () -> Void = {}) {
        /*
         만약 UnityView가 있다면 UnityView를 없애고
         화면 갱신을 다시 하라
         */
        if ufw != nil {
            if let unityView = self.ufw?.appController().rootViewController.view as? UIView {
                unityView.removeFromSuperview()
            }
            self.hostMainWindow?.makeKeyAndVisible()
        }
        completeDelegate()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if let ufw = self.ufw {
            ufw.appController()?.applicationWillResignActive(application)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if let ufw = self.ufw {
            ufw.appController()?.applicationDidEnterBackground(application)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if let ufw = self.ufw {
            ufw.appController()?.applicationWillEnterForeground(application)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let ufw = self.ufw {
            ufw.appController()?.applicationDidBecomeActive(application)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if let ufw = self.ufw {
            ufw.appController()?.applicationWillTerminate(application)
        }
    }
}
