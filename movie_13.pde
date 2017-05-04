import processing.video.*;
import processing.serial.*;
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

//impoort
Movie mov;
PFont f;
PImage img1;
PImage img2;
float rev;
int accountNum = 0;
boolean jump = false;

int nowTime;
int speedChangeTime;
float oldSpeed;

float r = 1;
float d = 1;
float s = 1;
Boolean videoSwitch = false;
Boolean imageSwitch = false;
Boolean circlesSwith= false;



Serial myPort;

int number = 0;
//Boolean timeSwitch =false;
//write the two lists, List<String> abouts = .....

String About = "";
String Title = "";
String Date = "";
String Location = "";


static List<String> abouts = null;
static List<String> times = null;
static List<String> titles = null;
static List<String> dates = null;
static List<String> locations = null;
int count = 0;
int selectMovie=1;


void setup() {

  abouts = new ArrayList<String>();
  times = new ArrayList<String>();
  titles = new ArrayList<String>();
  dates = new ArrayList<String>();
  locations = new ArrayList<String>();
  loadDataInToList();

  String portName = Serial.list()[3];
  // initiat the list as, abouts = putFileList(aboutFile);

  myPort = new Serial(this, portName, 9600);

  size(1280, 720, P3D);

  f=loadFont("Avenir-Roman-48.vlw");
  img1=loadImage("1.jpg");
  img2=loadImage("2.jpg");

  background(0);

  mov = new Movie(this, "timelapse.mp4");

  mov.loop();

  //String aboutsFile = "about.txt";
  //String timesFile = "time.txt";

  //abouts = putFileInList(aboutsFile);
  //times = putFileInList(timesFile);
  //About = passTimeGetAbout((float) 2.1);
  System.out.print(About);
}




void movieEvent(Movie mov) {

  mov.read();
  //println();
}



//void mousePressed() {
//  mov.pause();
//  videoSwitch=!videoSwitch;
//  //textSize(32);
//  //text("asdfgh",100,300);
//}

//void mouseReleased() {
//  mov.play();
//   //println(mov.duration());
//    videoSwitch=!videoSwitch;
//}


//void keyPressed(){

//redraw();
//}


