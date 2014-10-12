###	install these packages and than run python code

###    	pip install requests

###	easy_install requests

### 	substitut to get all info...

###	results=postrequests('findsimilar',{'text':'Hello World','print':'all'})

import requests
url="http://api.idolondemand.com/1/api/sync/{}/v1"
apikey="df7a1052-9797-474f-97e7-4d4699a1c5af"

def postrequests(function,data={},files={}):
               data["apikey"]=apikey
               callurl=url.format(function)
               r=requests.post(callurl,data=data,files=files)
               return r.json()

def findsimilar():
	results=postrequests('findsimilar',{'text':'Hello World'})
	return results

def analyzesentiments():
	result  = {}
	docs = {}
	result=findsimilar()
	if result:
		docs = result["documents"]
	else :
		print "Sorry!! No document to analyze"
		return
	if docs:
		# lets analyze 2nd  element and if not there than 1st element
		if len(docs) >1 :
			answer  = docs[1]# analyzing only one document
		else:
			answer  = docs[0]# analyzing only one document
		results=postrequests('analyzesentiment',data={'language':'eng','url': answer["reference"]})
		print results[u'aggregate']
	else :
		print "Sorry!! No document to analyze"
		return
	

if __name__ == "__main__":
	analyzesentiments()

