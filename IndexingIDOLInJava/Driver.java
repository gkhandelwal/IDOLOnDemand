import org.apache.http.NameValuePair; 
import org.apache.http.message.BasicNameValuePair;
import java.util.ArrayList;  
import java.util.List;
import java.util.Scanner;
import org.json.*;

public class Driver {

	private static String apikey = "df7a1052-9797-474f-97e7-4d4699a1c5af";
	private static String url1 = "https://api.idolondemand.com/1/api/sync/createtextindex/v1";
	private static String url2 = "https://api.idolondemand.com/1/api/sync/storeobject/v1";
	private static String url3 = "https://api.idolondemand.com/1/api/sync/addtotextindex/v1";
	private static String url4 = "https://api.idolondemand.com/1/api/sync/viewdocument/v1";
	private static String url5 = "https://api.idolondemand.com/1/api/sync/findrelatedconcepts/v1";
	private static String url6 = "https://api.idolondemand.com/1/api/sync/findsimilar/v1";
	private static List<NameValuePair> idol = new ArrayList<NameValuePair>();
	private static String body = null;
	//private static String reference = null;
	private static String reference = null;
	static Client1 cl1 = new Client1();
	
	private static String createtextindex() throws Exception
	{
		idol.clear();
		idol.add(new BasicNameValuePair("flavor","explorer"));
		idol.add(new BasicNameValuePair("index","Cancer Prevention"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url1,idol);
		return body;
	}
	private static String storeobject() throws Exception
	{
		idol.clear();
		idol.add(new BasicNameValuePair("url","http://www.cancer.org/acs/groups/cid/documents/webcontent/002577-pdf.pdf"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url2,idol);
		return body;
	}
	private static String addtotextindex() throws Exception
	{
		//reference = "4de02219-aa63-4c0f-891f-1b3edccf9e9b";
		idol.clear();
		idol.add(new BasicNameValuePair("reference",reference));
		idol.add(new BasicNameValuePair("index","Cancer Prevention"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url3,idol);
		return body;
	}
	private static String viewdocument() throws Exception
	{
		//reference = "4de02219-aa63-4c0f-891f-1b3edccf9e9b";
		idol.clear();
		idol.add(new BasicNameValuePair("reference",reference));
		idol.add(new BasicNameValuePair("highlight_expression","physical activity"));
		//idol.add(new BasicNameValuePair("highlight_expression","healthy"));
		idol.add(new BasicNameValuePair("raw_html","True"));
		idol.add(new BasicNameValuePair("start_tag","<b>"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url4,idol);
		return body;
	}
	private static String findrelatedconcepts() throws Exception
	{
		//reference = "4de02219-aa63-4c0f-891f-1b3edccf9e9b";
		idol.clear();
		idol.add(new BasicNameValuePair("indexes", "wiki_eng"));
		idol.add(new BasicNameValuePair("reference", reference));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		body = cl1.run(url5,idol);
		return body;
	}
	
	private static String findsimilar() throws Exception
	{
		String text=null;
		String inter = findrelatedconcepts();
		JSONObject interJsonObj = new JSONObject(inter);
		JSONArray array = (JSONArray) interJsonObj.get("entities");
		if(array.length()==0)
		{
			System.out.println("sorry,no document");
			return null;
		}
		if(array.length()>1)
			text = array.getJSONObject(1).getString("text");
		else
			text = array.getJSONObject(0).getString("text");
		idol.clear();
		idol.add(new BasicNameValuePair("text",text));
		idol.add(new BasicNameValuePair("indexes","news_eng"));
		idol.add(new BasicNameValuePair("apikey", apikey));  
		// you can add a lot depending on your interest from the options
		// available in API at API page
		// to print all fields use "print all"
		//idol.add(new BasicNameValuePair("print","all"));
		body = cl1.run(url6,idol);
		
		return body;
	}
	public static void main(String[] args) throws Exception 
	{
		
		System.out.println("Enter your choice \n 1. createtextindex API \n 2. storeobject API \n 3. addtotextindex API\n 4. viewdocument API\n" +
				" 5. findrelatedconcepts API\n 6. findsimilar API\n");
		int n;
		Scanner input_scanner = new Scanner(System.in);
		n = input_scanner.nextInt();
		input_scanner.close();// Don't forget to close it
		String  output = null;
		JSONObject jsonObj= null;
		JSONArray array = null;
		switch(n)
		{
		case 1:
			output  = createtextindex();
			jsonObj = new JSONObject(output);
			System.out.println(jsonObj);
			break;
		case 2:
			output  = storeobject();
			jsonObj = new JSONObject(output);
			reference = jsonObj.getString("reference");
			System.out.println(jsonObj);
			break;
		case 3:
			output  = storeobject();
			jsonObj = new JSONObject(output);
			reference = jsonObj.getString("reference");
			// above is added to get reference
			output  = addtotextindex();
			jsonObj = new JSONObject(output);
			System.out.println(jsonObj);
			break;
		case 4:
			output  = storeobject();
			jsonObj = new JSONObject(output);
			reference = jsonObj.getString("reference");
			// above is added to get reference
			output  = viewdocument();
			//jsonObj = new JSONObject(output); not needed as it does'nt return json.
			System.out.println(output);
			break;
		case 5:
			output  = storeobject();
			jsonObj = new JSONObject(output);
			reference = jsonObj.getString("reference");
			// added to get reference
			output  = findrelatedconcepts();
			jsonObj = new JSONObject(output);
			System.out.println(jsonObj);
			break;
		case 6:
			output  = findsimilar();
			jsonObj = new JSONObject(output);
			array = (JSONArray) jsonObj.get("documents");
			for(int i=0;i<array.length();i++)
				System.out.println(array.get(i));
			break;
		default:
			System.out.println("Wrong Choice");
			break;
		}
		
	}

}