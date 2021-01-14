package CovidApi;

import java.text.SimpleDateFormat;
import java.util.Date;
 
public class CurrentTime {
	// 오늘 날짜 불러오기
	Date today = new Date();
    // 불러온 날짜 형식 변경하기
    SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat time = new SimpleDateFormat("HHmm");
    // 형식 변경 후 변수에 넣기
    String d = date.format(today).toString();
    String t = time.format(today).toString();
    
    SimpleDateFormat aa = new SimpleDateFormat("yyyy년 MM월 dd일 ");
    String c = aa.format(today).toString();
    private int a = 0000;
    private int b = 1030;
    
    private int dd;
    private int tt = (int)Integer.parseInt(t);
    private String ddd;

    
    public void request() {
    	// 만약 시간이 00:00~10:30일 경우 데이터가 최신화 되지 않으므로 전전날로 설정
    	if(a<=tt && tt<=b) {
    		this.d=Integer.toString((int)Integer.parseInt(d)-1);
    		this.dd=(int)Integer.parseInt(d)-2;
    		this.ddd = Integer.toString(dd);
    		
    	}else {
    		this.dd=(int)Integer.parseInt(d)-1;
    		this.ddd = Integer.toString(dd);
    	}
		  
    }

  // 종료 날짜 반환
  public String getDate() {
	  return d;
  }
  
  // 시작 날짜 반환
  public String getDate1() {
	  return ddd;
  }
  
  public String getDate2() {
	  return c;
  }

}
