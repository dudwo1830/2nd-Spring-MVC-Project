package com.LYJ.domain;

import java.sql.Date;

public class UserDTO {
	private String uid;
	private String upw;
	private String unickname;
	private String ulevel;
	private Date ujoindate;
	private Date ulastdate;
	private String authkey;
	private String authkeyStatus;
	private int upoint;
	private String uad;
	
	public int getUpoint() {
		return upoint;
	}
	public void setUpoint(int upoint) {
		this.upoint = upoint;
	}
	public String getUad() {
		return uad;
	}
	public void setUad(String uad) {
		this.uad = uad;
	}
	public String getAuthkeyStatus() {
		return authkeyStatus;
	}
	public void setAuthkeyStatus(String authkeyStatus) {
		this.authkeyStatus = authkeyStatus;
	}
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public Date getUjoindate() {
		return ujoindate;
	}
	public void setUjoindate(Date ujoindate) {
		this.ujoindate = ujoindate;
	}
	public Date getUlastdate() {
		return ulastdate;
	}
	public void setUlastdate(Date ulastdate) {
		this.ulastdate = ulastdate;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public String getUnickname() {
		return unickname;
	}
	public void setUnickname(String unickname) {
		this.unickname = unickname;
	}
	public String getUlevel() {
		return ulevel;
	}
	public void setUlevel(String ulevel) {
		this.ulevel = ulevel;
	}

	@Override
	public String toString() {
		return "UserDTO [uid=" + uid + ", upw=" + upw + ", unickname=" + unickname + ", ulevel=" + ulevel
				+ ", ujoindate=" + ujoindate + ", ulastdate=" + ulastdate + ", authkey=" + authkey + ", authkeyStatus="
				+ authkeyStatus + ", upoint=" + upoint + ", uad=" + uad + "]";
	}
}
