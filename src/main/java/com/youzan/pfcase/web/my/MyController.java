package com.youzan.pfcase.web.my;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.javassist.runtime.Desc;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.DefaultEventListenerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.youzan.pfcase.conf.BusinessResult;
import com.google.common.base.Function;
import com.google.common.collect.Maps;
import com.youzan.pfcase.conf.SysProperties;
import com.youzan.pfcase.domain.Caselist;
import com.youzan.pfcase.domain.Dapps;
import com.youzan.pfcase.domain.DappsWechat;
import com.youzan.pfcase.domain.Groups;
import com.youzan.pfcase.domain.Picture;
import com.youzan.pfcase.domain.Task;
import com.youzan.pfcase.domain.Taskcase;
import com.youzan.pfcase.domain.UserDetails;
import com.youzan.pfcase.mapper.CaselistMapper;
import com.youzan.pfcase.mapper.DappsMapper;
import com.youzan.pfcase.mapper.GroupsMapper;
import com.youzan.pfcase.mapper.PicMapper;
import com.youzan.pfcase.mapper.RecommendMapper;
import com.youzan.pfcase.service.AccountService;
import com.youzan.pfcase.service.CaselistService;
import com.youzan.pfcase.service.TaskService;
import com.youzan.pfcase.service.TaskcaseService;
import com.youzan.pfcase.util.AES;

@Controller
@RequestMapping("/")
public class MyController {

	private List<Task> allTask;
	
	public static int pageLimit = SysProperties.getInstance().getIntProperty("page_limit");
	
	@Autowired
	protected AccountService accountService;

	@Autowired
	protected TaskService taskService;

	@Autowired
	protected TaskcaseService taskcaseService;

	@Autowired
	protected CaselistService caselistService;

	@RequestMapping(value = "my", method = RequestMethod.GET)
	public String my(ModelMap model) throws Exception {
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username = userDetails.getAccount().getUsername();
		String role = userDetails.getAccount().getRole();
		if (role.equals("admin") || role.equals("cs")) {
			allTask = taskService.getAllTask();
		} else {
			allTask = taskService.getAllTaskByUsername(username);
		}

		Map<String, Task> taskMap = Maps.uniqueIndex(allTask, new Function<Task, String>() {
			@Override
			public String apply(Task task) {
				return Integer.toString(task.getTaskid());
			}
		});
		model.addAttribute("taskMap", taskMap);

		//

		List<Taskcase> allTaskcase = taskcaseService.getAllTaskcase();
		Map<String, List<Taskcase>> taskcaseMap = new HashMap<String, List<Taskcase>>();
		for (Taskcase taskcase : allTaskcase) {
			String taskid = Integer.toString(taskcase.getTaskid());
			if (taskcaseMap.containsKey(taskid)) {
				taskcaseMap.get(taskid).add(taskcase);
			} else {
				List taskcaseList = new ArrayList<Taskcase>();
				taskcaseList.add(taskcase);
				taskcaseMap.put(Integer.toString(taskcase.getTaskid()), taskcaseList);
			}
		}
		model.addAttribute("taskcaseMap", taskcaseMap);

		//

		List<Caselist> allCaselist = caselistService.getAllCaselist();
		Map<String, Caselist> caselistMap = Maps.uniqueIndex(allCaselist, new Function<Caselist, String>() {
			@Override
			public String apply(Caselist caselist) {
				return Integer.toString(caselist.getCaseid());
			}
		});
		model.addAttribute("caselistMap", caselistMap);
		model.addAttribute("active_my", true);

		return "my";
	}
	
	
    @RequestMapping("testJson")
    public void testJson(HttpServletRequest request,HttpServletResponse reponse) {
      
        try{
        	reponse.getOutputStream().write("fewfewf".getBytes());
        }catch(Exception e){
        	e.printStackTrace();
        }
        
    }
    
    
    @RequestMapping("signonForm")
    public String signonForm() {
        return "account/SignonForm";
    }
    
    @Autowired
    private CaselistMapper caselistMapper;
    
    @Autowired
    private GroupsMapper groupsMapper;
    
