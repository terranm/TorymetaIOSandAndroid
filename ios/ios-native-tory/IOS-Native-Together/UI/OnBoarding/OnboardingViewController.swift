//
//  OnboardingViewController2.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/02/11.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingViewController: RefactoringBaseViewController<RefactoringBaseViewModel> {

    private let scrollView = UIScrollView()
    private let startButton = UIImageView()
    private let startButtonLabel = UILabel()
    private let pageControl = UIPageControl()

    override func attribute() {
        super.attribute()

        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        startButton.image = R.image.newMain_Meta_background()
        startButton.layer.cornerRadius = 16

        startButtonLabel.text = localizable.onBoardingStartButtonText()
        startButtonLabel.configureFont(.bold20)
        startButtonLabel.textColor = .togetherWhite

        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .togetherBlack.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = .togetherBlack
    }

    override func layout() {
        super.layout()
        view.addSubviews(scrollView, pageControl, startButton, startButtonLabel)
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(startButton.snp.top)
        }
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top).offset(-32)
            $0.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
        startButtonLabel.snp.makeConstraints {
            $0.center.equalTo(startButton)
        }
    }

    override func bind(_ viewModel: RefactoringBaseViewModel) {
        super.bind(viewModel)
        repository.getIntroList()
            .bind { [weak self] onboardingDtos in
                self?.setScrollSubviews(onboardingDtos)
            }
            .disposed(by: disposeBag)

        startButton.rx.baseTapGesture()
            .bind { [weak self] in
                self?.leaveIntro()
            }
            .disposed(by: disposeBag)

        scrollView.rx.contentOffset
            .filter { $0.x > 0 }
            .bind { [weak self] offset in
                guard let self else { return }
                self.pageControl.currentPage = Int(round(offset.x / self.scrollView.frame.width))
            }
            .disposed(by: disposeBag)
    }
}

extension OnboardingViewController {
    private func setScrollSubviews(_ onboardingDtos: [OnboardingDto]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            onboardingDtos.enumerated().forEach { (index, onboardingDto) in
                let introView = OnboardingContentView(onboardingDto: onboardingDto)
                self.scrollView.addSubview(introView)
                introView.snp.makeConstraints {
                    $0.top.equalTo(self.scrollView.snp.top)
                    $0.left.equalTo(CGFloat(index) * UIScreen.main.bounds.width)
                    $0.size.equalTo(self.scrollView)
                }
            }

            let width = UIScreen.main.bounds.width * CGFloat(onboardingDtos.count)
            self.scrollView.contentSize = CGSize(width: width, height: self.scrollView.frame.height)
        }
    }

    private func leaveIntro() {
        let url = ToryWebViewURL(path: ToryWebViewURLType.login.path)
        let viewModel = CommonWebViewModel()
        let commonWebViewController = CommonWebViewController(urlProtocol: url, viewModel: viewModel)

        changeRootViewController(viewController: commonWebViewController)
    }
}
