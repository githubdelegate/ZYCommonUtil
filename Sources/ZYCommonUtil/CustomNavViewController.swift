//
//  File.swift
//  
//
//  Created by edz on 2021/1/12.
//
import Foundation
import UIKit
import SnapKit

public protocol NavBarViewDelegate: UIViewController {
    func clickNavBar(type: Int)
}

open class NavBarAppear {
    public static var `default` = NavBarAppear()
    open var bgColor: UIColor = .white
    open var titleFont: UIFont = UIFont.systemFont(ofSize: 20)
    open var titleColor: UIColor = .black
    open var lineHid: Bool = true
    open var backImage: String = ""
}

open class NavBarView: UIView {
    open var backBtn: UIButton!
    open var titleLbl: UILabel!
    open var rightBtn: UIButton!
    open var right2Btn: UIButton!
    open var line: UIView!
    weak open var delegate: NavBarViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

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
//            make.size.equalTo(CGSize(width: 30, height: 30))
            make.height.equalTo(30)
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
        
        line = UIView()
        line.backgroundColor = UIColor(hexString: "#979797")
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        backgroundColor = NavBarAppear.default.bgColor
        titleLbl.font = NavBarAppear.default.titleFont
        titleLbl.textColor = NavBarAppear.default.titleColor
        line.isHidden = NavBarAppear.default.lineHid
        backBtn.setImage(UIImage(named: NavBarAppear.default.backImage), for: .normal)
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
            } else if btn == backBtn {
                if let vc = next?.next, vc is UIViewController, let v = vc as? UIViewController {
                    v.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class CustomNavViewController: UIViewController, NavBarViewDelegate {
   open var navView: NavBarView?

    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        navView = NavBarView()
        view.addSubview(navView!)
        navView?.delegate = self
    }

    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(" navbar = \(view.safeAreaInsets) ")

        navView?.snp.makeConstraints({ make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(self.view.safeAreaInsets.top + 44)
        })
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @objc dynamic open func clickNavBar(type: Int) {
        if type == 1 {
            navigationController?.popToRootViewController(animated: true)
        } else if type == 2 {
        }
    }
}