    @RequestMapping("/UserBonusInfo")  //获得用户账户信息
    public @ResponseBody ResponseEntity<Object> UserBonusInfo(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
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
        		List groups = groupsMapper.getGroupsTw(offset,limit);
            	map.put("groups", groups);
        	}else if(lang.contains("en")) {
        		List groups = groupsMapper.getGroupsEn(offset,limit);
            	map.put("groups", groups);
        	}else if(lang.contains("ko")) {
        		List groups = groupsMapper.getGroupsKo(offset,limit);
            	map.put("groups", groups);
        	}else {
        		List groups = groupsMapper.getGroups(offset,limit);
            	map.put("groups", groups);
        	}
        	
        	
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    @RequestMapping("/getGroupByType")  //获得用户账户信息
    public @ResponseBody ResponseEntity<Object> getGroupByType(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);

        int type = 1;
        if(request.getParameter("type")!=null) {
        		type = Integer.parseInt(request.getParameter("type"));
        }
        try{
	        	List groups = groupsMapper.getGroupsByType(type);
	        	map.put("groups", groups);
	        	
	        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    @RequestMapping("/searchUserBonus")
    public @ResponseBody ResponseEntity<Object> searchUserBonus(HttpServletRequest request,HttpServletResponse response){
    	Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        Integer offset =0, limit = pageLimit;
    	String groupName=null;
        try{
        	if(request.getParameter("offset")!=null){
        		offset = Integer.parseInt(request.getParameter("offset"));
        		limit = Integer.parseInt(request.getParameter("limit"));
        	}
        	map.put("offset", offset);
        	map.put("limit", limit);
        	if (request.getParameter("groupName")!=null) {
        		groupName="%"+request.getParameter("groupName").trim()+"%";
			}
        	map.put("groupName", groupName);
        	List groups = groupsMapper.searchGroups(map);
        	map.put("groups", groups);
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
    }
    
    @RequestMapping("/getAutoGroupsAlly")
    public @ResponseBody ResponseEntity<Object> getAutoGroupsAlly(HttpServletRequest request,HttpServletResponse response){
    	Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        List<String> autoGroups=new LinkedList<String>();
        
        String lang = "en";
        try {
        		if(request.getParameter("lang")!=null) {
        			lang = request.getParameter("lang");
        		}
			String auto_groups=SysProperties.getInstance().getProperty("auto_groups_ally");
			String auto_groups_en = SysProperties.getInstance().getProperty("auto_groups_ally_en");
			String auto_groups_ko = SysProperties.getInstance().getProperty("auto_groups_ally_ko");
			
			if(lang.contains("zh")) {
				JSONArray groups=new JSONArray(auto_groups);
				for (int i = 0; i < groups.length(); i++) {
					autoGroups.add(groups.getString(i));
				}
			}else if(lang.contains("ko")){
				JSONArray groupsKo=new JSONArray(auto_groups_ko);
				for (int i = 0; i < groupsKo.length(); i++) {
					autoGroups.add(groupsKo.getString(i));
				}
			}else {
				JSONArray groupsEn=new JSONArray(auto_groups_en);
				for (int i = 0; i < groupsEn.length(); i++) {
					autoGroups.add(groupsEn.getString(i));
				}
			}
			
			map.put("result", "1");
			map.put("autoGroups", autoGroups);
		} catch (Exception e) {
			e.printStackTrace();
            map.put("result", -2);
		}
        return re;
    }
    
    @RequestMapping("/getAutoGroups")
    public @ResponseBody ResponseEntity<Object> groupsUrl(HttpServletRequest request,HttpServletResponse response){
    	Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        List<String> autoGroups=new LinkedList<String>();
        
        String lang = "en";
        try {
        		if(request.getParameter("lang")!=null) {
        			lang = request.getParameter("lang");
        		}
			String auto_groups=SysProperties.getInstance().getProperty("auto_groups");
			String auto_groups_en = SysProperties.getInstance().getProperty("auto_groups_en");
			
			if(lang.contains("zh")) {
				JSONArray groups=new JSONArray(auto_groups);
				for (int i = 0; i < groups.length(); i++) {
					autoGroups.add(groups.getString(i));
				}
			}else {
				JSONArray groupsEn=new JSONArray(auto_groups_en);
				for (int i = 0; i < groupsEn.length(); i++) {
					autoGroups.add(groupsEn.getString(i));
				}
			}
			
			map.put("result", "1");
			map.put("autoGroups", autoGroups);
		} catch (Exception e) {
			e.printStackTrace();
            map.put("result", -2);
		}
        return re;
    }
    
    @RequestMapping("/getVersions")
    public @ResponseBody ResponseEntity<Object> getVersions(HttpServletRequest request,HttpServletResponse response){
    	Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        try {
			String android_version=SysProperties.getInstance().getProperty("android_version");
			String ios_version=SysProperties.getInstance().getProperty("ios_version");
			String android_text=SysProperties.getInstance().getProperty("android_text");
			String ios_text=SysProperties.getInstance().getProperty("ios_text");		
			List<String> androidList = Arrays.asList(android_text.split(",|，"));
			List<String> iosList = Arrays.asList(ios_text.split(",|，"));
			map.put("result", "1");
			map.put("android_version", android_version);
			map.put("android_text", androidList);
			map.put("ios_version", ios_version);
			map.put("ios_text", iosList);
		} catch (Exception e) {
			e.printStackTrace();
            map.put("result", -2);
		}
        return re;
    }

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
            	List<Dapps> dapps = dappsMapper.getDapps(offset,limit);
            	if(dapps != null){
            		for(int i=0; i<dapps.size(); i++){
            			if(dapps.get(i).getDappname().equals("行情")){
            				dapps.remove(i);
            				i--;
            			}
            		}
            	}
            	map.put("dapps", dapps);
        	}
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return new BusinessResult<>(map);
        
    }
    
