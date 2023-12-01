# TORYMETA

&nbsp;

## Dependencies

### Swift Package Manager
|Dependency|Version|
|---|---|
|ActionSheetPicker-3.0|2.7.1(forked)|
|Alamofire|5.6.4|
|BSImagePicker|3.3.1|
|CryptoSwift|1.8.0|
|DeviceKit|4.9.0|
|EasyTipView|2.1.0|
|Firebase/Analytics|10.5.0|
|Firebase/Crashlytics|10.5.0|
|Firebase/DynamicLinks|10.5.0|
|Firebase/Messaging|10.5.0|
|Kingfisher|7.8.1|
|NMapsMap|3.16.2(forked:https://github.com/jaemyeong/NMapsMap))|
|PanModal|1.2.7|
|ReachabilitySwift|5.0.0|
|RxAlamofire|6.1.1|
|RxCocoa|6.5.0|
|RxDataSources|5.0.0|
|RxGesture|4.0.4|
|RxSwift|6.5.0|
|R.swift|7.3.0|
|SnapKit|5.6.0|
|SwiftDate|7.0.0(forked)|
|Then|3.0.0|
|Toast-Swift|5.0.1|
|XLPagerTabStrip|9.1.0|


## Unity 라이브러리 추가

압축해제 후 프로젝트 루트에 붙여넣기


&nbsp;


# MISC

## ssh 키 생성 및 깃헙 등록

1. 키 생성
    ```
    $ ssh-keygen ssh-keygen -t ecdsa -b 521 -C “메일주소”
    ```

2. 공개키 복사
    ```
    cat ~/.ssh/id_ecdsa.pub | pbcopy
    ```

3. GitHub에 등록

    https://github.com/settings/keys

&nbsp;

## Unity 라이브러리를 제외하고 빌드하는 방법

0. AppConfigure -> false
1. 물리적 경로 iOSLibrary 지우기, Xcode Unity-iphone 지우기
2. Project General Framework에서 Unity FrameWork 지우기
3. [:*** Unity Release:] 유니티 관련한 코드 주석
4. Git merge 하기

&nbsp;

## NOTE
* 23.10.19 CocoaPods 제거