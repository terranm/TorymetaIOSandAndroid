//
//  WilldPermissionManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/06.
//

import Foundation
import CoreLocation
import ContactsUI
import AVFoundation
import CoreMotion
import RxSwift
import RxCocoa

/*
 실제 구현부에서 로직의 역할이 중요하다.
 */

final class WDPermissionManager {

    static let shared = WDPermissionManager()

    enum PermissionState {
        case granted
        case notGranted
        case notDetermined
    }

    let center = UNUserNotificationCenter.current() // PUSH
    let locationManager = CLLocationManager()   // 위치
    let store = CNContactStore()    // 주소록
    let session = AVAudioSession.sharedInstance()   // 마이크
    let pedoMeter = CMPedometer()   // MotionActivity
    let motionManager = CMMotionActivityManager()

    func isPermissionPageShow(delegate: @escaping (Bool) -> Void) {
        if checkLocationPermission()    == .notDetermined
            && checkAddressPermission() == .notDetermined
            && checkMotionPermission()  == .notDetermined {
            delegate(true)
        } else {
            delegate(false)
        }
    }

    // 위치 권한 체크
    func checkLocationPermission(_ delegate: @escaping (PermissionState) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
            // authorizedAlways : 항상 위치 서비스 사용 가능
            // authorizedWhenInUse : 앱이 포그라운드에 있을 때 위치 서비스 사용 가능
        case .authorizedAlways, .authorizedWhenInUse:
            delegate(PermissionState.granted)
            // denied : 위치 서비스 권한 거부됨
            // restricted : 위치 서비스 사용 제한됨 (e.g. 부모 모니터링 제한)
        case .denied, .restricted:
            delegate(PermissionState.notGranted)
            // 위치 서비스 권한이 아직 설정되지 않음
        case .notDetermined:
            // 권한요청
            delegate(PermissionState.notDetermined)
        default:
            delegate(PermissionState.notGranted)
            print("checkLocationPermission : @unknown")
        }
    }

    func checkLocationPermission() -> PermissionState {
        let status = CLLocationManager.authorizationStatus()
        switch status {
            // authorizedAlways : 항상 위치 서비스 사용 가능
            // authorizedWhenInUse : 앱이 포그라운드에 있을 때 위치 서비스 사용 가능
        case .authorizedAlways, .authorizedWhenInUse:
            return PermissionState.granted
            // denied : 위치 서비스 권한 거부됨
            // restricted : 위치 서비스 사용 제한됨 (e.g. 부모 모니터링 제한)
        case .denied, .restricted:
            return PermissionState.notGranted
            // 위치 서비스 권한이 아직 설정되지 않음
        case .notDetermined:
            // 권한요청
            return PermissionState.notDetermined
        default:
            return PermissionState.notGranted
        }
    }

    // 친구목록 허용 권한 체크
    func checkAddressPermission(_ delegate: @escaping (PermissionState) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
            // 이미 주소록 권한이 허용되어 있는 경우
            // 원하는 동작 수행
        case .authorized:
            delegate(PermissionState.granted)
            // 사용자가 주소록 접근을 거부한 경우
            // 주소록 접근이 제한된 경우
        case .denied, .restricted:
            delegate(PermissionState.notGranted)
        case .notDetermined:
            // 권한 요청
            delegate(PermissionState.notDetermined)
        default:
            delegate(PermissionState.notGranted)
        }
    }

    private func checkAddressPermission() -> PermissionState {
        switch CNContactStore.authorizationStatus(for: .contacts) {
            // 이미 주소록 권한이 허용되어 있는 경우
            // 원하는 동작 수행
        case .authorized:
            return .granted
            // 사용자가 주소록 접근을 거부한 경우
            // 주소록 접근이 제한된 경우
        case .denied, .restricted:
            return .notGranted
        case .notDetermined:
            // 권한 요청
            return .notDetermined
        default:
            return .notGranted
        }
    }

    func checkAddressPermission() -> Observable<PermissionState> {
        Observable.create { observer -> Disposable in
            switch CNContactStore.authorizationStatus(for: .contacts) {
                // 이미 주소록 권한이 허용되어 있는 경우
                // 원하는 동작 수행
            case .authorized:
                observer.onNext(.granted)
                observer.onCompleted()
                // 사용자가 주소록 접근을 거부한 경우
                // 주소록 접근이 제한된 경우
            case .denied, .restricted:
                observer.onNext(.notGranted)
                observer.onCompleted()
            case .notDetermined:
                // 권한 요청
                observer.onNext(.notDetermined)
                observer.onCompleted()
            default:
                observer.onNext(.notGranted)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    // Motion 허용 권한
    func checkMotionPermission(_ delegate: @escaping (PermissionState) -> Void) {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized:
            delegate(PermissionState.granted)
        case .restricted, .denied:
            delegate(PermissionState.notGranted)
        case .notDetermined:
            delegate(PermissionState.notDetermined)
        default:
            delegate(PermissionState.notGranted)
        }
    }

    func checkMotionPermission() -> PermissionState {
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized:
            return PermissionState.granted
        case .restricted, .denied:
            return PermissionState.notGranted
        case .notDetermined:
            return PermissionState.notDetermined
        default:
            return PermissionState.notGranted
        }
    }

    // 카메라 허용 권한 체크
    func checkCameraPermission(_ delegate: @escaping (PermissionState) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .authorized:
            delegate(PermissionState.granted)
        case .denied, .restricted:
            delegate(PermissionState.notGranted)
        case .notDetermined:
            delegate(PermissionState.notDetermined)
        default:
            break
        }
    }

    // 마이크 허용 권한 체크
    func checkMicrophonePermission(_ delegate: @escaping (PermissionState) -> Void) {
        let status = session.recordPermission
        switch status {
        case .granted:
            // 마이크 권한이 승인됨
            delegate(PermissionState.granted)
        case .denied:
            // 마이크 권한이 거부됨
            delegate(PermissionState.notGranted)
        case .undetermined:
            delegate(PermissionState.notDetermined)
        default:
            break
        }
    }

    // PUSH 권한 요청
    func reqPushPermission(_ delegate: @escaping (Bool) -> Void = { _ in }) {
        center.delegate = UIApplication.shared as? UNUserNotificationCenterDelegate
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { granted, _ in
            // 1. APNs에 device token 등록 요청
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            delegate(granted)
        }
    }

    // Location Permission 요청
    func reqLocationPermission(_ delegate: @escaping () -> Void = {}) {
        // MARK: App forground, background에서 위치권한 허용 여부
//        locationManager.requestAlwaysAuthorization()
        // App이 forground에 있을때만 위치 권한 수집
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        delegate()
    }

    // 친구 목록 허용 권한 요청
    func reqAdressPermission(_ delegate: @escaping (Bool) -> Void = { _ in }) {
        store.requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.sync {
                delegate(granted)
            }
        }
    }

    // 카메라 권한 요청
    func reqCameraPermission(_ delegate: @escaping (Bool) -> Void = { _ in }) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            delegate(granted)
        }
    }

    // 마이크 권한 요청
    func reqMicrophonePermission(_ delegate: @escaping (Bool) -> Void = { _ in }) {
        session.requestRecordPermission { granted in
            delegate(granted)
        }
    }

    // motion에 대한 허용 권한 요청
    func reqMotionPermission(_ delegate: @escaping (CMMotionActivity?) -> Void = { _ in }) {
        motionManager.startActivityUpdates(to: OperationQueue.main) { activity in
            delegate(activity)
        }
    }
}
