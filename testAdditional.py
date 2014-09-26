
import unittest
import os
import testLib

class TestLogin(testLib.RestTestCase):
    """Test Login"""
    def assertResponse(self, respData, count = 2, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLogin(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)

class TestBadCredential(testLib.RestTestCase):
    """Test Bad Credentials"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        expected['message'] = "Cannot find the user/password pair in the database"
        self.assertDictEqual(expected, respData)

    def testBadCredential(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData)


class TestReset(testLib.RestTestCase):
    """Test Reset"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        self.assertDictEqual(expected, respData)

    def testReset(self):
        respData = self.makeRequest("/TESTAPI/resetFixture", method="POST")
        self.assertResponse(respData)

class TestUserExist(testLib.RestTestCase):
    """Test User Exist in Field"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        expected["message"] = "invalid user name (empty or longer than MAX_USERNAME_LENGTH)"
        self.assertDictEqual(expected, respData)

    def testUserExist(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(respData)

class TestMaxUserLength(testLib.RestTestCase):
    """Test Max User Length"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_USERNAME):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        expected["message"] = "invalid user name (empty or longer than MAX_USERNAME_LENGTH)"
        self.assertDictEqual(expected, respData)

    def testMaxUserLength(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '*'*129, 'password' : 'password'} )
        self.assertResponse(respData)

class TestMaxPasswordLength(testLib.RestTestCase):
    """Test Max Password Length"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        expected["message"] = "invalid password name (longer than MAX_PASSWORD_LENGTH)"
        self.assertDictEqual(expected, respData)

    def testMaxPasswordLength(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password' : '*'*129} )
        self.assertResponse(respData)




