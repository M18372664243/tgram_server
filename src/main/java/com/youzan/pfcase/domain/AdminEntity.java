package com.youzan.pfcase.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class AdminEntity implements Serializable {
	
	@NotNull
	private Long id;
	
	@NotNull
	private String name;
	
	@NotNull
	private String salt;
	
	@NotNull
	private String passwordMd5;
	
	private Long created;
	private Long updated;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getPasswordMd5() {
		return passwordMd5;
	}
	public void setPasswordMd5(String passwordMd5) {
		this.passwordMd5 = passwordMd5;
	}
	public Long getCreated() {
		return created;
	}
	public void setCreated(Long created) {
		this.created = created;
	}
	public Long getUpdated() {
		return updated;
	}
	public void setUpdated(Long updated) {
		this.updated = updated;
	}
}
