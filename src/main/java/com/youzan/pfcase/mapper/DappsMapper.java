package com.youzan.pfcase.mapper;

import com.youzan.pfcase.domain.Account;
import com.youzan.pfcase.domain.Caselist;
import com.youzan.pfcase.domain.Dapps;
import com.youzan.pfcase.domain.DappsWechat;
import com.youzan.pfcase.domain.Groups;
import com.youzan.pfcase.domain.Picture;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sunjun on 16/8/2.
 */
@Repository
public interface DappsMapper {

	List<Dapps> getAllDapps();
	List<Dapps> getDapps(Integer offset,Integer limit);
	List<Dapps> getDappsEn(Integer offset,Integer limit);
	List<Dapps> getDappsTw(Integer offset,Integer limit);
	List<Dapps> getDappsKo(Integer offset,Integer limit);
	List<DappsWechat> getDappsWechat(Integer offset,Integer limit);
	List<DappsWechat> getDappsWechatEn(Integer offset,Integer limit);
	List<DappsWechat> getDappsWechatTw(Integer offset,Integer limit);
	List<DappsWechat> getDappsWechatKo(Integer offset,Integer limit);
	List<Integer> getGroups();
	void dappUpdate(Dapps dapp);
	void dappUpdateTw(Dapps dapp);
	void dappUpdateEn(Dapps dapp);
	void dappUpdateKo(Dapps dapp);
	void dappsWechatUpdate(DappsWechat dapp);
	void dappsWechatUpdateTw(DappsWechat dapp);
	void dappsWechatUpdateKo(DappsWechat dapp);
	void dappsWechatUpdateEn(DappsWechat dapp);
}
