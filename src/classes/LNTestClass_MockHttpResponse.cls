@isTest
global class LNTestClass_MockHttpResponse implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
     
String Body ='<ns1:CustomerHierarchy xmlns:ns1="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns2="http://services.lexisnexis.com/xmlschema/header/1">';
Body += '<ns2:Header xmlns:ns3="http://services.lexisnexis.com/xmlschema/commontracking/1">';
Body += '<ns3:commonTrackingMessage>';
Body += '<ns3:dataGroup>';
Body += '<ns3:transId>ECM:Repair:1107080:1</ns3:transId>';
Body += '<ns3:errorGroup/>';
Body += '</ns3:dataGroup>';
Body += '</ns3:commonTrackingMessage>';
Body += '<ns2:Security/>';
Body += '<ns2:SourceAppName/>';
Body += '<ns2:StatusCode>200</ns2:StatusCode>';
Body += '<ns2:StatusMessage>Success</ns2:StatusMessage>';
Body += '<ns2:MessageRecipientSystem/>';
Body += '<ns2:EntityName/>';
Body += '<ns2:EntityOperation/>';
Body += '<ns2:AcknowledgmentType/>';    
Body += '</ns2:Header>';
Body += '<ns1:DataArea/>';
Body += '</ns1:CustomerHierarchy>'; 
	 
     HttpResponse res = new HttpResponse();
     res.setBody(Body);
     res.setHeader('Content-Type', 'application/xml');
     res.setStatus('Success');
     res.setStatusCode(200);
     return res;
    }
}