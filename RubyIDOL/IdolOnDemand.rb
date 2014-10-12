require 'rest_client'
require 'json'

class IdolOnDemand

    
    @url # instance variable for the partial URL for the HP IDOL OnDemand
    @apikey # instance apikey for this class 
    @version # instance variable for the version of the api url


    # constructor for class IdolOnDemand
    def initialize
	  
	    @apikey ='88b669eb-3431-4893-b75d-2e7e2c9f853e' # api Key value.. You should put your own api key.. Don't misuse it..
            @url = 'https://api.idolondemand.com/1/api/sync/' # partial url.. This is for synchronous .. 
							# for one call I have used asyn and there, I have used the complete url 
	    @version = '/v1' # version number of api
    end

    # find similar api..Finds documents that are conceptually similar to your text or a document.
    def findSimilar
	    @url = @url+'findsimilar'+@version # complete url.. It will become..https://api.idolondemand.com/1/api/sync/findsimilar/v1
	    # these are all arguments we need in addition to api key..indexes is optional...but for tutorial I have included
	    post_args ={:apikey => @apikey,:text => 'Hello World', :indexes => 'wiki_eng'}
	    # post method call with arguments as url of api and arguments 
	    response = RestClient.post(@url,post_args)
	    # returns the json formatted output
            return JSON.parse(response.body)
    end
 
    # defination of Ocr Document with url and Async call
    # This API Extracts text from an image.
    def ocrDocumentUrl
	    # this is the async call .. therefore I have used complete url...
	    # this is using url for calling ocrDocument.. This is asyn call.. 
	    @url = 'https://api.idolondemand.com/1/api/async/ocrdocument/v1'
            #These are all arguments we need in addition to api key.. mode is document photo as our image is photograph of a document
	    post_args ={:apikey => @apikey,:url => 'http://www.java-made-easy.com/images/hello-world.jpg', :mode => 'document_photo'}
	    # post method call with arguments as url of api and arguments
	    response = RestClient.post(@url,post_args)
	    # return type will be json formatted .. Here the output will be job id .. one sample is like this
	    # {"jobID"=>"usw3p_a5211891-f19c-4256-807c-2d262682ecaf"}
            # you can access it by using curl or browser to see content of it 
            return JSON.parse(response.body)
    end

    # defination of Ocr Document with File
    # This API Extracts text from an image.
    def ocrDocumentFile
	     # this is using url for calling ocrDocument..
	    @url = @url+'ocrdocument'+@version
            #These are all arguments we need in addition to api key.. mode is document photo as our image is photograph of a document
            #second parameter is file.. we have opened file in binary reading mode..
	    post_args ={:apikey => @apikey,:file => File.new('hello-world.jpg', 'rb'), :mode => 'document_photo'}
            # return type will be actual output ... It is very much similar with only minor differences
	    response = RestClient.post(@url,post_args)
            return JSON.parse(response.body)
    end

    # defination of Ocr Document with reference.. Here we have called store object API to store file..
    # and use that reference to extract text
    # This API Extracts text from an image.
    def ocrDocumentStoreObject
            # store url in temp variable to prevent lose of common url
 	    tempurl = @url
	    reference = storeObject() # storeobject api will be called and this will return
	    #json object containing reference key
	    puts 'Your reference key for future access is'
	    puts reference['reference'] # this is printing reference key value
	    @url = tempurl+'ocrdocument'+@version # generating url for sentiment analysis
            #These are all arguments we need in addition to api key.. mode is document photo as our image is photograph of a document
            #second parameter is reference which we got from above call..
  	    post_args ={:apikey => @apikey,:reference => reference['reference'], :mode => 'document_photo'}
	    response = RestClient.post(@url,post_args)
            return JSON.parse(response.body)
    end
    
    # defination of store object method, which will call store object API and return reference number
    # which will get used in OCR document api.. this api Stores a file in IDOL Database for future use with ref number 
    def storeObject
	    @url = @url+'storeobject'+@version # complete url for store object API
            #These are all arguments we need in addition to api key
	    post_args = {:apikey => @apikey,:url => 'http://www.java-made-easy.com/images/hello-world.jpg'}
	    response = RestClient.post(@url,post_args) # json string containing reference as key and it's value
            return JSON.parse(response.body)
    end

    # defination of sentiment analysis API.. This API Analyzes text for positive or negative sentiment.
    # We will do analysis on one of the document returned from find similar API on Hello World Text.
    def sentimentAnalysis
	    tempurl = @url # temperory url to use common url later
	    contentUrl = findSimilar() # call to find similar API..We will get JSON document with information..
	    # we will use URL of the returned text for sentiment analysis
	    documents = contentUrl ['documents']
	    # to check if documents returned from find Similar is Empty or not
	    if(documents.any?)
		  resultantURLDoc = documents[0];
		  @url=tempurl+'analyzesentiment'+@version
	    	  post_args ={:apikey => @apikey,:url => resultantURLDoc['reference'] ,:language => 'eng'}
	          response = RestClient.post(@url,post_args)
                  return JSON.parse(response.body)
	    else
		  puts "Documents returned from find similar is Empty"
	    end
	  
    end

   

end
