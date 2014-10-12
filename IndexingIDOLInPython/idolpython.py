import requests
url="http://api.idolondemand.com/1/api/sync/{}/v1"
apikey="df7a1052-9797-474f-97e7-4d4699a1c5af"


def postrequests(function,data={},files={}):
               data["apikey"]=apikey
               callurl=url.format(function)
               r=requests.post(callurl,data=data,files=files)
               return r

def createtextindex():
	result=postrequests('createtextindex',data={'flavor':'explorer','index': 'Cancer Prevention'})
	return result.json()

def storeobject():
	result=postrequests('storeobject',data={'url':'http://www.cancer.org/acs/groups/cid/documents/webcontent/002577-pdf.pdf'})
	return result.json()

def addtotextindex(reference):
	result=postrequests('addtotextindex',data={'reference':reference,'index': 'Cancer Prevention'})
	return result.json()

def viewdocument(reference):
	result=postrequests('viewdocument',data={'reference':reference,'highlight_expression': ['physical activity'],'raw_html':True,'start_tag':"<b>"})
	
	#result=postrequests('viewdocument',data={'reference':reference,'highlight_expression': ['healthy'],'raw_html':True,'start_tag':"<b>"})
	return result # Here since we are using raw_html':True , therefore, returned result is not json 

def findrelatedconcepts(reference):
	result=postrequests('findrelatedconcepts',data={'indexes':'wiki_eng','reference': reference})
	return result.json()

def findsimilar(result):
	docs = {}
	if result:
		docs = result["entities"]
	else :
		print "Sorry!! No document"
		return
	if docs:
		# lets analyze 2nd element and if not there than 1st element
		if len(docs) >1 :
			answer  = docs[1]# analyzing only one document
		else:
			answer  = docs[0]# analyzing only one document
		results=postrequests('findsimilar',data={'text':answer["text"],'indexes': 'news_eng'})
	else :
		print "Sorry!! No document"
		return
	return results.json()

if __name__ == "__main__":
	
	result = createtextindex()
	print result
	ref = storeobject()
	print ref
	result = addtotextindex(ref["reference"])
	print result
	result=viewdocument(ref["reference"])
	print result.text 
	result=findrelatedconcepts(ref["reference"])
	print result
	result=findsimilar(result)
	for document in result["documents"]:
              print document
	