void draw() {

  if (myPort.available()>0) {
    String inString = myPort.readStringUntil('\n');
    if(inString != null)
    {
    inString = inString.trim();
    number = int(inString);
    }
    if (number == 1111&&accountNum == 0) {
      accountNum = 1;
      number = 0;
     }
    if (number == 1111&&accountNum == 1) {
      selectMovie ++;
      number = 0;
      if (selectMovie>3) {
        selectMovie=1;
      }
     }
     else if(number == 1111&&accountNum == 2){
      mov.pause();
      number = 0;
      if(videoSwitch)
      {
        mov.play();
      }
      videoSwitch=!videoSwitch;
      }
    //right brake
    if (number == 2222) {
      println("start");
      number = 0;
      accountNum = 2;
    } else if (number == 3333) {
      println("restart");
      accountNum = 0;
      number = 0;
    }
  }

  if (accountNum == 0) {
    image(img1, 0, 0, 1280, 720 );
    jump = true;
    mov.pause();
  }
    //on the welcome page
    if (accountNum == 1) {
      image(img2, 0, 0, 1280, 720 );
      jump = true;
      mov.pause();
      if (selectMovie == 1) {
        strokeWeight(3);
        stroke(255,153,0);
        noFill();
        ellipse(width/2-337, height/2+24, 250, 250);
      }

      if (selectMovie == 2) {
        strokeWeight(3);
        stroke(255,153,0);
        noFill();
        ellipse(width/2-2, height/2+24, 250, 250);
      }

      if (selectMovie == 3) {
        strokeWeight(3);
        stroke(255,153,0);
        noFill();
        ellipse(width/2+335, height/2+24, 250, 250);
      }
    }


    if (accountNum == 2) {

    image(mov, 0, 0, 1280, 720);
    if(jump)
    {
      if (selectMovie == 1) {
        mov.jump(0.1);
        mov.play();
        jump = false;
      }
      if (selectMovie == 2) {
        mov.jump(202);
        mov.play();
        jump = false;
      }

      if (selectMovie == 3) {
        mov.jump(409);
        mov.play();
        jump = false;
      }
    }
    if (selectMovie == 1 && mov.time() > 200) {
        mov.pause();/////////////////////////
        accountNum = 0;
      }
      if (selectMovie == 2 && mov.time() > 407) {
        mov.pause();/////////////////////////
        accountNum = 0;
      }
      if (selectMovie == 3 && mov.time() > 552) {
        mov.pause();/////////////////////////
        accountNum = 0;
      }

      float mt = mov.time();
      //println(mt);
      if (videoSwitch) {
        About = passTimeGetAbout((float) mt);
        Title = passTimeGetTitles((float) mt);
        Date = passTimeGetDates((float) mt);
        Location = passTimeGetLocations((float) mt);
        //System.out.println(times);

        d=d+10;
        s=s+4;
        r= r+180;

        noStroke();
        fill(0, d);
        ellipse(width/2, height/2, r, r);

        fill(255, d+200);
        textSize(20);
        //textFont(f);
        textAlign(CENTER, CENTER);
        text(About, width/2-500, height/2-200, 1000, 400);
        textAlign(LEFT);
        text(Date, width/2-400, height/2+200, 800, 100);
        textAlign(RIGHT);
        text(Location, width/2, height/2+200, 800, 100);
        textAlign(LEFT);
        textSize(30);
        text(Title, width/2-400, height/2-300, 800, 100);

        fill(200, 10, 10);
        text("Continue riding the bicycle , you can keep going.", width/2-400, height/2+320, 800, 100);


        if (d>100) {
          d=100;
          s=20;
          r=1800;
        }

        //text(nfc(newSpeed, 2) + "X", 10, 30);
      }
    }
  }

















//display the image
//if (myPort.available()>0) {
//  String inString = myPort.readStringUntil('\n');
//  inString = inString.trim();
//  number = int(inString);

//  if (accountNum==1) {
//    if (number == 1111) {
//      selectMovie ++;
//      if (selectMovie>3) {
//        selectMovie=1;
//      }
//    }
//    if (selectMovie ==1) {
//      eclipse();
//    }
//    if (selectMovie ==2 ) {
//      eclipse();
//    }
//    if (selectMovie ==3) {
//      eclipse();
//    }
//  } else if (accountNum==2) {
//    println("pause");
//    mov.pause();
//    number = 0;
//    videoSwitch=!videoSwitch;
//  }
//  if (number == 2222)
//  {
//    println("start");
//    number = 0;
//    accountNum = 2;
//  } else if (number == 3333)
//  {
//    println("restart");
//    accountNum = 1;
//    number = 0;
//  } else {
//    println(number);
//  }
//}

//if (accountNum == 1) {
//  image(img, width/2-512, height/2-384, 1024, 768);
//  mov.pause();
//  jump = true;
//} else if (accountNum == 2) {
//  //if(mov.available()){
//  //play the video
//  if (selectMovie==1) {
//    image(mov, width/2-1536, height/2-384, 3072, 768);
//  }
//  if (selectMovie==2) {
//    image(mov2, width/2-1536, height/2-384, 3072, 768);
//  }
//  if (selectMovie==3) {
//    image(mov3, width/2-1536, height/2-384, 3072, 768);
//  }
//  if (jump) {
//    mov.pause();/////////////////////////
//    number=0;
//    mov.jump(0.1);
//    mov.play();
//    jump = false;
//  }
//  //}
//  float mt = mov.time();
//  //println(mt);
//  if (videoSwitch) {
//    About = passTimeGetAbout((float) mt);
//    Title = passTimeGetTitles((float) mt);
//    Date = passTimeGetDates((float) mt);
//    Location = passTimeGetLocations((float) mt);
//    //System.out.println(times);



//    d=d+10;
//    s=s+4;
//    r= r+180;


