public  class IdolOnDemand
{

    public String ocrthroughStorage ; // for storing json string result of OCR through storage API method...
    public String ocrthroughURLSync ; // for storing json string result of OCR through URL Synchronously...
    public String ocrthroughURLASync ; // for storing json string result of OCR through URL ASynchronously..
    public String findsimilarContent; // for storing json string result of find similar method..
    public String sentimentContent;// for storing json string result of Sentiment analysis method...
    private String apiUrl; // for storing partial API url of synchronous call...
    private String version;// for storing version number of API...
    private String apiKey;// for storing API key...
    
    // this is constructor for this class
    public IdolOnDemand()
    {
        // this is initializing partial URL
        apiUrl = 'https://api.idolondemand.com/1/api/sync/';
        // this is initialing version
        version  = '/v1';
        // this is storing api key.
        apiKey = '88b669eb-3431-4893-b75d-2e7e2c9f853e';
    }
    
     // getter for find similar content method...
    public String getFindsimilarContent()
    {
    // calling find similar method..
        findsimilarContent  =  findSimilar();
        return findsimilarContent;
    }
    
    // getter method for OCR through URL Synchronous call
    public String getOCRthroughURLSync() 
    {
        // calling ocrthroughURLSync method and storing result in ocrthroughURLSync
        ocrthroughURLSync = ocrthroughURLSync();
        
        return ocrthroughURLSync ;
    }
    
    // getter method for OCR through URL ASynchronous call
    public String getOCRthroughURLAsync() 
    {
        // calling ocrthroughURLAsync method and storing result in ocrthroughURLAsync
        ocrthroughURLAsync = ocrthroughURLAsync();
      
        return ocrthroughURLAsync ;
    }
    
    // getter method for OCR through storage 
    public String getOCRthroughStorage() 
    {
        // calling OCR though storage method
        ocrthroughStorage = ocrthroughStorage();
        return ocrthroughStorage ;
    }
    
    // getter for Sentiment analysis content
    public String getSentimentContent() 
    {
    // calling sentiment analhysis method...
        sentimentContent = sentimentAnalysis();
        return sentimentContent;
    }
    
   
     // Method to compute find similar
     private String findSimilar()
     {
       //building url of find similar API
        String tempapiUrl  = apiUrl+'findsimilar'+version;
        // Http Request initialization
        HttpRequest req = new HttpRequest();
         // Http Response initialization
        HttpResponse res = new HttpResponse();
        // Http class initialization
        Http http = new Http();
        //calling setEndpoint of HttpRequest and passing url of API
        req.setEndpoint(tempapiUrl);
        // setting method type as  POST
        req.setMethod('POST');
        // setting body with key as api key and Text as Hello World, on which we will do find similar....
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&text='+EncodingUtil.urlEncode('Hello World', 'UTF-8'));
        res = http.send(req);
        return res.getBody();// returning json string of output
     }
     
      // Private method, to compute OCR though URL Synchronously
     private String ocrthroughURLSync()
     {
        // building url
        String tempapiUrl  = apiUrl+'ocrdocument'+version;
        // url of image for which we will compute OCR
        String imageUrl = 'http://www.java-made-easy.com/images/hello-world.jpg';
        // Http Request initialization
        HttpRequest req = new HttpRequest();
        // Http Response initialization
        HttpResponse res = new HttpResponse();
         // Http class initialization
        Http http = new Http();
         //calling setEndpoint of HttpRequest and passing url of API
        req.setEndpoint(tempapiUrl);
        // setting method type as  POST
        req.setMethod('POST');
        // setting body with key as api key and url as url of image source..
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&url='+EncodingUtil.urlEncode(imageUrl, 'UTF-8'));
        res = http.send(req);
        return(res.getBody());// returning json string of output

     }
     
      // OCR Document Call through URL Asynchronous..
     private String ocrthroughURLAsync()
     {
     // URL of Asynchronous OCR call
        String tempapiUrl  = 'https://api.idolondemand.com/1/api/async/ocrdocument/v1';
         // url of image for which we will compute OCR
        String imageUrl = 'http://www.java-made-easy.com/images/hello-world.jpg';
        // Http Request initialization
        HttpRequest req = new HttpRequest();
         // Http Response initialization
        HttpResponse res = new HttpResponse();
         // Http class initialization
        Http http = new Http();
         //calling setEndpoint of HttpRequest and passing url of API
        req.setEndpoint(tempapiUrl);
        // setting method type as  POST
        req.setMethod('POST');
        // setting body with key as api key and url as url of image source..
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&url='+EncodingUtil.urlEncode(imageUrl, 'UTF-8'));
        res = http.send(req);
       // returning json string of output
        return(res.getBody());

     }
     
