package com.youzan.pfcase.mapper;

import org.springframework.stereotype.Repository;

import com.youzan.pfcase.domain.AdminEntity;

@Repository
public interface LoginMapper {
	
	AdminEntity getUser (String name);
	void insertUser (AdminEntity admin);

}