//    noStroke();
//    fill(0, d);
//    ellipse(width/2, height/2, r, r);

//    fill(255, d+200);
//    textSize(20);
//    //textFont(f);
//    textAlign(CENTER, CENTER);
//    text(About, width/2-500, height/2-200, 1000, 400);
//    textAlign(LEFT);
//    text(Date, width/2-400, height/2+200, 800, 100);
//    textAlign(RIGHT);
//    text(Location, width/2, height/2+200, 800, 100);
//    textAlign(LEFT);
//    textSize(30);
//    text(Title, width/2-400, height/2-300, 800, 100);

//    fill(200, 10, 10);
//    text("Continue riding the bicycle , you can keep going.", width/2-400, height/2+320, 800, 100);


//    if (d>100) {
//      d=100;
//      s=20;
//      r=1800;
//    }

//    //text(nfc(newSpeed, 2) + "X", 10, 30);
//  }
//  if ( number != 1111 && number!= 2222)
//  {
//    if (number == 0)
//    {
//      rev=0;
//      mov.pause();
//      number = 0;
//    } else if (number>5 && number<=50) {
//      mov.play();
//      s=1;
//      r=1;
//      d=1;
//      if ( videoSwitch)
//      {
//        videoSwitch=!videoSwitch;
//      }
//      rev= 0.5;
//    } else if (number >50 && number<=80)
//    {
//      mov.play();
//      s=1;
//      r=1;
//      d=1;
//      if ( videoSwitch)
//      {
//        videoSwitch=!videoSwitch;
//      }
//      rev= 1;
//    } else if (number >80 && number<=110) {
//      mov.play();
//      s=1;
//      r=1;
//      d=1;
//      if ( videoSwitch)
//      {
//        videoSwitch=!videoSwitch;
//      }
//      rev=1.5;
//    } else if (number<120) {
//      mov.play();
//      s=1;
//      r=1;
//      d=1;
//      if ( videoSwitch)
//      {
//        videoSwitch=!videoSwitch;
//      }
//      rev=2;
//    } else {
//      rev=0;
//      mov.pause();
//    }
//  }


//  // float rev = map(number);



//  float newSpeed = rev;
//  println(newSpeed);
//  nowTime = millis();
//  if ( nowTime - speedChangeTime > 1000 && newSpeed != oldSpeed)
//  {
//    count++;
//    if (count > 5) {
//      count= 0;
//      mov.speed(newSpeed);
//      oldSpeed = newSpeed;
//      speedChangeTime = millis();
//    }
//  }

//fill(255);

//}





// post the two functions, putFileInList and passTimeGetAbout()
private static List<String> putFileInList(String fileStr) {
  File fin = new File(fileStr);
  FileInputStream fis = null;
  List<String> lines = new ArrayList<String>();

  BufferedReader br = null;

  String line = null;




  try {
    fis = new FileInputStream(fin);
    br = new BufferedReader(new InputStreamReader(fis));
    while ((line = br.readLine()) != null) {
      //System.out.println(line);
      lines.add(line);
    }
  }
  catch (MalformedURLException mue) {
    mue.printStackTrace();
  }
  catch (IOException ioe) {
    ioe.printStackTrace();
  }
  finally {
    try {
      if (br != null) br.close();
    }
    catch (IOException ioe) {
      // nothing to see here
    }
  }
  return lines;
}


private static String passTimeGetAbout(float time) {
  String aboutInList= "THE TIME IS NOT IN THE LIST";

  for (int i=0; i < abouts.size(); i++) {
    String timeInList = times.get(i);
    String[] parts = timeInList.split("-");
    if (Float.parseFloat(parts[0]) <= time && Float.parseFloat(parts[1]) >= time) {
      aboutInList = abouts.get(i);
      break;
    }
  }

  return aboutInList;
}

