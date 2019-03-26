/*
Author: Raghav Kulkani
Description:This is to parse the Merge XML from MW and perform a SFDC Merge Process. It uses XML DOM Parser.
Any changes to incoming XML requires node/element reading change and proper testing.
The URL to test is "<node>.salesforce.com/services/apexrest/LNSFDCMergeProcess" after getting the authentication.
This can be tested on Workench Rest Explorer with URL:/services/apexrest/LNSFDCMergeProcess
*/ 

@RestResource(urlMapping='/LNSFDCMergeProcess/*')
global with sharing class LNSFDCMergeProcess {
    @HttpPost
    global static void doPost(){
        String xmlMessage = null;
       //String Ack = '<?xml version="1.0" encoding="UTF-8"?>';
        //Ack+= '<Statuscode>200</Statuscode>';
        //Ack += '<StatusMessage>Success</StatusMessage>';
        
       DOM.Document doc = new DOM.Document();
       dom.XmlNode Response = doc.createRootElement('CustomerHierarchyResponse', null, null);
       Response.addChildElement('Statuscode', null, null).addTextNode('200');
       Response.addChildElement('StatusMessage', null, null).addTextNode('Success');
       String Ack = doc.toXmlString();
	//System.debug(Ack);
        RestContext.response.addHeader('Content-Type', 'text/xml');
        RestContext.response.responseBody = Blob.valueOf(Ack);
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        try{
            if (null != req.requestBody) {
                xmlMessage = req.requestBody.toString();
                if (null != xmlMessage || '' != xmlMessage){
                    if(xmlMessage.length() < 131000){
                    Merge__c Mer = New Merge__c();
                    Mer.Incoming_XML__c = xmlMessage;
                    Mer.ProcessFlag__c = False;
                    Insert Mer;
                    }
                    else{
                     LNPerformMergeClass LNPerformMerge = new LNPerformMergeClass();
                        List<String> MergeResponse =  new List<String>();
                        MergeResponse = LNPerformMerge.doPost(XMLMessage);
                    }
                }
            }
        } 
        catch(Exception e){}
        //return Ack;
        //return doc;
    }
}