    @CrossOrigin
    @RequestMapping("/dappsWechat")  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> dappsWechat(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
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
        		List dappsWechat = dappsMapper.getDappsWechatTw(offset,limit);
            	map.put("dappsWechat", dappsWechat);
        	}else if(lang.contains("en")) {
        		List dappsWechat = dappsMapper.getDappsWechatEn(offset,limit);
            	map.put("dappsWechat", dappsWechat);
        	}else if(lang.contains("ko")) {
        		List dappsWechat = dappsMapper.getDappsWechatKo(offset,limit);
            	map.put("dappsWechat", dappsWechat);
        	}else {
        		List dappsWechat = dappsMapper.getDappsWechat(offset,limit);
            	map.put("dappsWechat", dappsWechat);
        	}
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return new BusinessResult<>(map);
        
    }
    
    @CrossOrigin
    @RequestMapping("/dappsWechatGroup")  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> dappsWechatGroup(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        Integer offset =0, limit = pageLimit;
        
        try{
        	if(request.getParameter("offset")!=null){
        		offset = Integer.parseInt(request.getParameter("offset"));
        		limit = Integer.parseInt(request.getParameter("limit"));
        	}
        	
        	List<DappsWechat> dappsWechat = dappsMapper.getDappsWechat(offset,limit);
        	List<Integer> groups = dappsMapper.getGroups();
        	List dappsWechatGroup = new ArrayList<>();
        	for(Integer group : groups){
        		List<DappsWechat> dList = new ArrayList<DappsWechat>();
        		for(DappsWechat d : dappsWechat){
        			if(d.getDappgroup()==group){
        				dList.add(d);		
        			}
        		}
        		dappsWechatGroup.add(dList);
        	}
        	map.put("dappsWechatGroup", dappsWechatGroup);
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return new BusinessResult<>(map);
        
    }
    
    @Autowired
    private PicMapper picMapper;
    @CrossOrigin
    @RequestMapping(path="/pics",method=RequestMethod.GET)  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> pics(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        Integer offset =0, limit = pageLimit;
        
        String lang = "zh";
        try {
        	if(request.getParameter("offset")!=null){
        		offset = Integer.parseInt(request.getParameter("offset"));
        		limit = Integer.parseInt(request.getParameter("limit"));
        	}
        	if(request.getParameter("lang")!=null) {
    			lang = request.getParameter("lang");
    		}
        	if(lang.contains("tw")) {
        		List pics = picMapper.getPicsTw(offset,limit);
        		map.put("pics", pics);
        	}else if(lang.contains("en")) {
        		List pics = picMapper.getPicsEn(offset,limit);
        		map.put("pics", pics);
        	}else if(lang.contains("ko")) {
        		List pics = picMapper.getPicsKo(offset,limit);
        		map.put("pics", pics);
        	}else {
        		List pics = picMapper.getPics(offset,limit);
        		map.put("pics", pics);
        	}
        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return new BusinessResult<>(map);    
    }
    
    @CrossOrigin
    @RequestMapping(path="/imgUpdate",method=RequestMethod.POST)  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> updatePic(@RequestBody Picture picture,@RequestParam("lang") String lang,HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        
        try{
        	Picture pic=new Picture();
        	pic.setId(picture.getId());
        	pic.setName(picture.getName());
        	pic.setLink(picture.getLink());
        	pic.setLinktype(picture.getLinktype());
        	pic.setIcon(picture.getIcon());
        	pic.setUpdatetime(new Timestamp(new Date().getTime()));
        	if("tw".equals(lang)) {
        		picMapper.imgUpdateTw(pic);
        		map.put("result", 1);
        	}else if("en".equals(lang)) {
        		picMapper.imgUpdateEn(pic);
        		map.put("result", 1);
        	}else if("ko".equals(lang)) {
        		picMapper.imgUpdateKo(pic);
        		map.put("result", 1);
        	}else {
        		picMapper.imgUpdate(pic);
        		map.put("result", 1);
        	} 
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -1);
                map.put("msg", "更新图片失败");
        }
        return new BusinessResult<>(map);
        
    }
    @CrossOrigin
    @RequestMapping(path="/dappUpdate",method=RequestMethod.POST)  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> dappUpdate(@RequestBody Picture picture,@RequestParam("lang") String lang,HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        
        try{
        	Dapps dapp=new Dapps();
        	dapp.setDappid(picture.getId());
        	dapp.setDappname(picture.getName());
        	dapp.setDappicon(picture.getIcon());
        	dapp.setDapplink(picture.getLink());
        	dapp.setUpdatetime(new Timestamp(new Date().getTime())); 
        	if("tw".equals(lang)) {
        		dappsMapper.dappUpdateTw(dapp);
        		map.put("result", 1);
        	}else if("en".equals(lang)) {
        		dappsMapper.dappUpdateEn(dapp);
        		map.put("result", 1);
        	}else if("ko".equals(lang)) {
        		dappsMapper.dappUpdateKo(dapp);
        		map.put("result", 1);
        	}else {
        		dappsMapper.dappUpdate(dapp);
        		map.put("result", 1);
        	}
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -1);
                map.put("msg", "更新图片失败");
        }
        return new BusinessResult<>(map);
        
    }
    
    @CrossOrigin
    @RequestMapping(path="/dappsWechatUpdate",method=RequestMethod.POST)  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> dappsWechatUpdate(@RequestBody Picture picture,@RequestParam("lang") String lang,HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        try{
        	DappsWechat dappsWechat=new DappsWechat();
        	dappsWechat.setDappid(picture.getId());
        	dappsWechat.setDappname(picture.getName());
        	dappsWechat.setDappicon(picture.getIcon());
        	dappsWechat.setDapplink(picture.getLink());
        	dappsWechat.setUpdatetime(new Timestamp(new Date().getTime()));
        	if("tw".equals(lang)) {
        		dappsMapper.dappsWechatUpdateTw(dappsWechat);
        		map.put("result", 1);
        	}else if("en".equals(lang)) {
        		dappsMapper.dappsWechatUpdateEn(dappsWechat);
        		map.put("result", 1);
        	}else if("ko".equals(lang)) {
        		dappsMapper.dappsWechatUpdateKo(dappsWechat);
        		map.put("result", 1);
        	}else {
        		dappsMapper.dappsWechatUpdate(dappsWechat);
        		map.put("result", 1);
        	}	
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -1);
                map.put("msg", "更新图片失败");
        }
        return new BusinessResult<>(map);
        
    }
    @CrossOrigin
    @RequestMapping(path="/groupUpdate",method=RequestMethod.POST)  //获得用户账户信息
    public @ResponseBody BusinessResult<Object> groupUpdate(@RequestBody Picture picture,@RequestParam("lang") String lang,HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        
        try{
        	Groups group=new Groups();
        	group.setGroupid(picture.getId());
        	group.setGroupicon(picture.getIcon());
        	group.setGrouplink(picture.getLink());
        	group.setGroupname(picture.getName());
        	group.setUpdatetime(new Timestamp(new Date().getTime()));
        	if("tw".equals(lang)) {
        		groupsMapper.groupUpdateTw(group);
        		map.put("result", 1);
        	}else if("en".equals(lang)) {
        		groupsMapper.groupUpdateEn(group);
        		map.put("result", 1);
        	}else if("ko".equals(lang)) {
        		groupsMapper.groupUpdateKo(group);
        		map.put("result", 1);
        	}else {
        		groupsMapper.groupUpdate(group);
        		map.put("result", 1);
        	}
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -1);
                map.put("msg", "更新图片失败");
        }
        return new BusinessResult<>(map);
        
    }
    @RequestMapping(path = "/upload", method = RequestMethod.POST)
    @CrossOrigin
    public @ResponseBody BusinessResult<Object> addPic(@RequestParam("image") MultipartFile file,HttpServletRequest request) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	if (file == null) {
			 map.put("result", -2);
	         map.put("msg", "上传图片为空");
	         throw new Exception("上传失败：文件为空");    
	    }
    	String data=request.getParameter("type");
        if(file.getSize()>10000000) {
	    	 map.put("result", -3);
	         map.put("msg", "图片过大");
	         throw new Exception("上传失败：文件大小不能超过10M");            
	    }
        UUID uuid = UUID.randomUUID();
