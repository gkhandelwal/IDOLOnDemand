 
import java.util.List;   
import org.apache.http.Consts;  
import org.apache.http.HttpEntity;  
import org.apache.http.NameValuePair;  
import org.apache.http.client.entity.UrlEncodedFormEntity;  
import org.apache.http.client.methods.CloseableHttpResponse;  
import org.apache.http.client.methods.HttpPost;  
import org.apache.http.impl.client.CloseableHttpClient;  
import org.apache.http.impl.client.HttpClients;  
import org.apache.http.util.EntityUtils;
  
public class Client1 {  
	
	
	public String run(String url, List<NameValuePair> nvps ) throws Exception 
	{  
		String body = null;
		// Creating an instance of HttpClient.  
		CloseableHttpClient httpclient = HttpClients.createDefault();  
		try 
		{  
			// Creating an instance of HttpPost.  
			HttpPost httpost = new HttpPost(url);  
			
			// this is important for encoding
			httpost.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));  
			// Executing the request.  
			CloseableHttpResponse response = httpclient.execute(httpost);  
			System.out.println("Response Status line :" + response.getStatusLine()); 
			HttpEntity entity = response.getEntity(); 
			try 
			{  
				  if (entity != null) 
				  {
					  long len = entity.getContentLength();
					  if (len != -1)
					  {
						  body = EntityUtils.toString(entity);
					  } 
					  else 
					  {
						  // We should leave this empty.. No action needed  
					  }
				  	}	
			   } 
			
			  finally 
			  {  
				   EntityUtils.consume(entity);
				   // Closing the response 
				   response.close();  
			   }  
		  } 
		  finally 
		  {  
			   httpclient.close();  
		  }
	      return body;
	}  
}