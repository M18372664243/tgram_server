package com.youzan.pfcase.web.my;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youzan.pfcase.conf.BusinessResult;
import com.youzan.pfcase.domain.AdminEntity;
import com.youzan.pfcase.domain.AdminUser;
import com.youzan.pfcase.mapper.LoginMapper;


@Controller
@RequestMapping("auth")
public class LoginController {
	
	@Autowired
	LoginMapper loginMapper;
	
	@CrossOrigin
	@RequestMapping(path="/login",method=RequestMethod.POST)
	@ResponseBody
	public BusinessResult<Object> login(@RequestBody AdminUser user,HttpServletRequest request){
		Map<String, Object> responseData = new HashMap<String,Object>();
		AdminEntity adminEntity = loginMapper.getUser(user.getName());
		if(adminEntity ==null){
			return new BusinessResult<>(null,BusinessResult.loginInvalid,"用户名或密码错误");
		}
		String passwordMd5 = getMd5(user.getPassword()+adminEntity.getSalt());
		if (!passwordMd5.equals(adminEntity.getPasswordMd5())) {
			return new BusinessResult<>(null,BusinessResult.loginInvalid,"用户名或密码错误");
		}
		request.getSession().setAttribute("userId", adminEntity.getId());
//		request.getSession().setMaxInactiveInterval(10*60);
		responseData.put("result", "1");
		responseData.put("userName", adminEntity.getName());
		return new BusinessResult<>(responseData);
	}
	
	@RequestMapping(path="/regist",method=RequestMethod.POST)
	@ResponseBody
	public BusinessResult<Object> regist(@RequestBody AdminUser user,HttpServletRequest request){
		Map<String, Object> responseData = new HashMap<String,Object>();
		AdminEntity adminEntity = loginMapper.getUser(user.getName());
		if(adminEntity !=null){
			return new BusinessResult<>(null,BusinessResult.usernameExist,"用户名存在");
		}
		if (user.getPassword().length()<6) {
			return new BusinessResult<>(null,BusinessResult.passwordShort,"密码太简单");
		}
		AdminEntity admin = new AdminEntity();
		String salt = UUID.randomUUID().toString();
		String passwordMd5 = getMd5(user.getPassword() + salt);
		admin.setName(user.getName());
		admin.setSalt(salt);
		admin.setPasswordMd5(passwordMd5);
		admin.setCreated(new Date().getTime());
		admin.setUpdated(new Date().getTime());
		loginMapper.insertUser(admin);
		request.getSession().setAttribute("userId", admin.getId());
		responseData.put("result", "1");
		responseData.put("userName", admin.getName());
		return new BusinessResult<>(responseData);
	}
	
	public static String getMd5(byte[] data) {
		return DigestUtils.md5Hex(data);
	}
	
	public static String getMd5(String data) {
		return DigestUtils.md5Hex(data.getBytes());
	}
}
