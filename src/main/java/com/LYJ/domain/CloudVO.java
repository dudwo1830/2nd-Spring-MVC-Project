package com.LYJ.domain;

import java.sql.Timestamp;

public class CloudVO {
	private int cid;
	private int ccount;
	private Timestamp cdate;
	private String cfileName;
	private String coriginName;
	private long cfileSize;
	private String cuid;
	private String cunickName;
	private String ext;

	public String getCoriginName() {
		return coriginName;
	}
	public void setCoriginName(String coriginName) {
		this.coriginName = coriginName;
	}
	public String getCunickName() {
		return cunickName;
	}
	public void setCunickName(String cunickName) {
		this.cunickName = cunickName;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	public Timestamp getCdate() {
		return cdate;
	}
	public void setCdate(Timestamp cdate) {
		this.cdate = cdate;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getCcount() {
		return ccount;
	}
	public void setCcount(int ccount) {
		this.ccount = ccount;
	}
	public String getCfileName() {
		return cfileName;
	}
	public void setCfileName(String cfileName) {
		this.cfileName = cfileName;
	}
	public long getCfileSize() {
		return cfileSize;
	}
	public void setCfileSize(long cfileSize) {
		this.cfileSize = cfileSize;
	}
	public String getCuid() {
		return cuid;
	}
	public void setCuid(String cuid) {
		this.cuid = cuid;
	}
	
	@Override
	public String toString() {
		return "CloudVO [cid=" + cid + ", ccount=" + ccount + ", cdate=" + cdate + ", cfileName=" + cfileName
				+ ", cfileSize=" + cfileSize + ", cuid=" + cuid + "]";
	}
	
}
