package downloadHtml;

import org.jsoup.Jsoup;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.ArrayList;

public class extracHtml {

	public static void main(String[] args) throws IOException {
		//"http://stackoverflow.com/"
		
		long startTime = System.currentTimeMillis();
		List<String> urls = readFile("meory_url.txt");
		List<String> imgsSrcs = new ArrayList<String>();
		String CSVFile = "imgsSrcs.csv";
		int i = 1;
		for(String url : urls){
			String[] parts = url.split("/");
			//String fileName = i + "_"+ parts[4] + ".html";
			String imgSrc = getImageUrl(url);
			String raw = Integer.toString(i) + "," + parts[4] + "," + imgSrc + "\n";// parts[4] is the number of the page
			imgsSrcs.add(raw);
			//ReadUrlWritetoFile( url, "test/"+fileName);
			System.out.println("Load " + i++ +" Records in: "+(double)(System.currentTimeMillis() - startTime)/1000 + "s");
			//System.out.println(url);
			//System.out.println(parts[4]);
			//if(++i==5) break;
		}
		
		toCSV(CSVFile ,imgsSrcs);
		
		long endTime   = System.currentTimeMillis();
		long totalTime = endTime - startTime;
		System.out.println("Total time: " +(double)(totalTime)/1000 + "s");
	}

	
	public static String ReadUrlWritetoFile(String urlStr, String fileStr) {
	    URL url;
	    InputStream is = null;
	    BufferedReader br = null;
	    String line = null;
	    File fout = null;
		FileOutputStream fos = null;
		BufferedWriter bw = null;
	    try {
	        url = new URL(urlStr);
	        is = url.openStream();  // throws an IOException
	        br = new BufferedReader(new InputStreamReader(is));
	        fout = new File(fileStr);
	        fos = new FileOutputStream(fout);
	        bw =  new BufferedWriter(new OutputStreamWriter(fos));
	        
	        int count = 1;
	        while ((line = br.readLine()) != null) {
	            System.out.println(++count);
	            bw.write(line);
	            bw.newLine();
	        }
	    } catch (MalformedURLException mue) {
	         mue.printStackTrace();
	    } catch (IOException ioe) {
	         ioe.printStackTrace();
	    } finally {
	        try {
	            if (is != null) is.close();
	            if (fos != null) fos.close();
	            if (br != null) br.close();
	            if (bw != null) bw.close();
	        } catch (IOException ioe) {
	            // nothing to see here
	        }
	    }
	    return fileStr;
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
	
	

    public static String getImageUrl(String url) throws IOException {
        
        Document doc = Jsoup.connect(url).get();
        Elements media = doc.select("[src]");
        String ImgSrc=null;
		for (Element src : media){
			Element grandParent = src.parent().parent();
			String grandParentTag = grandParent.tagName();
			String grandParentAtt = grandParent.attr("id");
			
			if(grandParentTag.equalsIgnoreCase("div") 
				&& grandParentAtt.equalsIgnoreCase("image") 
				&& src.tagName().equals("img")
			  )
			{
				ImgSrc = src.attr("src");
				//System.out.println("\n\n --------------------------------- att "+grandParent.attr("id") +" tag "+ grandParent.tagName()+"\n\n");
				
				//System.out.println(src.attr("src"));
			}
        }
		
		
		
		return ImgSrc;

    }

    static boolean toCSV(String fileName, List<String> raws) {
		File f = new File(fileName);
		FileWriter fileWriter = null;
		
		
		try {
			fileWriter = new FileWriter(f,true);
			for(String raw : raws){
				fileWriter.append(raw);
			}


			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
			return false;
		} finally {
			
			try {
				fileWriter.flush();
				fileWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
                return false;
			}
		}
		
	}

}
