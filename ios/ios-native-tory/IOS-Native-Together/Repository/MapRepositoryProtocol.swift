//
//  MapRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa
import NMapsMap

extension MapRepositoryProtocol {
    /*
     대학교 센터 좌표
     */
    func getUniversityCenter(universityCode: String) -> Observable<NMGLatLng> {
        mapAPI.getUniversityLatLng(universityCode: universityCode)
            .map { $0.coordinate }
    }
    /*
     대학교 빌딩 리스트
     */
    func getUniversityBuildingMarkerList(universityCode: String) -> Observable<[BuildingMarkerListResultDto.Marker]> {
        mapAPI.getUniversityBuildingMarker(universityCode: universityCode)
            .map { $0.list }
    }
    /*
     대학교 빌딩 디테일
     */
    func getBuildingMakrerDetail(markerId: Int) -> Observable<BuildingMarkerDetailResultDto> {
        mapAPI.getMarkerDetail(memberId: markerId)
    }
    /*
     캠퍼스 친구 리스트
     */
    func getFriendMarkerList() -> Observable<[FriendMarkerListResultDto.Marker]> {
        mapAPI.getMarkerFriend()
            .map { $0.list }
    }
    /*
     친구 마커 디테일
     */
    func getFriendMarkerDetail(memberId: Int) -> Observable<FriendMarkerDetailDto> {
        let member = memberAPI.getMember(memberId: memberId)

        let nftItem = nftAPI.getOwnerNFT(ownerMemberId: memberId)
        return Observable
            .combineLatest(member,
                           nftItem) {
                FriendMarkerDetailDto(memberId: $0.memberId,
                                      imgUrl: $0.imgUrl,
                                      universityCode: $0.universityCode,
                                      profileName: $0.profileName,
                                      isLocationBlock: $0.isLocationBlock,
                                      nftList: $1,
                                      phoneNumber: $0.phoneNum)
            }
    }
    /*
     대학교 리스트
     */
    func getUniversityList() -> Observable<[UniversityListResultDto.Item]> {
        mapAPI.getUniversityList()
            .map { $0.list }
    }
}
