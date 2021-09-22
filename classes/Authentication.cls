public class Authentication {
    
    //@future (callout=true)
    public static void basicAuthToken(String user, String password){
           
        try{
        
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://dev75200.service-now.com/api/sn_chg_rest/v2/change/normal?description=test&short_description=Remove server');

        Blob auth = Blob.valueOf(user+':'+password);
		            
        System.debug('Auth: '+ auth);

        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(auth);
        
        request.setMethod('POST');
 
        request.setHeader('Authorization', authorizationHeader);
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-type', 'application/json');
        request.setHeader('User', authorizationHeader);


       
        //String jsonString = '{\n\"u_customer\":\"92f53eee6f186d00a18b2d232e3ee471\",\"description\":\"Created by Salesforce APEX\"}';
        String jsonString = '{"description":"Created by Salesforce APEX"}';
		
        //request.setBody(jsonString);
        
            Http http = new Http();
            HttpResponse res = new HttpResponse();

            res = http.send(request);
            
            System.debug('Body:'+ res.getBody());
            System.debug('Status CODE: '+ res.getStatusCode());
            System.debug('Status CODE: '+ res.getStatus());            
			System.debug('Status CODE: '+ res.getStatusCode());
            System.debug('Authorization in Bytes: '+authorizationHeader);
            //System.debug('Data are been saved: '+jsonString);
            
        }catch(System.CalloutException e){
            System.debug('Error: '+ e.getMessage());
        }
    }
}