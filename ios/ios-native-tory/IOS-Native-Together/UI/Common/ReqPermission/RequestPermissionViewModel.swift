//
//  RequestPermissionViewModel.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/09/19.
//

import Foundation
import RxSwift
import RxCocoa

final class RequestPermissionViewModel: RefactoringBaseViewModel {

    let items = Driver<[ReqPermissionCellDto]>.just([
        .init(imgName: R.image.permission_location.name,
              category: localizable.requestPermissionLocationTitle(),
              reqOrSelectStr: localizable.requestPermissionEssential(),
              isSelect: false,
              description: localizable.requestPermissionLocationDescription()),

            .init(imgName: R.image.permission_mic.name,
                  category: localizable.requestPermissionMicrophoneTitle(),
                  reqOrSelectStr: localizable.requestPermissionSelect(),
                  isSelect: true,
                  description: localizable.requestPermissionMicrophoneDescription()),

            .init(imgName: R.image.permission_health.name,
                  category: localizable.requestPermissionHealthTitle(),
                  reqOrSelectStr: localizable.requestPermissionSelect(),
                  isSelect: true,
                  description: localizable.requestPermissionHealthDescription()),

            .init(imgName: R.image.permission_camera.name,
                  category: localizable.requestPermissionCameraTitle(),
                  reqOrSelectStr: localizable.requestPermissionSelect(),
                  isSelect: true,
                  description: localizable.requestPermissionCameraDescription()),

            .init(imgName: R.image.permission_address.name,
                  category: localizable.requestPermissionAddressTitle(),
                  reqOrSelectStr: localizable.requestPermissionSelect(),
                  isSelect: true,
                  description: localizable.requestPermissionAddressDescription()),

            .init(imgName: R.image.permission_alarm.name,
                  category: localizable.requestPermissionAlarmTitle(),
                  reqOrSelectStr: localizable.requestPermissionSelect(),
                  isSelect: true,
                  description: localizable.requestPermissionAlarmDescription()),
        ReqPermissionCellDto()
    ])
}
