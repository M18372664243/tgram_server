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
public class Groups implements Serializable {

    private static final long serialVersionUID = -972786808689136607L;

    @NotNull
    @Min(1)
    private int groupid;

    @NotNull
    @Size(min = 1, max = 80)
    private String groupname;

    @NotNull
    @Size(min = 1, max = 200)
    private String grouplink;

    @NotNull
    @Size(min = 1, max = 200)
    private String groupicon;

    @NotNull
    private int enabled;

    @NotNull
    private int seq;
    
    @NotNull
    private int deleted;

    private Timestamp createtime;

    private Timestamp updatetime;

	public int getGroupid() {
		return groupid;
	}

	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public String getGrouplink() {
		return grouplink;
	}

	public void setGrouplink(String grouplink) {
		this.grouplink = grouplink;
	}

	public String getGroupicon() {
		return groupicon;
	}

	public void setGroupicon(String groupicon) {
		this.groupicon = groupicon;
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

    
    
}
