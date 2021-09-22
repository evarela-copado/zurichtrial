/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-09-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   07-09-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class QentinelRun {
    
    //@AuraEnabled
	@InvocableMethod(label='Send to Qentinel')   
    public static void callQentinel(List<Id> recordIds){
        
        List<ID> FlowVarIDs = recordIds;
        //List <copado__User_Story_Metadata__c> User_Story_Metadata = [Select id, copado__Metadata_API_Name__c FROM copado__User_Story_Metadata__c WHERE copado__User_Story__r.id = :FlowVarIDs];
                                   
        For (ID US_mdt : FlowVarIDs) {
        
            //String type_subtype_language = US_mdt.copado__Metadata_API_Name__c.removeStart('OmniScript.');
            //system.debug('type_subtype_language = ' + type_subtype_language);            
        
        String qApi = '';
        qApi = 'c5084c48-40e9-424d-8f53-76384cd823aa';//usOne.Qentinel_Suite_API_Key__c;
        //Create API Request
        System.debug('qApi test = ' + qApi);
        String sfdcURL = 'https://pace.qentinel.com/pace/v4/builds';
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setMethod('POST');   
        httpRequest.setBody('{"key": "'+ qApi +'", "inputParameters": [{"key": "omniscriptuuid ", "value": "'+ 'a3e5e000000AhG0AAK'/*US_mdt*/ +'"}]}');
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setEndpoint(sfdcURL);  
        String response = '';
        
        //Make Qentinel API Request
        try {  
            Http http = new Http(); 
            HttpResponse httpResponse = http.send(httpRequest);  
            response = JSON.serializePretty( JSON.deserializeUntyped(httpResponse.getBody()) ); 
            Map<String,Object> results = 
                (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
            //If request is sucessful, update the Copado User Story with relevant Qentinel information
            //TODO: Write back to result record and not user story
            /*
             * if (httpResponse.getStatusCode() == 201 ) {  
            	JSONParser parser = JSON.createParser(httpResponse.getBody());
                String jobId = '';
                String robotId = '';
                String projectId = '';
                String reportId = '';
                //parse through response to get needed Qentinel ids to build out link
        		while (parser.nextToken() != null) {
                	if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                		if(parser.getText() == 'projectId') {
                			parser.nextToken();
                            projectId = String.valueOf(parser.getIntegerValue());
                        } else if (parser.getText() == 'robotId') {
                        	parser.nextToken();
                            robotId = String.valueOf(parser.getIntegerValue());
                        } else if (parser.getText() == 'jobId') {
                            parser.nextToken();
                            jobId = String.valueOf(parser.getIntegerValue());
                        } else if (parser.getText() == 'id') {
                            parser.nextToken();
                            reportId = String.valueOf(parser.getIntegerValue());
                        }
                    }
        		}
                usOne.Link_to_Last_Qentinel_Run__c = 'https://pace.qentinel.com/robots/'
                    +projectId+'/r/'+robotId+'/suite/'+jobId+'/runs/'+reportId+'/report';
                usOne.Last_Qentinel_Run__c = String.valueOf(results.get('message'));
                usOne.Qentinel_Job_Status__c = 'Success';
                update usOne;
                //If request fails update the User Story with failure message
                //TODO: Write back to result record and not user story
			} else {
                usOne.Last_Qentinel_Run__c = null;
				usOne.Link_to_Last_Qentinel_Run__c = null;
				usOne.Qentinel_Job_Status__c = 'Failed - ' 
                    + String.valueOf(results.get('message'));
				update usOne;
		}
*/
              
        }
    catch( System.Exception e) {  
                System.debug('ERROR: '+ e); 
        		System.debug('ERROR: '+ e.getCause());    	
        
        //usOne.Qentinel_Job_Status__c = 'Error : ' + e.getCause();
                throw e;  
    }  

        }
    
    }
    
          public class FlowVars {
          @InvocableVariable(label='Records for Input' required=true)
          public List<ID> FlowVarIDs;
          }
    
}