   // Method to call OCR Document through storage
    private String ocrthroughStorage()
    {
        String referenceUrl;
        // calling storage object API call method
        referenceUrl = storageObject();
        // building api url for OCR document..
        String tempapiUrl  = apiUrl+'ocrdocument'+version;
        // Http Request initialization
        HttpRequest req = new HttpRequest();
        // Http Response initialization
        HttpResponse res = new HttpResponse();
        // Http class initialization
        Http http = new Http();
        // calling setEndpoint of HttpRequest and passing url of API
        req.setEndpoint(tempapiUrl);
        // setting method type as  POST
        req.setMethod('POST');
        // setting body with key as api key and reference from store object API...
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&reference='+EncodingUtil.urlEncode(referenceUrl, 'UTF-8'));
        req.setTimeout(20000); // since the default is 10,000 and sometimes it is giving timeout error, so I increased to 20 sec.
        res = http.send(req);
        return(res.getBody());// returning json string of output

     }
     
        // This is a method of calling store object API
    private String storageObject()
    {
        // for building api url for API
        String tempURL = apiUrl+'storeobject'+version;
        // url of image which we will store in IDOL database
        String imageUrl = 'http://www.java-made-easy.com/images/hello-world.jpg';
        // Http Request initialization
        HttpRequest req = new HttpRequest();
        // Http Response initialization
        HttpResponse res = new HttpResponse();
        // Http class initialization
        Http http = new Http();
        // calling setEndpoint of HttpRequest and passing url of API.
        req.setEndpoint(tempURL);
        // setting method of POST
        req.setMethod('POST');
        // setting body with key as api key and url of image
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&url='+EncodingUtil.urlEncode(imageUrl, 'UTF-8'));
        // calling http send and storing result in response class object...
        res = http.send(req);
        // Creating a parser with res.getbody as input string
        JSONParser parser = JSON.createParser(res.getBody());
        String tempReference ;
        // to parse the JSON string.. In the below lines, parsing is done...
        while (parser.nextToken() != null) 
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))
            {
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'reference') 
                {
                    tempReference = parser.getText();
                } 
            }
        }
        // returning the reference after parsing
        return tempReference ;
        
    }
    
   
     
     // Method for Sentiment Analysis API 
     private String sentimentAnalysis()
     {      
        // Here we are calling find similar method and storing result in tempSimilar variable..
        String tempSimilar = findSimilar(); 
        // building url for sentiment analyze api
        String tempapiUrl  = apiUrl+'analyzesentiment'+version;
        // Http Request initialization
        HttpRequest req = new HttpRequest();
        // Http Response initialization
        HttpResponse res = new HttpResponse();
        // Now in the next few lines we are doing parsing to get first document url returned from find similar API...
        JSONParser parser = JSON.createParser(tempSimilar);
        /* you can use json parser object, but because this is straightforward, I don't feel need of that parser.. 
        Moreover it will complicate things as I don't want 3rd party software*/
        parser.nextToken();
        // Advance to the next value.
        parser.nextValue();
        parser.nextValue();
        parser.nextValue();
        // Reference Value of first Document stored...
        String referenceURL = parser.getText();
        // Http class initialization
        Http http = new Http();
        //calling setEndpoint of HttpRequest and passing url of API
        req.setEndpoint(tempapiUrl);
        // setting method type as  POST
        req.setMethod('POST');
        // setting body with key as api key and url as reference of text returned from find similar api on hello World....
        req.setBody('apikey='+EncodingUtil.urlEncode(apiKey,'UTF-8')+'&url='+EncodingUtil.urlEncode(referenceURL, 'UTF-8'));
        req.setTimeout(20000); // since the default is 10,000 and sometimes it is giving timeout error, so I increased to 20 sec.
        res = http.send(req);
        return(res.getBody());// returning json string of output
     }
     
        
}