//
//  MapDto.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/01/29.
//
import Foundation
import NMapsMap

/*
 내위치 업데이트 결과
 */

struct UpdateMyLatLngResultDto: Codable {
    let inRangeYn: String
    var isInRange: Bool {
        switch inRangeYn {
        case "Y": return true
        case "N": return false
        default: return false
        }
    }

    enum CodingKeys: String, CodingKey {
        case inRangeYn = "isInRange"
    }

    init() {
        self.inRangeYn = "N"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.inRangeYn = try container.decodeIfPresent(String.self, forKey: .inRangeYn) ?? "N"
    }
}

/*
 대학교 건물 마커 리스트 결과
 */
struct BuildingMarkerListResultDto: Codable {
    let list: [Marker]

    struct Marker: Codable {
        let markerId: Int
        let lat: Double
        let lng: Double
        var coordinate: NMGLatLng {
            return NMGLatLng(lat: lat, lng: lng)
        }
        let imgUrl: String
        let markerType: Int
        let universityCode: String

        init() {
            self.markerId = 0
            self.lat = 0.0
            self.lng = 0.0
            self.imgUrl = ""
            self.markerType = 0
            self.universityCode = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<BuildingMarkerListResultDto.Marker.CodingKeys> = try decoder
                .container(keyedBy: BuildingMarkerListResultDto.Marker.CodingKeys.self)
            self.markerId = try container
                .decodeIfPresent(Int.self, forKey: BuildingMarkerListResultDto.Marker.CodingKeys.markerId) ?? 0
            self.lat = try container
                .decodeIfPresent(Double.self, forKey: BuildingMarkerListResultDto.Marker.CodingKeys.lat) ?? 0.0
            self.lng = try container
                .decodeIfPresent(Double.self, forKey: BuildingMarkerListResultDto.Marker.CodingKeys.lng) ?? 0.0
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: BuildingMarkerListResultDto.Marker.CodingKeys.imgUrl) ?? ""
            self.markerType = try container
                .decodeIfPresent(Int.self, forKey: BuildingMarkerListResultDto.Marker.CodingKeys.markerType) ?? 0
            self.universityCode = try container
                .decodeIfPresent(String.self,
                                 forKey: BuildingMarkerListResultDto.Marker.CodingKeys.universityCode) ?? ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "markerList"
    }
}

/*
 빌딩 선택 시 디테일 정보 결과
 */
struct BuildingMarkerDetailResultDto: Codable {
    let makerId: Int
    let lat: Double
    let lng: Double
    var coordinate: NMGLatLng {
        return NMGLatLng(lat: lat, lng: lng)
    }
    let phoneNumber: String
    let placeName: String
    let addressName: String
    let categoryCode: String
    let imgUrl: String

    init() {
        self.makerId      = 0
        self.lat          = 0.0
        self.lng          = 0.0
        self.phoneNumber  = ""
        self.placeName    = ""
        self.addressName  = ""
        self.categoryCode = ""
        self.imgUrl       = ""
    }

    init(from decoder: Decoder) throws {
        let container     = try decoder.container(keyedBy: CodingKeys.self)
        self.makerId      = try container.decodeIfPresent(Int.self, forKey: .makerId) ?? 0
        self.lat          = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
        self.lng          = try container.decodeIfPresent(Double.self, forKey: .lng) ?? 0.0
        self.phoneNumber  = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        self.placeName    = try container.decodeIfPresent(String.self, forKey: .placeName) ?? ""
        self.addressName  = try container.decodeIfPresent(String.self, forKey: .addressName) ?? ""
        self.categoryCode = try container.decodeIfPresent(String.self, forKey: .categoryCode) ?? ""
        self.imgUrl       = try container.decodeIfPresent(String.self, forKey: .imgUrl) ?? ""
    }
}

/*
 친구 마커 리스트 결과
 */
struct FriendMarkerListResultDto: Codable {
    let list: [Marker]

    struct Marker: Codable {
        let memberId: Int
        let lat: String
        var latDouble: Double {
            let aes256 = AES256Util()
            let cryptoLat = aes256.decrypt(encoded: lat) ?? "0.0"
            return Double(cryptoLat) ?? 0.0
        }
        let lng: String
        var lngDouble: Double {
            let aes256 = AES256Util()
            let cryptoLng = aes256.decrypt(encoded: lng) ?? "0.0"
            return Double(cryptoLng) ?? 0.0
        }
        var coordinate: NMGLatLng {
            return NMGLatLng(lat: latDouble, lng: lngDouble)
        }
        let imgUrl: String
        let markerType: Int

