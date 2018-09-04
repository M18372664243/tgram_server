package com.youzan.pfcase.web.my;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youzan.pfcase.conf.BusinessResult;
import com.youzan.pfcase.conf.SysProperties;
import com.youzan.pfcase.domain.Dapps;
import com.youzan.pfcase.mapper.DappsMapper;

@Controller
@RequestMapping("v2")
public class NewController {
	
	public static int pageLimit = SysProperties.getInstance().getIntProperty("page_limit");
	
    @Autowired
    private DappsMapper dappsMapper;
    
    @CrossOrigin
    @RequestMapping("/dapps")  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> dapps(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
//        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        Integer offset =0, limit = pageLimit;
        String lang = "zh";
        try{
        	if(request.getParameter("offset")!=null){
        		offset = Integer.parseInt(request.getParameter("offset"));
        		limit = Integer.parseInt(request.getParameter("limit"));
        	}
        	if(request.getParameter("lang")!=null) {
    			lang = request.getParameter("lang");
    		}
        	if(lang.contains("tw")) {
        		List dapps = dappsMapper.getDappsTw(offset,limit);
            	map.put("dapps", dapps);
        	}else if(lang.contains("en")) {
        		List dapps = dappsMapper.getDappsEn(offset,limit);
            	map.put("dapps", dapps);
        	}else if(lang.contains("ko")) {
        		List dapps = dappsMapper.getDappsKo(offset,limit);
            	map.put("dapps", dapps);
        	}else {
            	List dapps = dappsMapper.getDapps(offset,limit);
            	map.put("dapps", dapps);
        	}
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return new BusinessResult<>(map);
        
    }
}
