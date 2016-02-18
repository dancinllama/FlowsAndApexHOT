/**
 * @description Utility class, used by a Flow, for calling out to Loggly and recording messages such as
 * flow faults and exceptions.
 * @author <enter name here>
 * @date <enter date here>
 */
public class FlowLogglyUtil{
   
    /**
     * Performs a callout and sends a list of messages to loggly.
     * @param messages List of message strings to send to Loggly.
     */ 
    //Hint, add an Invocable Method annotation with a label and description.
    public static void log(String messages){
        doCallout(messages);
    }
    
    //Hint, update this method to support a list of strings.
    @future (callout=true)
    private static void doCallout(String messages) {
        Loggly_Config__mdt logglySettings = [Select Loggly_URL__c,Loggly_Token__c From Loggly_Config__mdt Limit 1];
        
        List<String> arguments = new List<String>{logglySettings.Loggly_Token__c,'flow'};
        String requestUrl = String.format(logglySettings.Loggly_URL__c,arguments);
        
        HttpRequest request = new HttpRequest();
        request.setHeader('Accept','application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(requestURL);
        request.setMethod('POST');
        request.setTimeout(60000);
        request.setBody(JSON.serialize(messages));
        
        Http httpRequest = new Http();
        HttpResponse response = httpRequest.send(request);
    }
}