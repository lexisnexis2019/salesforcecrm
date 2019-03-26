@isTest
public class LNTestClass_LNPerformMergeTrigger {

    static testmethod void triggertest(){
String req ='<ns3:CustomerHierarchy xmlns:ns3="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns12="http://services.lexisnexis.com/xmlschema/commontracking/1" xmlns:ns11="http://services.lexisnexis.com/xmlschema/header/1">';
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
req += '</ns3:OC>';
req += '<ns3:ListOfFA/>';
req += '<ns3:ListOfPOB/>';
req += '<ns3:ListOfAP/>';
req += '<ns3:ListOfAgreement/>';
req += '</ns3:CustomerHierarchyBO>';
req += '</ns3:DataArea>';
req += '</ns3:CustomerHierarchy>';    

Merge__c Mer = new Merge__c ();
Mer.Incoming_XML__c = req;
Mer.ProcessFlag__c = False;        
Insert Mer;        
    }
}