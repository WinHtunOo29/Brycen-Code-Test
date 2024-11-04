//
//  Brycen_Code_TestTests.swift
//  Brycen Code TestTests
//
//  Created by Win Htun Oo on 01/11/2024.
//

import XCTest
@testable import Brycen_Code_Test

final class Brycen_Code_TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsValidPhoneNumber() {
        // Valid phone numbers
        XCTAssertTrue(ValidateCustomerData.isValidPhoneNumber(phone: "0912345678"), "Valid phone number should return true")
        XCTAssertTrue(ValidateCustomerData.isValidPhoneNumber(phone: "0923456789"), "Valid phone number should return true")
        XCTAssertTrue(ValidateCustomerData.isValidPhoneNumber(phone: "093456789"), "Valid phone number should return true")
        XCTAssertTrue(ValidateCustomerData.isValidPhoneNumber(phone: "081234567"), "Phone number starting with 08 should return false")
        
        // Invalid phone numbers
        XCTAssertFalse(ValidateCustomerData.isValidPhoneNumber(phone: "09123"), "Too short phone number should return false")
        XCTAssertFalse(ValidateCustomerData.isValidPhoneNumber(phone: "091234567890"), "Too long phone number should return false")
        XCTAssertFalse(ValidateCustomerData.isValidPhoneNumber(phone: "09abcdef"), "Phone number with letters should return false")
        XCTAssertFalse(ValidateCustomerData.isValidPhoneNumber(phone: "1234567890"), "Phone number not starting with 09 should return false")
        XCTAssertFalse(ValidateCustomerData.isValidPhoneNumber(phone: ""), "Empty phone number should return false")
    }
    
    func testIsValidEmail() {
            // Valid email addresses
        XCTAssertTrue(ValidateCustomerData.isValidEmail("test@example.com"), "Valid email should return true")
        XCTAssertTrue(ValidateCustomerData.isValidEmail("test.user@example.co"), "Valid email should return true")
        
        // Invalid email addresses
        XCTAssertFalse(ValidateCustomerData.isValidEmail("plainaddress"), "Email without @ and domain should return false")
        XCTAssertFalse(ValidateCustomerData.isValidEmail("test@.com"), "Email with missing local part should return false")
        XCTAssertFalse(ValidateCustomerData.isValidEmail("test@example"), "Email without domain extension should return false")

        XCTAssertFalse(ValidateCustomerData.isValidEmail("test@com."), "Email with trailing dot in domain should return false")
        XCTAssertFalse(ValidateCustomerData.isValidEmail("test@com..com"), "Email with consecutive dots in domain should return false")
        XCTAssertFalse(ValidateCustomerData.isValidEmail(""), "Empty email should return false")
    }

}
