package DAODTO;

public class BbsDTO {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private String bbsimg;
	private int bbsAvailable;
	private int bbsPopularity;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	
	public String getBbsimg() {
		return bbsimg;
	}
	public void setBbsimg(String bbsimg) {
		this.bbsimg = bbsimg;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailabe) {
		this.bbsAvailable = bbsAvailable;
	}
	public int getBbsPopularity() {
		return bbsPopularity;
	}
	public void setBbsPopularity(int bbsPopularity) {
		this.bbsPopularity = bbsPopularity;
	}
	
}
