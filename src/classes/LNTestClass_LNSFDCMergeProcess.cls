@isTest
public class LNTestClass_LNSFDCMergeProcess {
static testMethod void TestLNSFDCMergeProcess() {
    
String postData ='<ns3:CustomerHierarchy xmlns:ns3="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns12="http://services.lexisnexis.com/xmlschema/commontracking/1" xmlns:ns11="http://services.lexisnexis.com/xmlschema/header/1">';
postData += '<ns11:Header>';
postData += '<ns12:commonTrackingMessage>';
postData += '<ns12:dataGroup>';
postData += '<ns12:transId>ECM:Repair:1107080:1</ns12:transId>';
postData += '</ns12:dataGroup>';
postData += '</ns12:commonTrackingMessage>';
postData += '</ns11:Header>';
postData += '<ns3:DataArea>';
postData += '<ns3:CustomerHierarchyBO>';
postData += '<ns3:ProcessFlag>Y</ns3:ProcessFlag>';
postData += '<ns3:CustomerHierarchyType>OC Merge</ns3:CustomerHierarchyType>';
postData += '<ns3:OC OCPGUID="urn:ecm:D3424ZTG7PZ" TLCPGUID="urn:ecm:0000009M7" BUPGUID="urn:ecm:0000003O8">';
postData += '</ns3:OC>';
postData += '<ns3:ListOfFA/>';
postData += '<ns3:ListOfPOB/>';
postData += '<ns3:ListOfAP/>';
postData += '<ns3:ListOfAgreement/>';
postData += '</ns3:CustomerHierarchyBO>';
postData += '</ns3:DataArea>';
postData += '</ns3:CustomerHierarchy>';
    
    Merge__c Mer = New Merge__c();
    Mer.Incoming_XML__c = postData;
    Mer.ProcessFlag__c = False;
    Insert Mer;
    
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    //req.addHeader('httpMethod', 'POST');
    req.requestUri = '/services/apexrest/LNSFDCMergeProcess/';
    req.httpMethod = 'POST';
    req.requestBody = Blob.valueof(postData);
    
    RestContext.request = req;
    RestContext.response= res;
    //Test.startTest();
    LNSFDCMergeProcess.doPost();
    //Test.stopTest();
}
}