private static String passTimeGetTitles(float time) {
  String titleInList= "THE TIME IS NOT IN THE LIST";

  for (int i=0; i < titles.size(); i++) {
    String timeInList = times.get(i);
    String[] parts = timeInList.split("-");
    if (Float.parseFloat(parts[0]) <= time && Float.parseFloat(parts[1]) >= time) {
      titleInList = titles.get(i);
      break;
    }
  }

  return titleInList;
}


//Dates
private static String passTimeGetDates(float time) {
  String dateInList= "THE TIME IS NOT IN THE LIST";

  for (int i=0; i < dates.size(); i++) {
    String timeInList = times.get(i);
    String[] parts = timeInList.split("-");
    if (Float.parseFloat(parts[0]) <= time && Float.parseFloat(parts[1]) >= time) {
      dateInList = dates.get(i);
      break;
    }
  }

  return dateInList;
}

//Location
private static String passTimeGetLocations(float time) {
  String locationInList= "THE TIME IS NOT IN THE LIST";

  for (int i=0; i < locations.size(); i++) {
    String timeInList = times.get(i);
    String[] parts = timeInList.split("-");
    if (Float.parseFloat(parts[0]) <= time && Float.parseFloat(parts[1]) >= time) {
      locationInList = locations.get(i);
      break;
    }
  }

  return locationInList;
}

