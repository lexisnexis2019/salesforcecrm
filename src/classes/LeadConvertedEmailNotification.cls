public class LeadConvertedEmailNotification {
    @InvocableMethod(label='LeadConvertedEmail' description='Sends notifications for converted leads')
    public static void LeadConvertEmail(List<Lead> lstLeads) {
        
        list<messaging.SingleEmailMessage> messages = new list<messaging.singleemailmessage>();
        
        for(Lead l : lstLeads){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            
            lead g = [select id, name, company, owner.email, convertedopportunity.name from lead where id =: l.id];
            
            String oppname;
            
            if(g.convertedopportunity.name != null){
                oppname = g.convertedopportunity.name;
            } else{
                oppname = 'None Created';
            }
            
            String Htmlbody = '*** NEW CONVERTED LEAD NOTIFICATION ***<p> Company : ' + g.company + '<br/> Opportunity Name:' 
                + oppname + '<p>Click on the link to access the converted lead directly: <a href=' + System.URL.getSalesforceBaseUrl().toExternalForm() + '/' +  g.Id + '>click here.</a>';
            
            List<String> toaddresses = new list<String>();

            toaddresses.add(g.owner.email);
            system.debug(g.owner.email);

            message.setToAddresses(toaddresses);
            message.setSubject('Lead Conversion to ' + oppname + ' has been assigned to you');
            message.setHtmlBody(htmlbody);
            System.debug('body : ' + htmlbody);            
            messages.add(message);
        }	
        
        messaging.sendemail(messages);
        
    }
}