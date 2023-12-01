//
//  TorymapAPIService.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2022/12/08.
//

import Foundation
import RxSwift
import Alamofire

/*
 https://web.torymeta.com/map/v1 관련 API
 */
struct MapAPI {
    static let shared = MapAPI()
    private init() {}

    func updateMyLocation(lat: Double,
                          lng: Double,
                          isLocationExpose: Bool,
                          universityCode: String) -> Observable<UpdateMyLatLngResultDto> {
        let aes256 = AES256Util()
        let cryptoLat = aes256.encrypt(string: "\(lat)") ?? ""
        let cryptoLng = aes256.encrypt(string: "\(lng)") ?? ""
        let locationExposeYn: String = isLocationExpose ? "Y" : "N"

        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/location/update-enc",
                                                   params: ["lat": cryptoLat,
                                                            "lng": cryptoLng,
                                                            "locationExposeYn": locationExposeYn,
                                                            "universityCode": universityCode],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<UpdateMyLatLngResultDto>>(requestContext: requestContext)
            .postMapping()
            .catch { _ in
                Observable<UpdateMyLatLngResultDto>.empty()
            }
    }

    func getUniversityLatLng(universityCode: String) -> Observable<UniversityCenterResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/university/\(universityCode)/center",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<UniversityCenterResultDto>>(requestContext: requestContext)
            .getMapping()
            .catch { _ in
                Observable<UniversityCenterResultDto>.empty()
            }
    }

    // marker.....
    func getMarkerDetail(memberId: Int) -> Observable<BuildingMarkerDetailResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/marker/\(memberId)",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<BuildingMarkerDetailResultDto>>(requestContext:
                                                                                                requestContext)
            .getMapping()
            .catch { _ in
                Observable<BuildingMarkerDetailResultDto>.empty()
            }
    }

    func getMarkerFriend() -> Observable<FriendMarkerListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/location/friend-enc",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<FriendMarkerListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(FriendMarkerListResultDto(list: []))
    }

    func getUniversityBuildingMarker(universityCode: String)
    -> Observable<BuildingMarkerListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/university/\(universityCode)/markers",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .validation)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<BuildingMarkerListResultDto>>(requestContext:
                                                                                            requestContext)
            .getMapping()
            .catchAndReturn(BuildingMarkerListResultDto(list: []))
    }

    // getUniversityList.....
    func getUniversityList() -> Observable<UniversityListResultDto> {
        let requestContext = ToryAPIRequestContext(domain: .map,
                                                   path: "/universities",
                                                   params: [:],
                                                   requestUIMode: .loading,
                                                   resultUIMode: .showWarning)
        return CommonRESTfulAPIService<ToryAPIResultWrapper<UniversityListResultDto>>(requestContext: requestContext)
            .getMapping()
            .catchAndReturn(UniversityListResultDto(list: []))
    }
}
