//
//  File.swift
//  
//
//  Created by edz on 2021/1/12.
//
import Foundation
import UIKit
import SnapKit

public protocol NavBarViewDelegate {
    func clickNavBar(type: Int)
}

public class NavBarView: UIView {
    var backBtn: UIButton!
    var titleLbl: UILabel!
    var rightBtn: UIButton!
    var right2Btn: UIButton!

    var delegate: NavBarViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "common_back_white"), for: .normal)
        addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.bottom.equalTo(-7)
            make.left.equalTo(10)
        }

        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)

        titleLbl = UILabel()
        titleLbl.textColor = .white
        titleLbl.font = UIFont(name: "PingFangSC-Medium", size: 17)
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn.snp.centerY)
        }

        rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "common_home_white"), for: .normal)
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.bottom.equalTo(-7)
            make.right.equalTo(-15)
        }
        rightBtn.addTarget(self, action: #selector(actionClick(btn:)), for: .touchUpInside)

        right2Btn = UIButton(type: .custom)
        right2Btn.isHidden = true
        right2Btn.setImage(UIImage(named: "common_home_white"), for: .normal)
        addSubview(right2Btn)
        right2Btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.bottom.equalTo(-7)
            make.right.equalTo(rightBtn.snp.left).offset(-15)
        }
        right2Btn.addTarget(self, action: #selector(actionClick(btn:)), for: .touchUpInside)
    }

    @objc func back() {
        if let vc = next?.next, vc is UIViewController, let v = vc as? UIViewController {
            v.navigationController?.popViewController(animated: true)
        }
    }

    @objc func actionClick(btn: UIButton) {
        if delegate != nil {
            if btn == rightBtn {
                delegate?.clickNavBar(type: 1)
            } else if btn == right2Btn {
                delegate?.clickNavBar(type: 2)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CustomNavViewController: UIViewController, NavBarViewDelegate {
    var navView: NavBarView?

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        navView = NavBarView()
        view.addSubview(navView!)
        navView?.delegate = self
    }

    override public func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(" navbar = \(view.safeAreaInsets) ")

        navView?.snp.makeConstraints({ make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(self.view.safeAreaInsets.top + 44)
        })
    }

    @objc dynamic public func clickNavBar(type: Int) {
        if type == 1 {
            navigationController?.popToRootViewController(animated: true)
        } else if type == 2 {
        }
    }
}
