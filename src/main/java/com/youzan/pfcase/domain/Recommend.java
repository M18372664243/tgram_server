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
public class Recommend implements Serializable {

    private static final long serialVersionUID = -972786808689136607L;

    @NotNull
    @Min(1)
    private int recommendid;

    @NotNull
    @Size(min = 1, max = 80)
    private String recommendname;

    @NotNull
    @Size(min = 1, max = 200)
    private String recommendlink;

    @NotNull
    @Size(min = 1, max = 200)
    private String recommendicon;

    @NotNull
    private int enabled;

    @NotNull
    private int seq;
    
    @NotNull
    private int deleted;

    private Timestamp createtime;

    private Timestamp updatetime;

	public int getRecommendid() {
		return recommendid;
	}

	public void setRecommendid(int recommendid) {
		this.recommendid = recommendid;
	}

	public String getRecommendname() {
		return recommendname;
	}

	public void setRecommendname(String recommendname) {
		this.recommendname = recommendname;
	}

	public String getRecommendlink() {
		return recommendlink;
	}

	public void setRecommendlink(String recommendlink) {
		this.recommendlink = recommendlink;
	}

	public String getRecommendicon() {
		return recommendicon;
	}

	public void setRecommendicon(String recommendicon) {
		this.recommendicon = recommendicon;
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
