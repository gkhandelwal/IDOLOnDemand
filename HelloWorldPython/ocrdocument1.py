###	install these packages and than run python code

###    	pip install requests

###	easy_install requests


import requests

url="http://api.idolondemand.com/1/api/sync/{}/v1"

apikey="df7a1052-9797-474f-97e7-4d4699a1c5af"

def postrequests(function,data={},files={}):
               data["apikey"]=apikey
               callurl=url.format(function)
               r=requests.post(callurl,data=data,files=files)
               return r.json()



def ocrdocument():
	result=postrequests('ocrdocument',data={'mode':'document_photo','url':'http://www.java-made-easy.com/images/hello-world.jpg'})
	print result


if __name__ == "__main__":
	ocrdocument()
