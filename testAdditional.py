
import unittest
import os
import testLib

class TestBadCredential(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        expected['message'] = "Cannot find the user/password pair in the database"
        self.assertDictEqual(expected, respData)

    def testAdd1(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData)