//        String baseUrl="c://mfw/img/";
        String baseUrl="/home/ec2-user/chat-web/images/pics/";
        switch(data){
        case "pic":baseUrl="/home/ec2-user/chat-web/images/pics/";break;
        case "dapps":baseUrl="/home/ec2-user/chat-web/images/dapps/";break;
        case "groups":baseUrl="/home/ec2-user/chat-web/images/groups/";break;
        case "dappswx":baseUrl="/home/ec2-user/chat-web/images/dapps_wechat/";break;
        }
        String filePath =baseUrl+uuid+file.getOriginalFilename();
	    File desFile = new File(filePath);
	    if(!desFile.getParentFile().exists()){  	 
            desFile.getParentFile().mkdirs();
        }
	    try {
	        file.transferTo(desFile);
	        desFile.setWritable(true,false);
		    desFile.setReadable(true,false);
		    desFile.setExecutable(true,false);
	        Picture pic=new Picture();
	        pic.setName(file.getOriginalFilename());
	        if(data.equals("groups")){
	        	pic.setIcon(uuid + file.getOriginalFilename());
	        }else{
	        	if(data.equals("pic")){
	        		pic.setIcon("http://xs.athena.pub/images/pics/" + uuid + file.getOriginalFilename());
	        	}
	        	if(data.equals("dapps")){
	        		pic.setIcon("http://xs.athena.pub/images/dapps/" + uuid + file.getOriginalFilename());
	        	}
	        	if(data.equals("dappswx")){
	        		pic.setIcon("http://xs.athena.pub/images/dapps_wechat/" + uuid + file.getOriginalFilename());
	        	}
	        }  
	        map.put("result", 1);
	        map.put("pic", pic);
	    } catch (Exception e) {
	        e.printStackTrace();
	        map.put("result", -1);
	        map.put("msg", "上传图片失败");
	    }
	    return new BusinessResult<>(map);
    }
    @Autowired
    private RecommendMapper recommendMapper;
    @RequestMapping("/recommend")  //获得用户账户信息
    public @ResponseBody ResponseEntity<Object> recommend(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re =     new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        Integer offset =0, limit = pageLimit;
        
        try{
        	
	        	List recommend = recommendMapper.getAllRecommend();
	        	map.put("recommend", recommend);
	        	
	        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    @RequestMapping("/getProxyInfo")  //获得用户代理信息
    public @ResponseBody ResponseEntity<Object> getProxyInfo(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re = new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        
        try{
        		String proxy_ip = SysProperties.getInstance().getProperty("proxy_ip");
        		Boolean proxy_enabled = SysProperties.getInstance().getBooleanProperty("proxy_enabled",false);
        		int proxy_port  = SysProperties.getInstance().getIntProperty("proxy_port");
        		String proxy_username = SysProperties.getInstance().getProperty("proxy_username");
        		String proxy_password = SysProperties.getInstance().getProperty("proxy_password");

        	Map data = new HashMap<String,Object>();
	        data.put("proxy_ip", proxy_ip);
	        data.put("proxy_enabled", proxy_enabled);
	        data.put("proxy_port", proxy_port);
	        data.put("proxy_username", proxy_username);
	        data.put("proxy_password", proxy_password);
	        
	        String backup_ips = SysProperties.getInstance().getProperty("backup_ips");
	        String backup_ports = SysProperties.getInstance().getProperty("backup_ports");
	        JSONArray ips = new JSONArray(backup_ips);
	        JSONArray ports = new JSONArray(backup_ports);
	        
	        List backupProxys = new LinkedList<>();
	        for(int i=0;i<ips.length();i++) {
	        		Map elem = new HashMap<String,Object>();
	        		elem.put("proxy_ip", ips.get(i));
	        		elem.put("proxy_enabled", proxy_enabled);
	        		elem.put("proxy_port", ports.getInt(i));
	        		elem.put("proxy_username", proxy_username);
	        		elem.put("proxy_password", proxy_password);
	        		
	        		backupProxys.add(elem);
	        }
	        
	        map.put("backupProxys", backupProxys);
	        map.put("data", data);
	        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    @RequestMapping("/getProxyInfoSecure")  //获得用户代理信息
    public @ResponseBody ResponseEntity<Object> getProxyInfoSecure(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re = new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        
        try{
        		String proxy_ip = SysProperties.getInstance().getProperty("proxy_ip");
        		Boolean proxy_enabled = SysProperties.getInstance().getBooleanProperty("proxy_enabled",false);
        		int proxy_port  = SysProperties.getInstance().getIntProperty("proxy_port");
        		String proxy_username = SysProperties.getInstance().getProperty("proxy_username");
        		String proxy_password = SysProperties.getInstance().getProperty("proxy_password");
        		proxy_ip = AES.aesEncrypt(proxy_ip, AES.getKey());
        		String port = ""+proxy_port;
        		port = AES.aesEncrypt(port, AES.getKey());
        		proxy_username=AES.aesEncrypt(proxy_username, AES.getKey());
        		proxy_password=AES.aesEncrypt(proxy_password, AES.getKey());
	        Map data = new HashMap<String,Object>();
	        data.put("proxy_ip", proxy_ip);
	        data.put("proxy_enabled", proxy_enabled);
	        data.put("proxy_port", port);
	        data.put("proxy_username", proxy_username);
	        data.put("proxy_password", proxy_password);
	        
	        String backup_ips = SysProperties.getInstance().getProperty("backup_ips");
	        String backup_ports = SysProperties.getInstance().getProperty("backup_ports");
	        JSONArray ips = new JSONArray(backup_ips);
	        JSONArray ports = new JSONArray(backup_ports);
	        
	        List backupProxys = new LinkedList<>();
	        for(int i=0;i<ips.length();i++) {
	        		Map elem = new HashMap<String,Object>();
	        		elem.put("proxy_ip", AES.aesEncrypt((String)ips.get(i),AES.getKey()));
	        		elem.put("proxy_enabled", proxy_enabled);
	        		elem.put("proxy_port", AES.aesEncrypt(""+ports.getInt(i),AES.getKey()));
	        		elem.put("proxy_username", proxy_username);
	        		elem.put("proxy_password", proxy_password);
	        		
	        		backupProxys.add(elem);
	        }
	        
	        map.put("backupProxys", backupProxys);
	        map.put("data", data);
	        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    String getUrl(String content) {
    		String [] elems = content.split("<img class=\"tgme_page_photo_image\" src=\"");
    		if(elems == null || elems.length <= 1) {
    			return null;
    		}
    		String subElm = elems[1];
    		elems = subElm.split("\"></a>");
    		
    		return elems[0];
    }
    
    String getGroupName(String content) {
		String [] elems = content.split("<div class=\"tgme_page_title\">");
		String subElm = elems[1];
		elems = subElm.split("</div>");
		
		return elems[0];
    }
    
    String getGroupNumber(String content) {
		String [] elems = content.split("<div class=\"tgme_page_extra\">");
		String subElm = elems[1];
		elems = subElm.split("</div>");
		
		return elems[0];
    }
    
    @RequestMapping("/getGroupInfo")  //获得用户代理信息
    public @ResponseBody ResponseEntity<Object> getGroupInfo(HttpServletRequest request,HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re = new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        
        String groupKey = request.getParameter("key");
        System.out.println(groupKey + "groupKey");
        try{
        		
        	 	URL url = new URL("https://t.me/" + groupKey);
             HttpURLConnection httpUrl = (HttpURLConnection)url.openConnection();
             InputStream is = httpUrl.getInputStream();
             BufferedReader br = new BufferedReader(new InputStreamReader(is,"utf-8"));
             StringBuilder sb = new StringBuilder();
             String line;
             while ((line = br.readLine()) != null) {
                 //这里是对链接进行处理
                 line = line.replaceAll("</?a[^>]*>", "");
                 //这里是对样式进行处理
                 line = line.replaceAll("<(\\w+)[^>]*>", "<$1>");
                 sb.append(line);
             }
             is.close();
             br.close();
             
             String content = sb.toString();
             
             System.out.println(content + "content");
             String imageUrl = getUrl(content);
             String groupName = getGroupName(content);
             String groupNumber = getGroupNumber(content);
	        map.put("imageUrl", imageUrl);
	        map.put("groupName", groupName);
	        map.put("groupNumber", groupNumber);
	        	map.put("result", 1);
        } catch (Exception e) {
                e.printStackTrace();
                map.put("result", -2);
        }
        return re;
        
    }
    
    @RequestMapping("/getGroup")  //获得用户代理信息
    public @ResponseBody ResponseEntity<Object> getGroup(HttpServletRequest request,HttpServletResponse response) {
    
        Map<String, Object> map = new HashMap<String, Object>();
        HttpHeaders headers=new HttpHeaders();
        headers.add("Access-Control-Allow-Origin", "*");
        ResponseEntity<Object> re = new ResponseEntity<Object>(map, headers, HttpStatus.OK);
        
        String groupKey = request.getParameter("key");

        try{
    		
			 String cmdString = "wget  -v --output-document=/var/temp.info https://t.me/" + groupKey;
              System.out.println( cmdString );
              Runtime rt = Runtime.getRuntime();
              Process  p = rt.exec( cmdString );
              p.waitFor();
              
              File file = new File("/var/temp.info");
              
              FileReader reader = new FileReader(file);
              BufferedReader bReader = new BufferedReader(reader);
              StringBuilder sb = new StringBuilder();
              String s = "";
              while ((s =bReader.readLine()) != null) {
                  sb.append(s + "\n");
                  System.out.println(s);
              }
              bReader.close();
              
              String content = sb.toString();
              
              System.out.println(content + "content");
              String imageUrl = getUrl(content);
              String groupName = getGroupName(content);
              String groupNumber = getGroupNumber(content);
              if(imageUrl!=null) {
            	  	
            	  	
            	  		cmdString = "wget  -v --output-document=/root/images/" + groupKey + " --tries=3 " + imageUrl;
                    System.out.println( cmdString );
                    rt = Runtime.getRuntime();
                    p = rt.exec( cmdString );
                    p.waitFor();
                    
                    cmdString = "chmod 777 /root/images/" + groupKey;
                    rt = Runtime.getRuntime();
                    p = rt.exec( cmdString );
                    p.waitFor();
                    
                    map.put("imageUrl", "https://xs.athena.pub/images/" + groupKey);
              }
 	        map.put("groupName", groupName);
 	        map.put("groupNumber", groupNumber);
 	        	map.put("result", 1);
 	        	
  	        	 map.put("result", 1);
          } catch (Exception e) {
                  e.printStackTrace();
                  map.put("result", -2);
          }
        
        return re;
    }
}