/*
Author: Raghav Kulkani
Description:
    This is to parse the Merge XML from MW and perform a SFDC Merge Process. It uses XML DOM Parser.
      Any changes to incoming XML requires node/element reading change and proper testing.
*/ 
public class LNPerformMergeClass {
    //public static String MWResponse;
    //public static String RespBody;
    //public String sendacktoMW(String Body1){
    @future (callout=true)
    public static void sendacktoMW(String Body1){
        //String Body1=Body;
        Http http = new Http();
         //HttpRequest req = new HttpRequest();
        //HTTPResponse res = new HTTPResponse();
        HttpRequest req = new HttpRequest();
    	HttpResponse res = new HttpResponse();        
        String RespBody='';
        try{
        //req.setEndpoint ('https://cdc2-services.lexisnexis.com/business/customerhierarchy/ack');
        req.setEndpoint (System.Label.LNSFDCMergeURL);
        req.setMethod ('PUT');
        req.setHeader('Content-Type', 'text/xml');
        //req.setBody('<ns1:CustomerHierarchy xmlns:ns1="http://services.lexisnexis.com/xmlschema/customerhierarchy/1" xmlns:ns2="http://services.lexisnexis.com/xmlschema/header/1"><ns2:Header xmlns:ns3="http://services.lexisnexis.com/xmlschema/commontracking/1"><ns3:commonTrackingMessage><ns3:dataGroup><ns3:transId><ns3:transId>ECM:Repair:681921:2</ns3:transId></ns3:transId><ns3:errorGroup/></ns3:dataGroup></ns3:commonTrackingMessage><ns2:Security/><ns2:SourceAppName/><ns2:StatusCode>200</ns2:StatusCode><ns2:StatusMessage>Success</ns2:StatusMessage><ns2:MessageRecipientSystem/><ns2:EntityName/><ns2:EntityOperation/><ns2:AcknowledgmentType/></ns2:Header><ns1:DataArea/></ns1:CustomerHierarchy>');
        req.setBody(Body1);
        res= http.send(req);
        RespBody = res.getBody();
        //System.debug(res.getBody());
        
            }
            catch(Exception e2){
                
            }
        //return RespBody;
        }
        public List<String> doPost(String xmlMessage){
       // String xmlMessage = null;
        String Header;
        String HeaderElName;
        String RootElementName;
        String DataAreaEl;
        String CustomerHierarchyBOEl;
        String Child1;
        String Child1_1;
        String Child2;
        String Child2_2;
        String Child3;
        String Child4;
        String Child5;
        String Child6;
        String Child7;
        String Child8;
        String Child9;
        String Child10;
        String Child11;
        String Child12;
        String Child13;
        String Child14;    
        String RepairId = '';
        String ListOfAPVictimEl;
        String ListOfPOBVictimsEl;    
        Account masterAcct1;
        Account mergeAcct1;
        Contact masterCont1;
        Contact mergeCont1;
        Address__c masterAddress1;
        Address__c mergeAddress1;
        String masterAcctId;
        String masterAddress1Id;
        String mergeAddress1Id;    
        String Mergeexception = '';
        String ErrorCode = '';
        String MWSendack;
        String transId = '';
        String StatusCode = '';
        String StatusMessage = '';    
        String MWResponse;
        Integer i;
        Integer j;
        Integer K;
        Integer L;
        Integer M;
        Integer N;
        Integer X;
        Integer Y;
        Integer OCLength;  
        String OC_Servior;
        String OC_Servior_PGUID;
        List<String> OCVictims_PGUID = new List<String>();
        List<String> APPGUID = new List<String>();
        List<String> POBPGUID = new List<String>();
        List<Account> masterAcct = new List<Account>();
        List<Account> mergeAcct = new List<Account>();    
        List<String> outputs = new List<String>();
        List<Address__c> mergeAddress;
        List<Dom.XmlNode> ListOfVictims;
        List<Dom.XmlNode> OCVictims;
        List<Dom.XmlNode> ListOfPOB;
        List<Dom.XmlNode> LisOfAP;
            
            try{
                if(null != xmlMessage || '' != xmlMessage){
                    Dom.Document doc = new Dom.Document();
                    doc.load(xmlMessage);
                Dom.XMLNode CustomerHierarchy = doc.getRootElement();//provides root element <CustomerHierarchy>
                RootElementName = CustomerHierarchy.getName(); //provides root element's name <CustomerHierarchy>. This is not reqd for further, jut a debug step.
                
                    // List<Dom.XmlNode> HeaderEl = CustomerHierarchy.getChildElements();
            //HeaderElName = HeaderEl[0].getName();//provides <Header> element. This is not reqd for further, jut a debug step.
            List<Dom.XmlNode> CustomerHierarchyElements = CustomerHierarchy.getChildElements();
            HeaderElName = CustomerHierarchyElements[0].getName(); //provides <Header> element. This is not reqd for further, jut a debug step.
            DataAreaEl = CustomerHierarchyElements[1].getName();//provides <DataArea> element. This is not reqd for further, jut a debug step.
            //i = CustomerHierarchyElements.size(); = 2
                    
                    List<Dom.XmlNode> CommonTrackingElements = CustomerHierarchyElements[0].getChildElements(); // Provides Common Tracking Element
            //RepairId = CommonTrackingElements[0].getName();// Looks good- Common Tracking Element Name
            List<Dom.XmlNode> DataGroupElement = CommonTrackingElements[0].getChildElements(); // Provides Data Group Element
            //RepairId = DataGroupElement[0].getName(); //Looks Good- Data Group element
            
            List<Dom.XmlNode> DataGroupElements = DataGroupElement[0].getChildElements(); // Children of Data Group
            
            RepairId = DataGroupElements[0].getText(); //Provodes RepairId
                    
                    
                    List<Dom.XmlNode> CustomerHierarchyBO = CustomerHierarchyElements[1].getChildElements(); // REQUIRED
            //i= CustomerHierarchyBO.size(); // =1 
            CustomerHierarchyBOEl = CustomerHierarchyBO[0].getName();//provides <CustomerHierarchyBO> element.// REQUIRED
            
          List<Dom.XmlNode> CustomerHierarchyBOElements = CustomerHierarchyBO[0].getChildElements();            
            //i= CustomerHierarchyBOElements.size(); // =7
            Child1 =CustomerHierarchyBOElements[0].getName();//ProcessFlag tag// REQUIRED
            Child1_1 = CustomerHierarchyBOElements[0].getText(); //ProcessFlag tag Value// REQUIRED
            Child2 = CustomerHierarchyBOElements[1].getName(); //CustomerHierarchyType tag-// REQUIRED
            Child2_2 = CustomerHierarchyBOElements[1].getText(); //CustomerHierarchyType //REQUIRED
            Child3 = CustomerHierarchyBOElements[2].getName(); // OC tag //REQUIRED
            
            //Child4 = CustomerHierarchyBOElements[3].getName(); // <ListOfFA> tag  //  Not Required  Debug step
            //Child5 = CustomerHierarchyBOElements[4].getName(); // <ListOfPOB> tag // Not Required Debug step
            //Child6 = CustomerHierarchyBOElements[5].getName(); // <ListOfAP> tag //Not Required Debug step
            //Child7 = CustomerHierarchyBOElements[6].getName(); // <ListOfAgreement> tag //Not Required Debug step
                    
             //Get Servior OC Details-
                if (CustomerHierarchyBOElements[2].getAttributeCount() > 0 && Child3 == 'OC'){
                  OC_Servior = CustomerHierarchyBOElements[2].getAttributeKeyAt(0);
                      if (OC_Servior == 'OCPGUID')
                      {
                       OC_Servior_PGUID = CustomerHierarchyBOElements[2].getAttributeValue(CustomerHierarchyBOElements[2].getAttributeKeyAt(0), CustomerHierarchyBOElements[2].getAttributeKeyNsAt(0));   
                      }
                  }
                    
                    // Getting the Servior SFDC ID 
                    if( OC_Servior_PGUID.length() > 0){ // This is imp to check if the attribute has any value or not.this ensures no nulls are passed tp SOQL later
                    masterAcct = [SELECT Id FROM Account WHERE OCPGUID__c =: OC_Servior_PGUID LIMIT 1];
                        //add logic after BU
                        /*if(masterAcct.Size() < 1){
                            Mergeexception = 'Master OC does not exists';
                            ErrorCode = '400';
                        }*/
                            
                        }
                   //Now Get ListOfOCVictimsElement and prepare a list for OC Merge-
                   if(CustomerHierarchyBOElements[2].getChildElements().size() > 0)
                   {
                    ListOfVictims = CustomerHierarchyBOElements[2].getChildElements();
                    Child8 = ListOfVictims[0].getName();
                    //Now Get OCVictims
                    OCVictims = ListOfVictims[0].getChildElements();
                    //Child9 = OCVictims[0].getName();
                    //Child9 = OCVictims[0].getAttributeValue(OCVictims[0].getAttributeKeyAt(0), OCVictims[0].getAttributeKeyNsAt(0));   
                    i = OCVictims.size();
                   }
                                
                          
                        for( j=0; j<i; j++)//start of for loop
                        {
                                       
                        Child9 = OCVictims[j].getAttributeValue(OCVictims[j].getAttributeKeyAt(0), OCVictims[j].getAttributeKeyNsAt(0));
                            if(Child9.length() > 0){ // this ensures no nulls are passed to SOQL later
                            OCVictims_PGUID.add(Child9); 
                            }
                        }//end of for loop
                    
                    // start the merge by looping all victim
                    if(masterAcct.Size() == 1){ // check for Master OC
                    X = OCVictims_PGUID.size();
                    //Calling Async LNPerformOCMerge Class
                    LNPerformOCMerge.PerformOCMerge(OC_Servior_PGUID, OCVictims_PGUID);
                    
                    
                    } // check for Master OC   
                                           
                    // End of OC merge.
                    
                    // Start of AP Merge- Same thing works for both OC and Interior Merge
                    // Prepare a List of AP's and perform Interior Merge
                    if(CustomerHierarchyBOElements[5].getChildElements().size() > 0)
                    {
                    LisOfAP = CustomerHierarchyBOElements[5].getChildElements();
                    M = LisOfAP.size();
                    }
                    
                     for(N=0; N<M; N++){//Looping ListOfAP's
                    Child11 = LisOfAP[N].getAttributeValue(LisOfAP[N].getAttributeKeyAt(0), LisOfAP[N].getAttributeKeyNsAt(0));
                    APPGUID.add(Child11);// Not needed- comment later
                    List<Dom.XmlNode> ListOfAPVictims = LisOfAP[N].getChildElements(); // List of AP Victims for an AP
                
                    if(ListOfAPVictims.size() > 0){//start
                        ListOfAPVictimEl = ListOfAPVictims[0].getName();//Always 1 and equals <ListOfAPVictims>
                        List<Dom.XmlNode> APVictims = ListOfAPVictims[0].getChildElements(); // AP Victims
                            if(APVictims.size() > 0){
                                //Loop through all Child AP's and perform AP Merge.
                                for(Integer Z=0; Z < APVictims.size(); Z++){//Start of loop
                                Child12 = APVictims[Z].getAttributeValue(APVictims[Z].getAttributeKeyAt(0), APVictims[Z].getAttributeKeyNsAt(0));
                                
                                // Merge Child12 -->Victim AP with Master AP-->Child11 and repeat Merge for any number of Victim AP's
                                 if(Child11.length() > 0 && Child12.length() > 0){
										//Call ASync AP Merge class
										LNPerformAPMerge.PerformAPMerge(Child11,Child12);
										}
                                 
                                        }// End if For Loop                          
                                
                            } //List of Victim AP
                                
                            } //List of AP  
                
                        }//Looping ListOfAP's 
                        // End of AP Merge-
                    // Start of POB Merge- Same thing works for both OC and Interior Merge
                    // Prepare a List of POB's and perform Interior Merge
                    if(CustomerHierarchyBOElements[4].getChildElements().size() > 0)
                    { 
                        ListOfPOB = CustomerHierarchyBOElements[4].getChildElements();
                        K = ListOfPOB.size();
                    }    
                    
                    for(L=0; L<K; L++){//Looping ListOfPOB's
                       Child13 = ListOfPOB[L].getAttributeValue(ListOfPOB[L].getAttributeKeyAt(0), ListOfPOB[L].getAttributeKeyNsAt(0));
                        POBPGUID.add(Child13);// Not needed- comment later
                        List<Dom.XmlNode> ListOfPOBVictims = ListOfPOB[L].getChildElements(); // List of POB Victims for a POB
                        
                        if(ListOfPOBVictims.size() > 0){//start of ListOfPOBVictims
                            ListOfPOBVictimsEl = ListOfPOBVictims[0].getName();//Always 1 and equals <ListOfPOBVictims>
                            List<Dom.XmlNode> POBVictims = ListOfPOBVictims[0].getChildElements(); // POB Victims
                                if(POBVictims.size() > 0){ // Start of If POBVictims
                                //Loop through all Child POB's and perform POB Merge.
                                    for(Integer Z=0; Z < POBVictims.size(); Z++){//Start of loop
                                    Child14 = POBVictims[Z].getAttributeValue(POBVictims[Z].getAttributeKeyAt(0), POBVictims[Z].getAttributeKeyNsAt(0));
                                    
                                   //Merge Child14 -->Victim POB with MAaster POB-->Child13 and repeat Merge for any number of Victim POB's 	
                                        if(Child13.length() > 0 && Child14.length() > 0){
                                       //Call Async POB Merge Class
                                            LNPerformPOBMerge.PerformPOBMerge(Child13,Child14);    
                                        }
                                                                                
                                    }//End of loop
                                    
                                }//End of If POBVictims
                            
                            
                            
                            }//End of ListOfPOBVictims
                    }//Looping ListOfPOB's
                    // End of POB Merge
                    
                    
                    } //end of if(null != xmlMessage || '' != xmlMessage)
               } //End of Try     
            catch(Exception e){
                Mergeexception = e.getMessage();
             }//End if Catch
        
        if(Mergeexception == null || Mergeexception == ''){
            ErrorCode = '200';
            Mergeexception = 'SUCCESS';
        }
        else{
            ErrorCode = '400';
        }
         //start
            try{
        transId = RepairId;
        StatusCode = ErrorCode;
        StatusMessage = Mergeexception;
        DOM.Document doc1 = new DOM.Document();
 
        //dom.XmlNode CustomerHierarchy = doc1.createRootElement('CustomerHierarchy' , 'xmlns:ns1="http://services.lexisnexis.com/xmlschema/customerhierarchy/1','ns1');
        dom.XmlNode CustomerHierarchy = doc1.createRootElement('CustomerHierarchy' , 'http://services.lexisnexis.com/xmlschema/customerhierarchy/1','ns1');
                
        //dom.XmlNode Header1= CustomerHierarchy.addChildElement('Header', 'xmlns:ns2="http://services.lexisnexis.com/xmlschema/header/1','ns2');
        //dom.XmlNode CommonTracking= Header1.addChildElement('commonTrackingMessage', 'xmlns:ns3="http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        //dom.XmlNode DataGroup= CommonTracking.addChildElement('dataGroup', 'xmlns:ns3="http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        //dom.XmlNode errorGroup= DataGroup.addChildElement('errorGroup', 'xmlns:ns3="http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');

        dom.XmlNode Header1= CustomerHierarchy.addChildElement('Header', 'http://services.lexisnexis.com/xmlschema/header/1','ns2');
        dom.XmlNode CommonTracking= Header1.addChildElement('commonTrackingMessage', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        dom.XmlNode DataGroup= CommonTracking.addChildElement('dataGroup', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        dom.XmlNode errorGroup= DataGroup.addChildElement('errorGroup', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        dom.XmlNode DataArea= CustomerHierarchy.addChildElement('DataArea', 'http://services.lexisnexis.com/xmlschema/customerhierarchy/1','ns1');        
                
        DataGroup.addChildElement('transId', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3').addTextNode(transId);
        errorGroup.addChildElement('errCd', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        errorGroup.addChildElement('errName', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        errorGroup.addChildElement('errDesc', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        errorGroup.addChildElement('severity', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');
        errorGroup.addChildElement('errText', 'http://services.lexisnexis.com/xmlschema/commontracking/1', 'ns3');

        Header1.addChildElement('Security', 'http://services.lexisnexis.com/xmlschema/header/1','ns2');
        Header1.addChildElement('SourceAppName', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode('SFDC');
        Header1.addChildElement('StatusCode', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode(StatusCode);
        Header1.addChildElement('StatusMessage', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode(StatusMessage);
        Header1.addChildElement('AcknowledgmentType', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode('Merge');
        Header1.addChildElement('MessageRecipientSystem', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode('SFDC');
        Header1.addChildElement('EntityName', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode('Customer Hierarchy');
        Header1.addChildElement('EntityOperation', 'http://services.lexisnexis.com/xmlschema/header/1','ns2').addTextNode('Process');
                
         MWSendack = doc1.toXmlString();
        }
        catch(Exception e1){
            
        }
          //end  
            try{
       //MWResponse= sendacktoMW(MWSendack);
       //Async Call to MW
       	sendacktoMW(MWSendack);
               // MWResponse = RespBody;
              if (MWResponse == null || MWResponse == ''){
                 MWResponse = 'Async Call is made to MW';   
                }        
        //MWResponse='sample';
            }
            catch(Exception e4){
                
            }
          
        outputs.add(Mergeexception);
        outputs.add(MWSendack);
        outputs.add(MWResponse);    
        //return Mergeexception;
        return outputs;
        }//End of Method
}//End of Class