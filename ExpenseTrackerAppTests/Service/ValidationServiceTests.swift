//
//  ValidationServiceTests.swift
//  ExpenseTrackerAppTests
//
//  Created by Matvej Adamkevicius on 15/11/2025.
//

import XCTest
@testable import ExpenseTrackerApp

final class ValidationServiceTests: XCTestCase {
    
    func testSuccessfulEmailValidation() {
        //  given
        let email = "test@gmail.com"
        let validationService = ValidationService()
        
        //  when
        let emailValidation = validationService.emailValidation(email: email)
        
        //  then
        XCTAssertEqual(emailValidation, true)
    }
    
    func testUnsuccessfulEmailValidation() {
        //  given
        let email = "testgmail.com"
        let validationService = ValidationService()
        
        //  when
        let emailValidation = validationService.emailValidation(email: email)
        
        //  then
        XCTAssertEqual(emailValidation, false)
    }
    
    func testSuccessfulUsernameValidation() {
        //  given
        let username = "test"
        let validationService = ValidationService()
        
        //  when
        let usernameValidation = validationService.usernameValidation(username: username)
        
        //  then
        XCTAssertEqual(usernameValidation, true)
    }
    
    func testUnsuccessfulUsernameValidation() {
        //  given
        let username = "test2"
        let validationService = ValidationService()
        
        //  when
        let usernameValidation = validationService.usernameValidation(username: username)
        
        //  then
        XCTAssertEqual(usernameValidation, false)
    }
    
    func testSuccessfulFullNameValidation() {
        //  given
        let fullName = "John Doe"
        let validationService = ValidationService()
        
        //  when
        let fullNameValidation = validationService.fullNameValidation(fullName: fullName)
        
        //  then
        XCTAssertEqual(fullNameValidation, true)
    }
    
    func testUnsuccessfulFullNameValidation() {
        //  given
        let fullName = "john Doe"
        let validationService = ValidationService()
        
        //  when
        let fullNameValidation = validationService.fullNameValidation(fullName: fullName)
        
        //  then
        XCTAssertEqual(fullNameValidation, false)
    }
    
    func testSuccessfulPasswordValidation() {
        //  given
        let password = "Test123!"
        let validationService = ValidationService()
        
        //  when
        let passwordValidation = validationService.passwordValidation(password: password)
        
        //  then
        XCTAssertEqual(passwordValidation, true)
    }
    
    func testUnuccessfulPasswordValidation() {
        //  given
        let password = "test123"
        let validationService = ValidationService()
        
        //  when
        let passwordValidation = validationService.passwordValidation(password: password)
        
        //  then
        XCTAssertEqual(passwordValidation, false)
    }
}
