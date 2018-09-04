package com.youzan.pfcase.domain;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;
import java.sql.Timestamp;

/**
 * Created by sunjun on 16/8/12.
 */
public class Dapps implements Serializable {

    private static final long serialVersionUID = -972786808689136607L;

    @NotNull
    @Min(1)
    private int dappid;

    @NotNull
    @Size(min = 1, max = 80)
    private String dappname;

    @NotNull
    @Size(min = 1, max = 200)
    private String dapplink;

    @NotNull
    @Size(min = 1, max = 200)
    private String dappicon;

    @NotNull
    private int enabled;

    @NotNull
    private int seq;
    
    @NotNull
    private int deleted;
    
    @NotNull
    private int dapptype;

    private Timestamp createtime;

    private Timestamp updatetime;

	public int getDappid() {
		return dappid;
	}

	public void setDappid(int dappid) {
		this.dappid = dappid;
	}

	public String getDappname() {
		return dappname;
	}

	public void setDappname(String dappname) {
		this.dappname = dappname;
	}

	public String getDapplink() {
		return dapplink;
	}

	public void setDapplink(String dapplink) {
		this.dapplink = dapplink;
	}

	public String getDappicon() {
		return dappicon;
	}

	public void setDappicon(String dappicon) {
		this.dappicon = dappicon;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public Timestamp getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	public Timestamp getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Timestamp updatetime) {
		this.updatetime = updatetime;
	}

	public int getDapptype() {
		return dapptype;
	}

	public void setDapptype(int dapptype) {
		this.dapptype = dapptype;
	}

}
