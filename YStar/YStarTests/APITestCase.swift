//
//  APITestCase.swift
//  YStar
//
//  Created by mu on 2017/7/10.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import XCTest
@testable import YStar

class APITestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    //功能测试：测试登录功能（异步测试）
    func testLogin() {
        let expectOption = expectation(description: "登录测试")
        let param = LoginRequestModel()
        param.phone = "18657195470"
        param.pwd = "123456".md5()
        AppAPIHelper.commen().login(model: param, complete: { (result) -> ()? in
            
            if let object = result as? StarUserModel{
                if let uid = object.userinfo?.id{
                    ShareModelHelper.instance().uid = Int(uid)
                    UserDefaults.standard.set(uid, forKey: AppConst.UserDefaultKey.uid.rawValue)
                }
                if let phone = object.userinfo?.phone{
                    ShareModelHelper.instance().phone = phone
                    UserDefaults.standard.set(phone, forKey: AppConst.UserDefaultKey.phone.rawValue)
                }
                ShareModelHelper.instance().token = object.token
                UserDefaults.standard.set(object.token, forKey: AppConst.UserDefaultKey.token.rawValue)
                expectOption.fulfill()
            }
            return nil
        }, error: nil)
        // waitForExpectations(timeout: 15, handler: nil)
        self.waitForExpectations(timeout: 15) { (error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    //逻辑测试举例： 测试期望结果与实际结果是否相等
    func testAdd(){
        let expectValue = 30
        let actualValue = 30
        XCTAssertEqual(expectValue, actualValue)
    }
    
    //性能测试：测试登录功能和Add方法性能表现
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            self.testLogin()
        }
    }
    
    
    
}
