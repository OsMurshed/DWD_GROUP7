package downloadHtml;


import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;


public class downloadFromUrl {

  public static void main(String[] args) throws IOException {
	  	long startTime = System.currentTimeMillis();
		 String fileName = null;//"file.txt"; //The file that will be saved on your computer
		 new File("./LoadedImageFromEdinburghCollectedOrg").mkdir();
		 List<String> urls = readFile("image_url.txt");
		 URL link = null;
		 
		 int i = 1;
		 for(String url: urls){
			 if(!url.equalsIgnoreCase("null")){
				 link = new URL(url); //The file that you want to download
				 fileName = "LoadedImageFromEdinburghCollectedOrg/" + Integer.toString(i++)+".jpg";
			     //Code to download
					 InputStream in = new BufferedInputStream(link.openStream());
					 ByteArrayOutputStream out = new ByteArrayOutputStream();
					 byte[] buf = new byte[1024];
					 int n = 0;
					 while (-1!=(n=in.read(buf)))
					 {
					    out.write(buf, 0, n);
					 }
					 out.close();
					 in.close();
					 byte[] response = out.toByteArray();
			 
					 FileOutputStream fos = new FileOutputStream(fileName);
					 fos.write(response);
					 fos.close();
			 } else i++;
				 System.out.println("Load " + i +" photo in: "+(double)(System.currentTimeMillis() - startTime)/1000 + "s");

		     //End download code
				 //if(i == 10) break;
		 }
		long endTime   = System.currentTimeMillis();
		long totalTime = endTime - startTime;
		System.out.println("Total time: " +(double)(totalTime)/1000 + "s");
		System.out.println("Finished");

	}

  
  
  private static List<String> readFile(String fileStr) {
		File fin = new File(fileStr);
		FileInputStream fis = null;
		List<String> urls = new ArrayList<String>();
		//Construct BufferedReader from InputStreamReader
		BufferedReader br = null;
	 
		String line = null;
		
	 
		
		
		 try {
				fis = new FileInputStream(fin);
				br = new BufferedReader(new InputStreamReader(fis));
				while ((line = br.readLine()) != null) {
					//System.out.println(line);
					urls.add(line);
				}
		    } catch (MalformedURLException mue) {
		         mue.printStackTrace();
		    } catch (IOException ioe) {
		         ioe.printStackTrace();
		    } finally {
		        try {
		            if (br != null) br.close();
		        } catch (IOException ioe) {
		            // nothing to see here
		        }
		    }
		 return urls;
	}
}
 

