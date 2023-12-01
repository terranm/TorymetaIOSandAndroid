//
//  ParticipateSeminarHeaderTableViewCell.swift
//  IOS-Native-Together
//
//  Created by 도학태 on 2023/06/01.
//

import UIKit
import RxSwift
import RxCocoa

final class ParticipateSeminarHeaderTableViewCell: BaseTableViewCell {

    var disposeBag = DisposeBag()

    let titleLabel = WilldUILabel.create(font: .bold22,
                                         text: localizable.participateSeminarJoinApply(),
                                         color: .togetherPurple)

    let titleImgView = WilldUIImageView().then {
        $0.image = R.image.seminar_participate_represent()
        $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 78).isActive = true
    }

    lazy var applyButton = WilldUIView().then {
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        $0.backgroundColor = .togetherPurple
        $0.layer.cornerRadius = 22
        $0.addSubview(applyButtonLabel)
        applyButtonLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    let applyButtonLabel = WilldUILabel.create(font: .bold16,
                                               text: localizable.participateSeminarApply(),
                                               color: .togetherWhite)

    let lockImgView = WilldUIImageView.create(size: 34,
                                              assetsName: R.image.seminar_lock.name,
                                              type: .plain)

    let myTagLabel = WilldUILabel.create(font: .bold10,
                                         text: "MY",
                                         color: .togetherWhite)

    lazy var myTagView = WilldUIView().then {
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        $0.backgroundColor = UIColor("#103771")
        $0.layer.cornerRadius = 4
        /*
         UI 배치
         */
        $0.addSubview(myTagLabel)
        myTagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ data: SeminarDetailResultDto, _ seminarManager: SeminarManager) {

        lockImgView.isHidden = !data.isSecret

        /*
         신청한 세미나면 입장하기로
         */
        self.setTitleUI(data)
        seminarManager.setEntranceButtonUI(data: data) { [weak self] in
            guard let self = self else { return }
            self.myTagView.isHidden = $0.isMyTagHidden
            self.applyButtonLabel.text = $0.buttonTitle
            self.applyButton.backgroundColor = $0.buttonBackgroundColor
        }
        /*
         layout 배치
         */
        self.setDecorateLayout(data)
    }

    func layout() {
        contentView.addSubviews(titleLabel, titleImgView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(28)
        }

        titleImgView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(28)
        }
    }

    private func setDecorateLayout(_ data: SeminarDetailResultDto) {
        let memberId = repository.member.value.memberId
        if !data.isSecret && memberId != data.teacherId {
            contentView.addSubview(applyButton)
            applyButton.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                $0.leading.trailing.equalToSuperview().inset(28)
                $0.bottom.equalToSuperview().inset(40)
            }
        } else {
            if data.isSecret && memberId == data.teacherId {
                contentView.addSubviews(
                    applyButton,
                    lockImgView,
                    myTagView
                )
                applyButton.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                    $0.leading.trailing.equalToSuperview().inset(28)
                }

                lockImgView.snp.makeConstraints {
                    $0.top.equalTo(applyButton.snp.bottom).offset(18)
                    $0.trailing.equalToSuperview().inset(23)
                    $0.bottom.equalToSuperview().inset(10)
                }

                myTagView.snp.makeConstraints {
                    $0.centerY.equalTo(lockImgView)
                    $0.trailing.equalTo(lockImgView.snp.leading).offset(-8)
                }
            }

            if data.isSecret && memberId != data.teacherId {
                contentView.addSubviews(
                    applyButton,
                    lockImgView
                )
                applyButton.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                    $0.leading.trailing.equalToSuperview().inset(28)
                }

                lockImgView.snp.makeConstraints {
                    $0.top.equalTo(applyButton.snp.bottom).offset(18)
                    $0.trailing.equalToSuperview().inset(23)
                    $0.bottom.equalToSuperview().inset(10)
                }
            }

            if !data.isSecret && memberId == data.teacherId {
                contentView.addSubviews(
                    applyButton,
                    myTagView
                )
                applyButton.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                    $0.leading.trailing.equalToSuperview().inset(28)
                }

                myTagView.snp.makeConstraints {
                    $0.top.equalTo(applyButton.snp.bottom).offset(22)
                    $0.trailing.equalToSuperview().inset(28)
                    $0.bottom.equalToSuperview().inset(10)
                }
            }
        }
    }

    private func setTitleUI(_ data: SeminarDetailResultDto) {
        if repository.member.value.memberId != data.teacherId {
            if !data.isSecret {
                titleLabel.text = localizable.participateSeminarJoin()
            } else {
                if data.isParticipate {
                    titleLabel.text = localizable.participateSeminarJoin()
                } else {
                    titleLabel.text = localizable.participateSeminarApplyIt()
                }
            }
        } else {
            titleLabel.text = localizable.participateSeminarEntrance()
        }
    }
}
