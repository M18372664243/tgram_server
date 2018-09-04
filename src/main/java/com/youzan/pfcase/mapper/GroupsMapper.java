package com.youzan.pfcase.mapper;

import com.youzan.pfcase.domain.Account;
import com.youzan.pfcase.domain.Caselist;
import com.youzan.pfcase.domain.Groups;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by sunjun on 16/8/2.
 */
@Repository
public interface GroupsMapper {

	List<Groups> getAllGroups();
	List<Groups> getGroups(Integer offset,Integer limit);
	List<Groups> getGroupsEn(Integer offset,Integer limit);
	List<Groups> getGroupsTw(Integer offset,Integer limit);
	List<Groups> getGroupsKo(Integer offset,Integer limit);
	List<Groups> getGroupsByType(Integer type);

	List<Groups> searchGroups(Map<String,Object> searchData);
	void groupUpdate(Groups group);
	void groupUpdateTw(Groups group);
	void groupUpdateEn(Groups group);
	void groupUpdateKo(Groups group);
}
