import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

public class deleteCol {

	public static void main(String[] args) {
		
		
		List<String> raws = readFile("dataOFMemoriesWith01.csv");
		List<String> rawsWithOutZeros = new ArrayList<String>();
		for(String s : raws)
			if(s.charAt(0) == '1')
				rawsWithOutZeros.add(s.substring(2)+"\n");
		int i = 0 ;
		for(String s : rawsWithOutZeros){
			System.out.println(i++ +": "+s);
		}
		toCSV("Locations.csv",rawsWithOutZeros);
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
