import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CSVByLocation {

	public static void main(String[] args) {
		
		
		
		
		String FilewithLocation = "TableWithLocation.txt";
		String FilewithData = "dataOFMemories.txt";
		String FiletoCheck = "toCheckLocation.csv";
		String FolderName = "CSVs";
		new File("FolderName").mkdir();
		HashMap <String, List<String>> RawsByLoction = new HashMap<String, List<String>>();
		List<String> locations = readFile(FilewithLocation);//new ArrayList<String>(); 
		List<String> raws = readFile(FilewithData);
		HashMap<String, String> RawsWithout$ = new HashMap<String, String> ();
		List<String> checks = readFile(FiletoCheck);
		//HashMap<String, String> rawsHashed = new HashMap<String, String>();
		List<String> toCheckLocation = new ArrayList<String>(); 
		
		List<String> x = new ArrayList<String>(); 
		
		int i =0 ;
		for(String location : locations){
			//System.out.println(i++ +": "+ location);
			RawsByLoction.put(location, new ArrayList<String>());
		}
		System.out.println("__________________________________________");
		i=0;
		for(String raw : raws){
			String[] parts = raw.split("$");
			parts[0].length();
			//System.out.println(parts[0].length()+" "+i++ +": "+ raw.substring(1));
			RawsWithout$.put(raw.substring(1).split(",")[0],raw.substring(1));
			}
		
		for(String check : checks){
			String[] parts = check.split(",");
			//System.out.println((parts[0].length() + parts[1].length())+ " " + parts[0] + " " + parts[1]);
			String loc = check.substring(parts[0].length() + parts[1].length() + 2);
			//System.out.println(loc+"_______________" );
			if (loc != null && loc.length() > 0 && loc.charAt(0) == '\"')
				loc = loc.substring(1, loc.length()-1);
			//System.out.println(loc+"++++++" );
			if(locations.contains(loc))
				System.out.println(i++);
				//RawsByLoction.get(loc).add(RawsWithout$.get(parts[0]));
				//System.out.println(parts[0]+" "+RawsWithout$.get(parts[0]));
				//x.add(RawsWithout$.get(parts[0]));
				
		}
		i=0;
			for (String s : x)
				System.out.println(i++ +" "+s);
		
				i=0;
		for (HashMap.Entry<String, List<String>> entry : RawsByLoction.entrySet())
		{
			//for(String S: RawsByLoction.get(entry.getKey()) )
		    System.out.println(i++ +" " +entry.getKey());// + "/" + S);

			//System.out.println("__________________________________________");
		}
		System.out.println("__________________________________________");
		
		//List<String> dean = RawsByLoction.get("Lochend Park");
		//if(dean!= null)
		/*for(String s : dean)
			System.out.println(dean);*/
		
		/*i=0;
		for (HashMap.Entry<String, String> entry : RawsWithout$.entrySet())
		{
		    System.out.println(i++ +" "+entry.getKey() + "/" + entry.getValue());
		}*/

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
