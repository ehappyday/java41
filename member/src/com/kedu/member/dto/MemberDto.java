package com.kedu.member.dto;

public class MemberDto {
	private int no;
	private String memnm;
	private String mememail;
	private String mempwd;

	public MemberDto() {
		
	}
	
	public MemberDto(int no, String memnm, String mememail, String mempwd){
		this.no = no;
		this.memnm = memnm;
		this.mememail = mememail;
		this.mempwd = mempwd;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemnm() {
		return memnm;
	}
	public void setMemnm(String memnm) {
		this.memnm = memnm;
	}
	public String getMememail() {
		return mememail;
	}
	public void setMememail(String mememail) {
		this.mememail = mememail;
	}
	public String getMempwd() {
		return mempwd;
	}
	public void setMempwd(String mempwd) {
		this.mempwd = mempwd;
	}
	
	@Override
	public String toString() {
		return "MemberDto [no=" + no + ", memnm=" + memnm + ", mememail=" + mememail + ", mempwd=" + mempwd + "]";
	}
}