public static void loadDataInToList() {
  times.add("0-9");
  times.add("9-47");
  times.add("47-49");
  times.add("49-57");
  times.add("57-71");
  times.add("71-81");
  times.add("81-160");
  times.add("160-162");
  times.add("162-165");
  times.add("165-168");
  times.add("168-170");
  times.add("170-172");
  times.add("172-219");
  times.add("219-237");
  times.add("237-240");
  times.add("240-242");
  times.add("242-245");
  times.add("245-248");
  times.add("248-252");
  times.add("252-255");
  times.add("255-258");
  times.add("258-271");
  times.add("271-274");
  times.add("274-277");
  times.add("277-286");
  times.add("286-291");
  times.add("291-294");
  times.add("294-297");
  times.add("297-298");
  times.add("298-301");
  times.add("301-302");
  times.add("302-304");
  times.add("304-343");
  times.add("343-400");
  times.add("400-406");
  times.add("406-417");
  times.add("417-421");
  times.add("421-441");
  times.add("441-451");
  times.add("451-480");
  times.add("480-566");
  times.add("566-574");
  times.add("574-578");

  //adds titles

  titles.add("Class photo of the Dean School");
  titles.add("David Hume Tower in twilight");
  titles.add("North British Station Hotel on Princes Street");
  titles.add("Balmoral Hotel");
  titles.add("Top of Leith Walk ca 1991");
  titles.add("Trams on Princes Street");
  titles.add("Walking in the rain");
  titles.add("Leith Docks in the past.");
  titles.add("Present day Leith Docks.");
  titles.add("A Leith Ferry");
  titles.add("Roadworks");
  titles.add("Victoria Primary School");
  titles.add("Newhaven born and bred");
  titles.add("Top of Leith Walk");
  titles.add("Edinburgh's thinking man");
  titles.add("Sir Walter Scott and St. Giles Cathedral");
  titles.add("The towering Scott Monument");
  titles.add("Princes Street stroll");
  titles.add("Time on my hands");
  titles.add("Queue of buses on Waverley Bridge");
  titles.add("Waiting for a train at Waverley Station");
  titles.add("Edinburgh's beating heart");
  titles.add("Castle and Princes Street from North British Hotel");
  titles.add("Unicorn on guard");
  titles.add("Army Parade");
  titles.add("Impromptu street performance, Edinburgh Fringe");
  titles.add("Impromptu street performance, Edinburgh Fringe");
  titles.add("Fringe Performers");
  titles.add("The Hub #competition16");
  titles.add("Lawnmarket, Edinburgh");
  titles.add("A beautiful day in Edinburgh");
  titles.add("Capital illuminations");
  titles.add("Waiting to meet Muhammad Ali");
  titles.add("View of Edinburgh Meat Market");
  titles.add("West Bow (Foot of Victoria Street)");
  titles.add("Victoria Street, North Side View");
  titles.add("William Chambers, Lord Provost and Edinburgh town planner");
  titles.add("Olympic Torch on George IV Bridge");
  titles.add("Harmony...");
  titles.add("Sunset");
  titles.add("Walk");
  titles.add("Stranger on the shore");
  titles.add("Wave");

  //adds abouts
  abouts.add("1951 - the right, second row.");
  abouts.add("When I first moved into the city centre, I entered my new council flat with my housing officer. I looked around the bare lodgings, walking across the hardwood floor. I looked out the windows and there it was. The one building I'd see every day that I lived in my new house.");
  abouts.add("Now its the Balmoral Hotel, but originally it was the North British Station Hotel. Princes Street looks much the same except for the cars. This photo also shows the original gardens on the top of the Waverley Market.");
  abouts.add("The splendid architecture of the Balmoral Hotel viewed from the North Bridge, with the clouds appearing to come from the hotel. In the background some  buildings on Princes Street, including parts of Register house, can be seen.A few pedestrians are crossing the bridge and there are a few vehicles");
  abouts.add("I always brought my camera and took a lot of photos.  How would we otherwise remember? History would get lost.");
  abouts.add("A tram from a different era on Princes Street! Love the plumes of steam coming from the trains at Waverley.");
  abouts.add("The wet pavements produce mirror effects, showing the two people walking past the decorative lamp posts at the entrance to the National Portrait Gallery on Queen Street. Winter trees add to the atmosphere of a winter's day.");
  abouts.add("Leith Docks was a major hub once.");
  abouts.add("The Royal Yacht Britannia and modern yachts form a key part of present day Leith Docks.");
  abouts.add("I remember I took the ferry to Norway from here.");
  abouts.add("I don't like that there is always road works everywhere! It feels like every time I get out on my bike I have to take a completely different route than the day before...it is really annoying!");
  abouts.add("Both young and older members of our group attended this school.");
  abouts.add("My mother was a Leither! I was born in Newhaven.  My mother could not have picked a better place to be born, than in Newhaven.  Because everyone knew everybody.  And everyone would always help each other out.  Even if it was someone who was short of money, because they didn't get a big enough catch.");
  abouts.add("A current view of the top of Leith Walk.");
  abouts.add("The Sir Walter Scott Monument with St. Giles Cathedral in the background as seen from South St. Davids Street near Jenners.");
  abouts.add("A daytime of shot of the Scott Monument with St. Giles Cathedral in the background.");
  abouts.add("If I had to pick one older place in Edinburgh to look at, it'd be the Scott Monument. This unmoving gothic monolith towers over Princes Street like no other structure in the area.");
  abouts.add("My Great Uncle Bill strolls along Princes Street. You can see the Scott Monument and electric  trams in the background.");
  abouts.add("Sir Walter Scott Monument with the Balmoral Clock Tower in the background.");
  abouts.add("Love the bus driver's uniforms, they looked so smart.");
  abouts.add("Waiting on platform 9 for the train to Newcastle.");
  abouts.add("I love this view of the Waverley Station it's always such a busy scene with iconic building skirting the famous old transport hub.");
  abouts.add("A photograph of Princes Street busy with trams and buses.");
  abouts.add("The unicorn (Scotland's national heraldic symbol) is one of two sculptures created by Phillis Bone  at the entrance of the magnificent and evocative Scottish National War Memorial situated in Edinburgh Castle. The other is a lion. Created 1924-27. Together they mark a simple and respectful threshold to a building which pays tribute to those fallen in war, human and animal.");
  abouts.add("One of my favourite memories from 2013");
  abouts.add("The Edinburgh Festival Fringe has its roots in the attendance of eight uninvited theatre groups at the inaugural Edinburgh International Festival in 1947. This unofficial adjunct to the festival grew in both size and organisation throughout the 1950's with more and more performers coming to take advantage of the audiences drawn to the capital by the official events.");
  abouts.add("The Edinburgh Festival Fringe has its roots in the attendance of eight uninvited theatre groups at the inaugural Edinburgh International Festival in 1947. This unofficial adjunct to the festival grew in both size and organisation throughout the 1950's with more and more performers coming to take advantage of the audiences drawn to the capital by the official events.");
  abouts.add("Korean dancers perform on the Royal Mile.");
  abouts.add("Probably one of the most impressive buildings in Edinburgh, I chose this picture because it reminds me not only of the scale and size of the place, but also how small we really are :)");
  abouts.add("Lawnmarket is the section of Edinburgh's Royal Mile running from its junction with Johnston Terrace to where it meets George IV Bridge. Regular markets were held in this area until the late 18th century.");
  abouts.add("Escaping the office for a short while and discovering a beautiful wintry blue sky day at the Castle.");
  abouts.add("I first arrived in Edinburgh on a January afternoon and from Waverley Bridge, having left the railway station, was welcomed by the capital illuminated, the Castle lit up as were buildings I would later learn to be the art galleries on the Mound and Ramsay's Gardens. The Christmas lights had been taken down as it was after the 6th January, but otherwise this is the welcoming picture I have in my mind. And I still go  back to view and enjoy");
  abouts.add("2.00 pm - To pass the time, I took a photograph of Edinburgh Castle. It was sunny outside on that cold November day.");
  abouts.add("The site of the former Edinburgh Meat Market is immediately to the south of Scottish Widows HQ. The old entrance arch (scaffolded in this picture) from the meat market has been relocated to its original site further along Fountainbridge.");
  abouts.add("Edinburgh's West Bow was zig-zagging street which led from the Grassmarket to the Lawnmarket. Originally the street was filled with a quirky assortment of 17th-century tenements, with crow-stepped gables, flight-holes for doves, towers and merchants shops.");
  abouts.add("Providing a cobbled  thoroughfare between the Grassmarket and George IV Bridge, housing the National Library. Steps shown at road level and colonnaded walkway give access  to the Lawnmarket, Assembly Hall (Spire shown), Camera Obscura and the Castle Esplanade.An ideal pedestrian means of gaining swift connection between Old Town places of interest.");
  abouts.add("William Chambers (1800-1883) and his brother Robert moved to Edinburgh from Peebles setting up a bookshop and developing interests in printing and publication, contributing to Edinburgh's literary development. William served as Lord Provost, clearing slums, building new streets and widening High Street Closes. He developed the street that now bears his name. The statue was the work of John Rhind, mounted on a sandstone plinth by HJ Blanc. It was erected in 1891 and until mid 2016 stood in the middle of Chambers Street. The pedestrian area in front of the National Monument of Scotland was widened and Chamber's monument moved onto this area, also making space for a monument to William Henry Playfair, erected in 2016 to a pattern similar to that of Chambers.");
  abouts.add("Crowds line the street to watch the Olympic torch passing.");
  abouts.add("How wonderful is the nature in Holyrood Park can say every one who was there...");
  abouts.add("...at St. Margaret's Loch more beautiful day by day...");
  abouts.add("Walking through the beauty of the entire Holyrood Park nature always brings amazing impression");
  abouts.add("My first ever visit to Portobello Beach and  even though I live in a very coastal area of North Wales , this is by far my favourite beach in the world.  I was sitting looking around and spotted this gentleman tucked into the groynes on the beach, looking out over the Forth.  I don't know  how long he had been there, or how long he was there, but he really made an impact on me and I had to capture his moment.  I cannot put my finger on just what Edinburgh means to me  as a Welsh visitor but its like coming home.  I would move to Edinburgh in a nano second, my heart hurts when I am away from her beauty.");
  abouts.add("Water drops like a cristal at Portobello Beach");


  //adds dates

  dates.add("1951");
  dates.add("3rd July 2016");
  dates.add("1937");
  dates.add("17th April 2015");
  dates.add("1991");
  dates.add("1954");
  dates.add("16th March 2013");
  dates.add("1980");
  dates.add("2016");
  dates.add("16-Jul");
  dates.add("16-Jul");
  dates.add("16-Jul");
  dates.add("16-Jul");
  dates.add("16-Jul");
  dates.add("2014");
  dates.add("2012");
  dates.add("16-May");
  dates.add("21st June 1937");
  dates.add("2014");
  dates.add("1958");
  dates.add("23rd May 2015");
  dates.add("16-Jun");
  dates.add("1954");
  dates.add("15th January 2016");
  dates.add("18th May 2013");
  dates.add("13-Aug");
  dates.add("13-Aug");
  dates.add("15-Aug");
  dates.add("14th June 2016");
  dates.add("1954");
  dates.add("30th January 2015");
  dates.add("5th January 2013");
  dates.add("20th November 1993");
  dates.add("2007");
  dates.add("2000");
  dates.add("12-May");
  dates.add("8th August 2016");
  dates.add("12-Jul");
  dates.add("2015");
  dates.add("2015");
  dates.add("2015");
  dates.add("16th August 2012");
  dates.add("2015");

  //adds locations

  locations.add("Dean Village");
  locations.add("Buccleuch Place");
  locations.add("Princes Street, New Town");
  locations.add("North Bridge, New Town");
  locations.add("Leith Walk, Leith");
  locations.add("Princes Street, New Town");
  locations.add("Queen Street, New Town");
  locations.add("Leith Docks, Leith");
  locations.add("Leith Docks, Leith");
  locations.add("Leith docks, Leith");
  locations.add("Newhaven, Leith");
  locations.add("Newhaven, Leith");
  locations.add("Newhaven, Leith");
  locations.add("Leith Walk, Leith");
  locations.add("Princes Street, Old Town");
  locations.add("Princes Street Gardens");
  locations.add("Princes St");
  locations.add("Princes Street, New Town");
  locations.add("Princes Street Gardens, Edinburgh");
  locations.add("Waverley Bridge, New Town");
  locations.add("Waverley Station, Edinburgh, Old Town");
  locations.add("Waverley Station, Old Town");
  locations.add("Princes Street, Edinburgh, New Town");
  locations.add("Edinburgh Castle, Old Town");
  locations.add("Edinburgh Castle, Edinburgh, Old Town");
  locations.add("Royal Mile, Edinburgh, Old Town");
  locations.add("Royal Mile, Edinburgh, Old Town");
  locations.add("High Street, Edinburgh, Old Town");
  locations.add("The Hub, Royal Mile, Old Town");
  locations.add("Lawnmarket, Edinburgh, Old Town");
  locations.add("Edinburgh Castle, Old Town");
  locations.add("From Waverley Bridge, Old Town");
  locations.add("Princes Street, New Town");
  locations.add("Fountainbridge");
  locations.add("Grassmarket, Edinburgh, Old Town");
  locations.add("Victoria Street, Old Town");
  locations.add("Chambers Street");
  locations.add("George IV Bridge Edinburgh, Old Town");
  locations.add("Holyrood Park, Old Town");
  locations.add("Holyrood Park, Old Town");
  locations.add("Holyrood Park, Old Town");
  locations.add("Beach, Portobello");
  locations.add("Beach, Portobello");
}

void keyReleased(){

 if(keyPressed) {
  if (key == 'q') {   //competition
    if (accountNum == 0) {
      accountNum = 1;
     }
   if (accountNum == 1) {
      selectMovie ++;
      if (selectMovie>3) {
        selectMovie=1;
      }
     }
     else if(accountNum == 2){
      mov.pause();
      if(videoSwitch)
      {
        mov.play();
      }
      videoSwitch=!videoSwitch;
      }
   if (selectMovie>3) {
        selectMovie=1;
      }
    }

   if (key == 'w') {   //competition
    println("start");
      accountNum = 2;
    }
    if (key == 'e') {   //competition
   println("restart");
      accountNum = 0;
    }
}
}



//void keyPressed(){

//text("");

//mov.jump(0);
//}
//listen to the event. when buffer filled, run this method
