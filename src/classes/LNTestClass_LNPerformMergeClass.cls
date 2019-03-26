@isTest
public class LNTestClass_LNPerformMergeClass {
    
static testmethod void LNPerformMergeClasstest(){
//String req = '<?xml version="1.0" encoding="UTF-8"?&gt>';

String req = '<ns3:CustomerHierarchy xmlns:ns3="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns12="http://services.lexisnexis.com/xmlschema/commontracking/1" xmlns:ns11="http://services.lexisnexis.com/xmlschema/header/1">';
req += '<ns11:Header>';
req += '<ns12:commonTrackingMessage>';
req += '<ns12:dataGroup>';
req += '<ns12:transId>ECM:Repair:1107080:1</ns12:transId>';
req += '</ns12:dataGroup>';
req += '</ns12:commonTrackingMessage>';
req += '</ns11:Header>';
req += '<ns3:DataArea>';
req += '<ns3:CustomerHierarchyBO>';
req += '<ns3:ProcessFlag>Y</ns3:ProcessFlag>';
req += '<ns3:CustomerHierarchyType>OC Merge</ns3:CustomerHierarchyType>';
req += '<ns3:OC OCPGUID="urn:ecm:D3424ZTG7PZ" TLCPGUID="urn:ecm:0000009M7" BUPGUID="urn:ecm:0000003O8">';
req += '<ListOfOCVictims/>';
//req += '<OCVictim OCPGUID="urn:ecm:424ZZZ949" TLCPGUID="urn:ecm:00000169F" BUPGUID="urn:ecm:0000003O8"/>';
//req += '</ListOfOCVictims>';    
req += '</ns3:OC>';
req += '<ns3:ListOfFA/>';
req += '<ns3:ListOfPOB>';
req += '<ns3:POB POBPGUID="urn:ecm:422N6X67X" AddressPGUID="urn:ecm:422N6X66M" ChangeStatus="Y" >';
req += '<ns3:ListOfPOBVictims>';
req += '<ns3:POBVictim POBPGUID="urn:ecm:1000ABZSH" AddressPGUID="urn:ecm:10002ZL72" />';
req += '</ns3:ListOfPOBVictims>';    
req += '</ns3:POB>';
req += '</ns3:ListOfPOB>';
req += '<ns3:ListOfAP>';
req += '<ns3:AP APPGUID="urn:ecm:1000FGYG3" TLCPGUID="urn:ecm:0000000JM" PersonPGUID="urn:ecm:10004J2N9">';
req += '<ns3:ListOfAPVictims/>';
//req += '<ns3:APVictim APPGUID="urn:ecm:D3424ZTG7MJ" TLCPGUID="urn:ecm:0000000JM" PersonPGUID="urn:ecm:10008T9DY" />';     
//req += '</ns3:ListOfAPVictims>';     
req += '</ns3:AP>';
req += '</ns3:ListOfAP>';
req += '<ns3:ListOfAgreement/>';
req += '</ns3:CustomerHierarchyBO>';
req += '</ns3:DataArea>';
req += '</ns3:CustomerHierarchy>';
    
    
    LNPerformMergeClass LNPerformMerge = new LNPerformMergeClass ();
    List<String> Str = LNPerformMerge.doPost(req);
    System.assertEquals(str[0], 'SUCCESS');
}
    
static testmethod void LNPerformMergeClasstest1()
{
   //  String req ='';
//String Body = '<?xml version="1.0" encoding="UTF-8"?&gt>';
String Body = '<ns1:CustomerHierarchy xmlns:ns1="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns2="http://services.lexisnexis.com/xmlschema/header/1">';
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

//System.debug(Body);


     Test.setMock(HttpCalloutMock.class, new LNTestClass_MockHttpResponse());
     //LNPerformMergeClass LNPerformMerge = new LNPerformMergeClass ();
     //String res = LNPerformMerge.sendacktoMW(Body);
     LNPerformMergeClass.sendacktoMW(Body);
	 //System.assertEquals(res, Body);
    //System.assertEquals(expected, actual);
//	 System.assertEquals(str[2], Body);
     
 }
}