        init() {
            self.memberId = 0
            self.lat = ""
            self.lng = ""
            self.imgUrl = ""
            self.markerType = 0
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<FriendMarkerListResultDto.Marker.CodingKeys> = try decoder
                .container(keyedBy: FriendMarkerListResultDto.Marker.CodingKeys.self)
            self.memberId = try container
                .decodeIfPresent(Int.self, forKey: FriendMarkerListResultDto.Marker.CodingKeys.memberId) ?? 0
            self.lat = try container
                .decodeIfPresent(String.self, forKey: FriendMarkerListResultDto.Marker.CodingKeys.lat) ?? ""
            self.lng = try container
                .decodeIfPresent(String.self, forKey: FriendMarkerListResultDto.Marker.CodingKeys.lng) ?? ""
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: FriendMarkerListResultDto.Marker.CodingKeys.imgUrl) ?? ""
            self.markerType = try container
                .decodeIfPresent(Int.self, forKey: FriendMarkerListResultDto.Marker.CodingKeys.markerType) ?? 0
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "friendsLocation"
    }
}

/*
 친구 디테일 정보 결과
 getMember(memberId) api
 OwnerNftList api
 combine
 */
struct FriendMarkerDetailDto {
    let memberId: Int
    let imgUrl: String
    let universityCode: String
    let profileName: String
    var isLocationBlock: Bool
    let nftList: [OwnerNftResultDto]
    let phoneNumber: String

    init(memberId: Int,
         imgUrl: String,
         universityCode: String,
         profileName: String,
         isLocationBlock: Bool,
         nftList: [OwnerNftResultDto],
         phoneNumber: String) {
        self.memberId = memberId
        self.imgUrl = imgUrl
        self.universityCode = universityCode
        self.profileName = profileName
        self.isLocationBlock = isLocationBlock
        self.nftList = nftList
        self.phoneNumber = phoneNumber
    }

    init() {
        self.memberId = 0
        self.imgUrl = ""
        self.universityCode = ""
        self.profileName = ""
        self.isLocationBlock = false
        self.nftList = []
        self.phoneNumber = ""
    }
}
/*
 내 위치 정보 업데이트 결과
 */
struct UploadMyLocationResultDto: Codable {
    let myLocation: Location

    struct Location: Codable {
        let lat: Double
        let lng: Double

        init() {
            self.lat = 0.0
            self.lng = 0.0
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<UploadMyLocationResultDto.Location.CodingKeys> = try decoder
                .container(keyedBy: UploadMyLocationResultDto.Location.CodingKeys.self)
            self.lat = try container
                .decodeIfPresent(Double.self, forKey: UploadMyLocationResultDto.Location.CodingKeys.lat) ?? 0.0
            self.lng = try container
                .decodeIfPresent(Double.self, forKey: UploadMyLocationResultDto.Location.CodingKeys.lng) ?? 0.0
        }
    }
}

/*
 대학교 중심 좌표 결과
 */
struct UniversityCenterResultDto: Codable {
    let lat: Double
    let lng: Double
    var coordinate: NMGLatLng {
        return NMGLatLng(lat: lat, lng: lng)
    }

    init() {
        self.lat = 0.0
        self.lng = 0.0
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
        self.lng = try container.decodeIfPresent(Double.self, forKey: .lng) ?? 0.0
    }
}

/*
 대학교 리스트 결과
 */
struct UniversityListResultDto: Codable {
    let list: [Item]

    struct Item: Codable {
        let imgUrl: String
        let lat: Double
        let lng: Double
        var coordinate: NMGLatLng {
            return NMGLatLng(lat: lat, lng: lng)
        }
        let universityCode: String
        let emailDomain: String
        let universityName: String

        let logoImgUrl: String
        let logoName: String

        /*
         선택했는가....
         */
        var isSelect: Bool = false

        init() {
            self.imgUrl = ""
            self.lat = 0.0
            self.lng = 0.0
            self.universityCode = ""
            self.emailDomain = ""
            self.universityName = ""
            self.isSelect = false
            self.logoImgUrl = ""
            self.logoName = ""
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<UniversityListResultDto.Item.CodingKeys> = try decoder
                .container(keyedBy: UniversityListResultDto.Item.CodingKeys.self)
            self.imgUrl = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.imgUrl) ?? ""
            self.lat = try container
                .decodeIfPresent(Double.self, forKey: UniversityListResultDto.Item.CodingKeys.lat) ?? 0.0
            self.lng = try container
                .decodeIfPresent(Double.self, forKey: UniversityListResultDto.Item.CodingKeys.lng) ?? 0.0
            self.universityCode = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.universityCode) ?? ""
            self.emailDomain = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.emailDomain) ?? ""
            self.universityName = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.universityName) ?? ""
            self.isSelect = try container
                .decodeIfPresent(Bool.self, forKey: UniversityListResultDto.Item.CodingKeys.isSelect) ?? false

            self.logoImgUrl = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.logoImgUrl) ?? ""
            self.logoName = try container
                .decodeIfPresent(String.self, forKey: UniversityListResultDto.Item.CodingKeys.logoName) ?? ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case list = "universityList"
    }
}
