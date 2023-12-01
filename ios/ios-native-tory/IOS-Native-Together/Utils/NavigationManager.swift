//
//  NavigationManager.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

final class NavigationManager {

    private var disposeBag = DisposeBag()

    static func initNavigation(_ backImgName: String = R.image.common_back.name,
                               _ backgroundColor: UIColor = .togetherWhite,
                               _ itemColor: UIColor = .togetherBlack,
                               _ fontColor: UIColor = .togetherBlack,
                               _ font: TogetherFontType = .bold20) {

        /*
         iOS 애플리케이션 전체에서 UINavigationBar 객체의 속성을
         설정 할 수 있는 인스턴스
         */
        let appearance = UINavigationBar.appearance()

        /*
         UINavigationBar 하단에 불투명한 그림자 표시에 관한 속성
         */
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.shadowImage = UIImage()

        /*
         뒤로가기 이미지에 대한 속성
         */
        appearance.backIndicatorImage = UIImage(named: backImgName)
        appearance.backIndicatorTransitionMaskImage = UIImage(named: backImgName)

        /*
         NavigationBar 투명도에 대한 속성
         */
        appearance.isTranslucent = true

        /*
         탭바의 배경화면을 설정하는 속성
         */
        appearance.barTintColor = .togetherWhite

        /*
         NavigationBar 탭바의 아이템 색깔을 설정하는 속성
         */
        appearance.tintColor = itemColor

        /*
         title font를 지정
         */

        let fontDto = FontValue.getFont(with: font)
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: fontColor,
            NSAttributedString.Key.font: UIFont(name: fontDto.fontName, size: fontDto.fontSize)!
        ]
    }

    func setItem(text: String,
                 textColor: UIColor,
                 font: TogetherFontType,
                 padding: CGFloat = 0,
                 _ tapClosure: @escaping (UIView) -> Void = { _ in }) -> [UIBarButtonItem] {

        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = padding

        let view = UILabel().then {
            $0.text = text
            $0.textColor = textColor
            let fontDto = FontValue.getFont(with: font)
            $0.font = UIFont(name: fontDto.fontName, size: fontDto.fontSize)
        }

        view.rx.baseTapGesture()
            .bind(onNext: {
                tapClosure(view)
            })
            .disposed(by: disposeBag)

        return [fixedSpace, UIBarButtonItem(customView: view)]
    }

    func setItem(itemName: String,
                 itemSize: CGFloat = 32,
                 padding: CGFloat = 0,
                 _ tapClosure: @escaping (UIView) -> Void = { _ in }) -> [UIBarButtonItem] {

        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = padding

        let view = UIImageView().then {
            /*
             Icon 사이즈 및 Icon Img 설정
             */
            $0.image = UIImage(named: itemName)
            if itemSize != 0 {
                $0.snp.makeConstraints {
                    $0.width.height.equalTo(itemSize)
                }
            }
        }

        /*
         버튼 탭
         NavigationManager을 ViewController의 멤버로 생성한다.
         멤버로 생성하여 ButtonTap의 Observer를 ViewController와 생명주기와 일치 시킨다.
         */
        view.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                tapClosure(view)
            })
            .disposed(by: disposeBag)

        return [fixedSpace, UIBarButtonItem(customView: view)]
    }

    func setItems(itemNames: [String],
                  itemSize: Int = 32,
                  ltPadding: CGFloat = 0,
                  betweenPadding: CGFloat = 0,
                  _ tapClosure: @escaping (Int) -> Void = { _ in }) -> [UIBarButtonItem] {
        if itemNames.count > 1 {
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            /*
             iOS에서 기본 Right, Left 여백 16
             iOS에서 기본 Icon 사이의 여백 8
             */
            fixedSpace.width = ltPadding
            var result = itemNames.enumerated().map { index, itemName in
                let view = UIImageView().then {
                    /*
                     Icon 사이즈 및 Icon Img 설정
                     */
                    $0.image = UIImage(named: itemName)
                    if itemSize != 0 {
                        $0.snp.makeConstraints {
                            $0.width.height.equalTo(itemSize)
                        }
                    }
                }

                /*
                 버튼 탭
                 NavigationManager을 ViewController의 멤버로 생성한다.
                 멤버로 생성하여 ButtonTap의 Observer를 ViewController와 생명주기와 일치 시킨다.
                 */
                view.rx.tapGesture()
                    .when(.recognized)
                    .bind(onNext: { _ in
                        /*
                         index를 delegate에 전달한다
                         사용을 한다면 Index를 통해서 어떠한 icon을 선택했는지
                         판단이 가능하다.
                         */
                        tapClosure(index)
                    })
                    .disposed(by: disposeBag)

                return UIBarButtonItem(customView: view)
            }

            /*
             Icon 사이의 여백을 결정하는 로직
             */
//            for index in 0..<result.count + (result.count - 1) {
//                if index % 2 == 1 {
//                    let betweenSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//                    betweenSpace.width = betweenPadding - 8
//                    result.insert(betweenSpace, at: index)
//                }
//            }
            for index in 0..<result.count + (result.count - 1) where index % 2 == 1 {
                let betweenSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                betweenSpace.width = betweenPadding - 8
                result.insert(betweenSpace, at: index)
            }

            result.insert(fixedSpace, at: 0)
            return result
        } else {
            return []
        }
    }
}
