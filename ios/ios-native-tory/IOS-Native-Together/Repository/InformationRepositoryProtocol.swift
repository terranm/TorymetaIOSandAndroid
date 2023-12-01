//
//  InformationRepositoryProtocol.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/07/20.
//

import Foundation
import RxSwift
import RxCocoa

extension InformationRepositoryProtocol {
    func getIntroList() -> Observable<[OnboardingDto]> {
        return Observable<[OnboardingDto]>.just([OnboardingDto(bordTitle: localizable.onBoardingIntro1BordTitle(),
                                                               bordTitleColor: "#6C5CE7",
                                                               title: localizable.onBoardingIntro1Title(),
                                                               description: "",
                                                               imageName: R.image.intro_1.name,
                                                               contentMode: .scaleAspectFit),
                                                 OnboardingDto(bordTitle: localizable.onBoardingIntro2BordTitle(),
                                                               bordTitleColor: "#3687FF",
                                                               title: localizable.onBoardingIntro2Title(),
                                                               description: localizable.onBoardingIntro2Description(),
                                                               imageName: R.image.intro_2.name,
                                                               contentMode: .right),
                                                 OnboardingDto(bordTitle: localizable.onBoardingIntro3BordTitle(),
                                                               bordTitleColor: "#A97639",
                                                               title: localizable.onBoardingIntro3Title(),
                                                               description: localizable.onBoardingIntro3Description(),
                                                               imageName: R.image.intro_3.name,
                                                               contentMode: .left)])
    }
}
