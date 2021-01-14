package CovidApi;

/* Java 샘플 코드 */

import java.net.URLEncoder;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;


import org.w3c.dom.Document;
import org.w3c.dom.NodeList;


public class Covid19 {
	String coronadecide;
	String coronadecide2;
	String coronadeath;
	String coronaexam;
	String coronadeath2;
	String coronaexam2;
	String decidea;
	String deatha;
	String exama;

	public String getCoronadecide() {
		return coronadecide;
	}
	
	public String getCoronadecide2() {
		return coronadecide2;
	}

	public String getCoronadeath() {
		return coronadeath;
	}
	
	public String getCoronadeath2() {
		return coronadeath2;
	}

	public String getCoronaexam2() {
		return coronaexam2;
	}

	public String getCoronaexam() {
		return coronaexam;
	}
	
	public String getDecidea() {
		return decidea;
	}
	
	public String getExama() {
		return exama;
	}
	
	public String getDeatha() {
		return deatha;
	}
	
    public void requestAPI() throws Exception {
    	CurrentTime time = new CurrentTime();
    	
    	time.request();
    	

    	String startdate = time.getDate1();
    	String enddate = time.getDate();
        StringBuilder urlBuilder = new StringBuilder("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=zr1cEDXz5sQzQ2GAmJLFG9P90m9RBRbnYdRDw9S7lCVUIvIGDIqgZkdIwYwhLsEE6lzxH0d%2FsWKuiZJIn6%2Fgaw%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(startdate, "UTF-8")); /*검색할 생성일 범위의 시작*/
        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(enddate, "UTF-8")); /*검색할 생성일 범위의 종료*/
        String url = urlBuilder.toString();


        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();   
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(url);
        
        doc.getDocumentElement().normalize();
        NodeList n_list = doc.getElementsByTagName("item");
        NodeList childNodes = n_list.item(0).getChildNodes();

        for (int j = 0; j < childNodes.getLength(); ++j) {
            if("decideCnt".equals(childNodes.item(j).getNodeName())) {
            	this.coronadecide = childNodes.item(j).getTextContent();
            }
            else if("examCnt".equals(childNodes.item(j).getNodeName())) {
            	this.coronaexam = childNodes.item(j).getTextContent();
            }
            else if("deathCnt".equals(childNodes.item(j).getNodeName())) {
            	this.coronadeath = childNodes.item(j).getTextContent();
            }
       }
        
        NodeList childNodes2 = n_list.item(1).getChildNodes();
        for (int j = 0; j < childNodes2.getLength(); ++j) {
            if("decideCnt".equals(childNodes2.item(j).getNodeName())) {
            	this.coronadecide2 = childNodes2.item(j).getTextContent();
            }
            else if("examCnt".equals(childNodes2.item(j).getNodeName())) {
            	this.coronaexam2 = childNodes2.item(j).getTextContent();
            }
            else if("deathCnt".equals(childNodes2.item(j).getNodeName())) {
            	this.coronadeath2 = childNodes2.item(j).getTextContent();
            }
       }
        
        int decide = Math.abs(Integer.parseInt(coronadecide)-Integer.parseInt(coronadecide2));
        this.decidea = Integer.toString(decide);
        
        int death = Math.abs(Integer.parseInt(coronadeath)-Integer.parseInt(coronadeath2));
        this.deatha = Integer.toString(death);
        
        int exam = Math.abs(Integer.parseInt(coronaexam)-Integer.parseInt(coronaexam2));
        this.exama = Integer.toString(exam);
               
	}
}