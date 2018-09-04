package com.youzan.pfcase.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

public class AdminUser implements Serializable {
	
	private static final long serialVersionUID = -972786808689136607L;
	
	@NotNull
	private String name;
	
	@NotNull
	private String password;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
