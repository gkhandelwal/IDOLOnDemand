import org.apache.http.NameValuePair; 
import org.apache.http.message.BasicNameValuePair;
import java.util.ArrayList;  
import java.util.List;
import java.util.Scanner;
import org.json.*;

public class Driver {
	// http://en.wikipedia.org/wiki/Hello world program
	private static String apikey = "df7a1052-9797-474f-97e7-4d4699a1c5af";
	private static String url1 = "https://api.idolondemand.com/1/api/sync/findsimilar/v1";
	private static String url2 = "https://api.idolondemand.com/1/api/sync/ocrdocument/v1";
	private static String url3 = "https://api.idolondemand.com/1/api/sync/analyzesentiment/v1";
	private static List<NameValuePair> idol = new ArrayList<NameValuePair>();
	private static String body = null;
	static Client1 cl1 = new Client1();
	private static String findsimilar() throws Exception
	{
		idol.clear();
		idol.add(new BasicNameValuePair("text","Hello World"));
		idol.add(new BasicNameValuePair("indexes","wiki_eng"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		// you can add a lot depending on your interest from the options
		// available in API at API page
		// to print all fields use "print all"
		//idol.add(new BasicNameValuePair("print","all"));
		
		body = cl1.run(url1,idol);
		return body;
	}
	private static String ocrdocument() throws Exception
	{
		idol.clear();
		
		idol.add(new BasicNameValuePair("mode","document_photo"));
		idol.add(new BasicNameValuePair("url","http://www.java-made-easy.com/images/hello-world.jpg"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url2,idol);
		return body;
	}
	private static String analyzesentiment(String url) throws Exception
	{
		
		idol.clear();
		idol.add(new BasicNameValuePair("language", "eng"));
		idol.add(new BasicNameValuePair("url", url));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		
		body = cl1.run(url3,idol);
		return body;
	}
	public static void main(String[] args) throws Exception 
	{
		
		System.out.println("Enter your choice \n 1. findsimilar API \n 2. ocrdocument API \n 3. analyzesentient API\n");
		int n;
		Scanner input_scanner = new Scanner(System.in);
		n = input_scanner.nextInt();
		input_scanner.close();// Don't forget to close it
		if(n == 1)
		{
			String  output  = findsimilar();
			JSONObject jsonObj = new JSONObject(output);
			JSONArray array = (JSONArray) jsonObj.get("documents");
			for(int i=0;i<array.length();i++)
				System.out.println(array.get(i));
		}
		else
			if(n == 2)
			{
				String  output  = ocrdocument();
				JSONObject jsonObj = new JSONObject(output);
				System.out.println(jsonObj);
			}
			else
				if(n == 3)
				{
					String  output  = findsimilar();
					JSONObject jsonObj = new JSONObject(output);
					JSONArray array = (JSONArray) jsonObj.get("documents");
					if(array.length()==0)
						System.out.println("sorry,no document");
					else
					{
						
						String  output1  = analyzesentiment(array.getJSONObject(1).getString("reference"));
						JSONObject jsonObj1 = new JSONObject(output1);
						System.out.println(jsonObj1.get("aggregate"));
					}
				}
				else
				{
					System.out.println("Wrong choice");
				}
		
	}

}